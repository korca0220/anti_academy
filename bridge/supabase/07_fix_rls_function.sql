-- 1. Update function with strict search path for security and robustness
create or replace function public.is_chat_participant(_room_id uuid)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1
    from chat_participants
    where room_id = _room_id
    and user_id = auth.uid()
  );
$$;

-- 2. Explicitly Re-enable RLS on chat_messages (since we disabled it for testing)
alter table chat_messages enable row level security;

-- 3. Verify Publication again (Just in case)
alter publication supabase_realtime add table chat_messages;
