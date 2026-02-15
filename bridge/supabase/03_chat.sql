-- 1. Create chat_rooms table
create table public.chat_rooms (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now()
);

-- 2. Create chat_participants table
create table public.chat_participants (
  room_id uuid references public.chat_rooms(id) on delete cascade not null,
  user_id uuid references auth.users(id) on delete cascade not null,
  joined_at timestamptz default now(),
  primary key (room_id, user_id)
);

-- 3. Create chat_messages table
create table public.chat_messages (
  id uuid default gen_random_uuid() primary key,
  room_id uuid references public.chat_rooms(id) on delete cascade not null,
  sender_id uuid references auth.users(id) on delete cascade not null,
  content text not null,
  created_at timestamptz default now()
);

-- 4. Enable RLS
alter table public.chat_rooms enable row level security;
alter table public.chat_participants enable row level security;
alter table public.chat_messages enable row level security;

-- 5. Policies

-- Chat Rooms: Visible if you are a participant
create policy "Users can view chat rooms they are in"
  on chat_rooms for select
  using (
    exists (
      select 1 from chat_participants
      where room_id = chat_rooms.id
      and user_id = auth.uid()
    )
  );

-- Chat Participants: Viewable if you are in the room (to see other member)
create policy "Users can view participants in their rooms"
  on chat_participants for select
  using (
    exists (
      select 1 from chat_participants as my_p
      where my_p.room_id = chat_participants.room_id
      and my_p.user_id = auth.uid()
    )
  );
  
-- Chat Messages: Viewable if you are in the room
create policy "Users can view messages in their rooms"
  on chat_messages for select
  using (
    exists (
      select 1 from chat_participants
      where room_id = chat_messages.room_id
      and user_id = auth.uid()
    )
  );

-- Chat Messages: Insert if you are in the room AND sender is you
create policy "Users can insert messages in their rooms"
  on chat_messages for insert
  with check (
    auth.uid() = sender_id
    and exists (
      select 1 from chat_participants
      where room_id = chat_messages.room_id
      and user_id = auth.uid()
    )
  );

-- 6. Helper Function: create_or_get_chat_room
-- Finds an existing 1:1 room or creates a new one
create or replace function public.create_or_get_chat_room(other_user_id uuid)
returns uuid
language plpgsql
security definer
as $$
declare
  room_id_found uuid;
  current_user_id uuid := auth.uid();
begin
  -- 1. Check if room exists between these two users
  select r.id into room_id_found
  from chat_rooms r
  join chat_participants p1 on r.id = p1.room_id
  join chat_participants p2 on r.id = p2.room_id
  where p1.user_id = current_user_id
  and p2.user_id = other_user_id;

  -- 2. If exists, return it
  if room_id_found is not null then
    return room_id_found;
  end if;

  -- 3. If not, create new room and add participants
  insert into chat_rooms (id) values (default) returning id into room_id_found;
  
  insert into chat_participants (room_id, user_id) values 
    (room_id_found, current_user_id),
    (room_id_found, other_user_id);

  return room_id_found;
end;
$$;
