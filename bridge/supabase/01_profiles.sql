-- 1. Create profiles table
create table public.profiles (
  id uuid not null references auth.users on delete cascade,
  nickname text,
  avatar_url text,
  bio text,
  created_at timestamptz default now(),
  primary key (id)
);

-- 2. Enable RLS
alter table public.profiles enable row level security;

-- 3. Create Policy (Public Read)
create policy "Public profiles are viewable by everyone."
  on profiles for select
  using ( true );

-- 4. Create Policy (Update own profile)
create policy "Users can insert their own profile."
  on profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on profiles for update
  using ( auth.uid() = id );

-- 5. Create Function for Trigger
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, nickname, avatar_url)
  values (
    new.id,
    new.raw_user_meta_data ->> 'nickname',
    new.raw_user_meta_data ->> 'avatar_url'
  );
  return new;
end;
$$;

-- 6. Create Trigger
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
