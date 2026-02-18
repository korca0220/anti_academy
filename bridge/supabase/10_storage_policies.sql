-- Make sure the bucket exists (idempotent)
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do nothing;

-- Enable RLS on storage.objects (usually enabled by default)
alter table storage.objects enable row level security;

-- 1. INSERT (Upload): Allow updated users to upload to their own folder
create policy "Users can upload their own avatar"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = auth.uid()::text
);

-- 2. UPDATE: Allow users to update their own avatar
create policy "Users can update their own avatar"
on storage.objects for update
to authenticated
using (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = auth.uid()::text
);

-- 3. SELECT: Allow everyone to view avatars (Public access)
create policy "Anyone can view avatars"
on storage.objects for select
to public
using ( bucket_id = 'avatars' );

-- 4. DELETE: Allow users to delete their own avatar
create policy "Users can delete their own avatar"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = auth.uid()::text
);
