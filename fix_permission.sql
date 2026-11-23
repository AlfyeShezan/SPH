-- ============================================================
-- SOLUSI: GRANT PERMISSION SUPABASE
-- Jalankan skrip ini di Supabase Dashboard → SQL Editor → Run
-- ============================================================

-- 1. Berikan hak akses schema public ke role anon dan authenticated
GRANT USAGE ON SCHEMA public TO anon, authenticated;

-- 2. Berikan izin SELECT, INSERT, UPDATE, DELETE ke tabel menstrual_records
GRANT ALL ON TABLE public.menstrual_records TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- 3. Pastikan RLS mengizinkan operasi publik
ALTER TABLE public.menstrual_records ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public Read" ON public.menstrual_records;
DROP POLICY IF EXISTS "Public Insert" ON public.menstrual_records;
DROP POLICY IF EXISTS "Public Update" ON public.menstrual_records;
DROP POLICY IF EXISTS "Public Delete" ON public.menstrual_records;
DROP POLICY IF EXISTS "Allow All" ON public.menstrual_records;

-- Buat satu policy bebas untuk semua operasi
CREATE POLICY "Allow All"
  ON public.menstrual_records
  FOR ALL
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);
