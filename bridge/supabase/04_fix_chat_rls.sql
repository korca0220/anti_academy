-- 1. Helper Function to break recursion (Security Definer queries table without triggering RLS)
create or replace function public.is_chat_participant(_room_id uuid)
returns boolean
language sql
security definer
as $$
  select exists (
    select 1
    from chat_participants
    where room_id = _room_id
    and user_id = auth.uid()
  );
$$;

-- 2. Drop old policies (if they exist)
drop policy if exists "Users can view chat rooms they are in" on chat_rooms;
drop policy if exists "Users can view participants in their rooms" on chat_participants;
drop policy if exists "Users can view messages in their rooms" on chat_messages;
drop policy if exists "Users can insert messages in their rooms" on chat_messages;

-- 3. Re-create policies with helper function

-- Chat Rooms
create policy "Users can view chat rooms they are in"
  on chat_rooms for select
  using ( is_chat_participant(id) );

-- Chat Participants
create policy "Users can view participants in their rooms"
  on chat_participants for select
  using ( is_chat_participant(room_id) );

-- Chat Messages (Select)
create policy "Users can view messages in their rooms"
  on chat_messages for select
  using ( is_chat_participant(room_id) );
  
-- Chat Messages (Insert)
create policy "Users can insert messages in their rooms"
  on chat_messages for insert
  with check (
    auth.uid() = sender_id
    and is_chat_participant(room_id)
  );
