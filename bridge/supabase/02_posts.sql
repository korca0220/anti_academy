-- 1. Create Enums
create type public.post_type as enum ('request', 'offer');
create type public.post_status as enum ('open', 'in_progress', 'completed');

-- 2. Create posts table
create table public.posts (
  id uuid not null default gen_random_uuid(),
  author_id uuid not null references auth.users(id) on delete cascade,
  type post_type not null,
  title text not null,
  content text not null,
  status post_status not null default 'open',
  image_urls text[] default array[]::text[],
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  primary key (id)
);

-- 3. Enable RLS
alter table public.posts enable row level security;

-- 4. Create Policies

-- Read: Everyone can see posts
create policy "Public posts are viewable by everyone."
  on posts for select
  using ( true );

-- Insert: Only authenticated users can create posts
create policy "Authenticated users can create posts."
  on posts for insert
  with check ( auth.role() = 'authenticated' );

-- Update: Only author can update their own posts
create policy "Users can update own posts."
  on posts for update
  using ( auth.uid() = author_id );

-- Delete: Only author can delete their own posts
create policy "Users can delete own posts."
  on posts for delete
  using ( auth.uid() = author_id );

-- 5. Create Updated_at Trigger
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger on_posts_updated
  before update on public.posts
  for each row execute procedure public.handle_updated_at();
