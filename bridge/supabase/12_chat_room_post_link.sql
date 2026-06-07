-- =============================================================================
-- 12_chat_room_post_link.sql
-- Link chat rooms to posts and scope room creation by post_id
-- =============================================================================

-- 1) chat_rooms에 post_id 컬럼 추가
ALTER TABLE public.chat_rooms
ADD COLUMN IF NOT EXISTS post_id uuid REFERENCES public.posts(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_chat_rooms_post_id ON public.chat_rooms(post_id);

-- 2) RPC 재정의: 게시글 단위로 채팅방을 찾거나 생성
CREATE OR REPLACE FUNCTION public.create_or_get_chat_room(other_user_id uuid, post_id uuid)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  room_id_found uuid;
  current_user_id uuid := auth.uid();
BEGIN
  -- 같은 상대 + 같은 게시글이면 기존 방 재사용
  SELECT r.id INTO room_id_found
  FROM chat_rooms r
  JOIN chat_participants p1 ON r.id = p1.room_id
  JOIN chat_participants p2 ON r.id = p2.room_id
  WHERE p1.user_id = current_user_id
    AND p2.user_id = other_user_id
    AND r.post_id = create_or_get_chat_room.post_id
  LIMIT 1;

  IF room_id_found IS NOT NULL THEN
    RETURN room_id_found;
  END IF;

  -- 없으면 새 방 생성 후 참여자 등록
  INSERT INTO chat_rooms (id, post_id)
  VALUES (DEFAULT, create_or_get_chat_room.post_id)
  RETURNING id INTO room_id_found;

  INSERT INTO chat_participants (room_id, user_id)
  VALUES
    (room_id_found, current_user_id),
    (room_id_found, other_user_id);

  RETURN room_id_found;
END;
$$;
