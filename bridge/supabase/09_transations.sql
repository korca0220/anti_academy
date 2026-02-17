-- =============================================================================
-- 09_transactions.sql
-- Bridge Phase 4 (Transaction Feature) Foundation
-- Assumptions:
-- - post_status enum exists with: open, in_progress, completed
-- - chat function exists: public.is_chat_participant(uuid)
-- - chat tables: chat_rooms, chat_participants
-- - post table exists: posts
-- =============================================================================

-- 1) 거래 상태 ENUM
CREATE TYPE IF NOT EXISTS public.transaction_status AS ENUM (
  'proposed',
  'accepted',
  'in_progress',
  'completed',
  'canceled'
);

-- 2) 거래 테이블 (채팅방당 1개 거래 보장: room_id UNIQUE)
CREATE TABLE IF NOT EXISTS public.transactions (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  room_id uuid NOT NULL REFERENCES public.chat_rooms(id) ON DELETE CASCADE,
  post_id uuid REFERENCES public.posts(id) ON DELETE SET NULL,
  requester_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  provider_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  status public.transaction_status NOT NULL DEFAULT 'proposed',
  updated_by uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  cancel_reason text,
  closed_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  CONSTRAINT transactions_room_id_key UNIQUE (room_id)
);

-- 3) 조회 성능 인덱스
CREATE INDEX IF NOT EXISTS idx_transactions_room_id ON public.transactions(room_id);
CREATE INDEX IF NOT EXISTS idx_transactions_status ON public.transactions(status);
CREATE INDEX IF NOT EXISTS idx_transactions_requester_id ON public.transactions(requester_id);
CREATE INDEX IF NOT EXISTS idx_transactions_provider_id ON public.transactions(provider_id);
CREATE INDEX IF NOT EXISTS idx_transactions_post_id ON public.transactions(post_id);

-- 4) updated_at / closed_at 정합성 함수
CREATE OR REPLACE FUNCTION public.set_transaction_audit_fields()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- 모든 수정 시 updated_at 갱신
  NEW.updated_at := now();
  -- 상태가 변경될 때만 closed_at 규칙 적용
  IF TG_OP = 'UPDATE' THEN
    -- 상태가 종료 상태로 바뀌면 종료 시각 기록
    IF NEW.status IN ('completed', 'canceled') AND OLD.status IS DISTINCT FROM NEW.status THEN
      NEW.closed_at := now();
    -- 비종료 상태로 바뀌면 종료 시각 정리
    ELSIF NEW.status NOT IN ('completed', 'canceled') THEN
      NEW.closed_at := NULL;
    -- 종료 상태가 유지될 경우 기존 값 유지
    ELSE
      NEW.closed_at := OLD.closed_at;
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_transactions_audit_fields ON public.transactions;
CREATE TRIGGER trg_transactions_audit_fields
  BEFORE INSERT OR UPDATE ON public.transactions
  FOR EACH ROW
  EXECUTE FUNCTION public.set_transaction_audit_fields();

-- 5) 상태 전이 유효성 검증 (보호 장치)
CREATE OR REPLACE FUNCTION public.validate_transaction_status_transition()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- insert: 기본 제약은 DB 기본값 사용 (원하면 여기서도 제약 가능)
  IF TG_OP = 'UPDATE' AND NEW.status IS DISTINCT FROM OLD.status THEN
    IF NOT (
      (OLD.status = 'proposed'   AND NEW.status IN ('accepted', 'canceled')) OR
      (OLD.status = 'accepted'   AND NEW.status IN ('in_progress', 'canceled')) OR
      (OLD.status = 'in_progress' AND NEW.status IN ('completed', 'canceled')) OR
      (OLD.status IN ('completed', 'canceled') AND NEW.status = 'proposed') OR -- Allow re-opening
      (NEW.status IN ('completed', 'canceled')) -- 방어적 중복 방지
    ) THEN
      RAISE EXCEPTION 'Invalid transaction status transition: % -> %', OLD.status, NEW.status
        USING ERRCODE = 'check_violation';
    END IF;
    -- 종료 상태에서 재변경 금지 로직 제거 (재거래 허용을 위해)
    -- IF OLD.status IN ('completed', 'canceled') AND NEW.status IS DISTINCT FROM OLD.status THEN
    --   RAISE EXCEPTION 'Cannot change status after transaction is closed.'
    --     USING ERRCODE = 'check_violation';
    -- END IF;
  END IF;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_transactions_validate_status ON public.transactions;
CREATE TRIGGER trg_transactions_validate_status
  BEFORE INSERT OR UPDATE OF status ON public.transactions
  FOR EACH ROW
  EXECUTE FUNCTION public.validate_transaction_status_transition();

-- 6) 거래 상태 변경 시 posts.status 자동 동기화 (post_status: open/in_progress/completed)
CREATE OR REPLACE FUNCTION public.sync_transaction_status_to_post()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_post_status public.post_status;
BEGIN
  IF NEW.post_id IS NULL THEN
    RETURN NEW;
  END IF;
  CASE NEW.status
    WHEN 'in_progress' THEN
      v_post_status := 'in_progress';
    WHEN 'completed' THEN
      v_post_status := 'completed';
    ELSE
      -- proposed, accepted, canceled -> open로 매핑 (canceled은 post_status enum 미포함 가정)
      v_post_status := 'open';
  END CASE;
  UPDATE public.posts
  SET
    status = v_post_status,
    updated_at = now()
  WHERE id = NEW.post_id;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_sync_transaction_status_to_post ON public.transactions;

CREATE TRIGGER trg_sync_transaction_status_to_post
  AFTER INSERT OR UPDATE OF status ON public.transactions
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_transaction_status_to_post();

-- 7) RLS 적용
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users can view transactions in their rooms" ON public.transactions;
DROP POLICY IF EXISTS "Users can insert transactions in their rooms" ON public.transactions;
DROP POLICY IF EXISTS "Users can update transactions in their rooms" ON public.transactions;

CREATE POLICY "Users can view transactions in their rooms"
  ON public.transactions FOR SELECT
  USING (public.is_chat_participant(room_id));

CREATE POLICY "Users can insert transactions in their rooms"
  ON public.transactions FOR INSERT
  WITH CHECK (
    auth.uid() = requester_id
    AND public.is_chat_participant(room_id)
  );

CREATE POLICY "Users can update transactions in their rooms"
  ON public.transactions FOR UPDATE
  USING (public.is_chat_participant(room_id))
  WITH CHECK (public.is_chat_participant(room_id));


-- 8) 확인용 쿼리
-- SELECT typname FROM pg_type WHERE typname = 'transaction_status';
-- \d public.transactions;
-- SELECT * FROM pg_policies WHERE tablename = 'transactions';