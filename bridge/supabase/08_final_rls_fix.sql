-- 1. Update function ONLY (this resets search_path and Security Definer)
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

-- 2. Ensure RLS is enabled (if it was disabled for testing)
alter table chat_messages enable row level security;

-- 3. (Optional) Flush permissions
grant execute on function public.is_chat_participant(uuid) to authenticated;
grant execute on function public.is_chat_participant(uuid) to service_role;
