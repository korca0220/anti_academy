-- =============================================================================
-- 11_reviews.sql
-- Bridge Phase 4 Extension: Review System (Skeleton)
-- =============================================================================

-- TODO: 리뷰 상태/정책이 확정되면 ENUM 도입 여부 재검토

-- 1) reviews 테이블
CREATE TABLE IF NOT EXISTS public.reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  transaction_id uuid NOT NULL REFERENCES public.transactions(id) ON DELETE CASCADE,
  room_id uuid NOT NULL REFERENCES public.chat_rooms(id) ON DELETE CASCADE,
  reviewer_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  reviewee_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  rating int NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  -- TODO: reviewer 기준 중복 방지 정책을 비즈니스 규칙에 맞게 확정
  CONSTRAINT reviews_unique_per_transaction_reviewer UNIQUE (transaction_id, reviewer_id),
  CONSTRAINT reviews_reviewer_not_reviewee CHECK (reviewer_id <> reviewee_id)
);

-- 2) 인덱스
CREATE INDEX IF NOT EXISTS idx_reviews_transaction_id ON public.reviews(transaction_id);
CREATE INDEX IF NOT EXISTS idx_reviews_reviewee_id ON public.reviews(reviewee_id);
CREATE INDEX IF NOT EXISTS idx_reviews_reviewer_id ON public.reviews(reviewer_id);

-- 3) updated_at 자동 갱신
CREATE OR REPLACE FUNCTION public.set_reviews_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_reviews_updated_at ON public.reviews;
CREATE TRIGGER trg_reviews_updated_at
  BEFORE UPDATE ON public.reviews
  FOR EACH ROW
  EXECUTE FUNCTION public.set_reviews_updated_at();

-- 4) RLS
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read reviews in their rooms" ON public.reviews;
DROP POLICY IF EXISTS "Users can insert own reviews in their rooms" ON public.reviews;

CREATE POLICY "Users can read reviews in their rooms"
  ON public.reviews FOR SELECT
  USING (public.is_chat_participant(room_id));

CREATE POLICY "Users can insert own reviews in their rooms"
  ON public.reviews FOR INSERT
  WITH CHECK (
    auth.uid() = reviewer_id
    AND public.is_chat_participant(room_id)
  );

-- TODO: 필요 시 UPDATE/DELETE 정책 추가 (현재는 작성 후 수정/삭제 제외)

-- 5) 확인용 쿼리
-- SELECT * FROM public.reviews LIMIT 10;
-- SELECT * FROM pg_policies WHERE tablename = 'reviews';
