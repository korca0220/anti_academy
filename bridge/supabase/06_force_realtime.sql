-- 1. Correct syntax: Remove from publication first (ignore error if not exists)
-- Try to drop first. If it fails (table not in publication), it's fine.
alter publication supabase_realtime drop table chat_messages;

-- 2. Add back to publication
alter publication supabase_realtime add table chat_messages;

-- 3. Verify
select * from pg_publication_tables 
where pubname = 'supabase_realtime' 
and tablename = 'chat_messages';
