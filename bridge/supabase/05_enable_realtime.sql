-- Enable Realtime for chat tables
alter publication supabase_realtime add table chat_rooms;
alter publication supabase_realtime add table chat_participants;
alter publication supabase_realtime add table chat_messages;
