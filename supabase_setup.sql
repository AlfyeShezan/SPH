-- ============================================================
-- AULIA – Menstrual Calendar (Versi Tanpa Login)
-- Supabase PostgreSQL Setup Script
-- Jalankan di: Supabase Dashboard → SQL Editor → New Query → Run
-- ============================================================

-- 1. Buat tabel menstrual_records tanpa foreign key ke auth.users
CREATE TABLE IF NOT EXISTS public.menstrual_records (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  start_date   DATE NOT NULL,
  end_date     DATE,
  record_type  TEXT NOT NULL CHECK (record_type IN ('menstruasi', 'flek', 'lainnya')),
  notes        TEXT,
  needs_review BOOLEAN DEFAULT FALSE,
  created_at   TIMESTAMPTZ DEFAULT NOW(),
  updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Index untuk performa sorting kalender dan filter
CREATE INDEX IF NOT EXISTS idx_records_start_date ON public.menstrual_records(start_date DESC);
CREATE INDEX IF NOT EXISTS idx_records_type       ON public.menstrual_records(record_type);

-- 3. Hak akses role anon & authenticated ke schema dan tabel
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON TABLE public.menstrual_records TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- 4. Aktifkan Row Level Security (RLS) dan beri akses penuh untuk anon public
ALTER TABLE public.menstrual_records ENABLE ROW LEVEL SECURITY;

-- Policy: Izinkan baca data publik
CREATE POLICY "Public Read"
  ON public.menstrual_records FOR SELECT
  TO anon, authenticated
  USING (true);

-- Policy: Izinkan tambah data
CREATE POLICY "Public Insert"
  ON public.menstrual_records FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Policy: Izinkan perbarui data
CREATE POLICY "Public Update"
  ON public.menstrual_records FOR UPDATE
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- Policy: Izinkan hapus data
CREATE POLICY "Public Delete"
  ON public.menstrual_records FOR DELETE
  TO anon, authenticated
  USING (true);

-- 4. Masukkan seluruh 29 Data Asli Aulia ke database
INSERT INTO public.menstrual_records (start_date, end_date, record_type, notes, needs_review)
VALUES
  ('2024-12-17', '2025-01-03', 'menstruasi', '', FALSE),
  ('2025-01-13', '2025-01-29', 'menstruasi', '', FALSE),
  ('2025-02-06', '2025-02-18', 'menstruasi', '', FALSE),
  ('2025-03-01', '2025-03-10', 'menstruasi', '', FALSE),
  ('2025-03-23', '2025-04-02', 'menstruasi', '', FALSE),
  ('2025-04-17', '2025-04-25', 'menstruasi', '', FALSE),
  ('2025-05-10', '2025-05-20', 'menstruasi', '', FALSE),
  ('2025-05-31', '2025-06-13', 'menstruasi', '', FALSE),
  ('2025-06-25', '2025-07-05', 'menstruasi', '', FALSE),
  ('2025-07-15', '2025-07-24', 'menstruasi', '', FALSE),
  ('2025-08-05', '2025-08-11', 'menstruasi', '', FALSE),
  ('2025-08-23', '2025-09-02', 'menstruasi', '', FALSE),
  ('2025-08-14', '2025-09-23', 'menstruasi', 'Data asli: 14-08-2025 s/d 23-09-2025 — kemungkinan typo, harusnya 14-09-2025', TRUE),
  ('2025-10-07', '2025-10-17', 'menstruasi', '', FALSE),
  ('2025-10-31', '2025-11-12', 'menstruasi', '', FALSE),
  ('2026-10-26', '2025-12-05', 'menstruasi', 'Data asli: 26-10-2026 s/d 05-12-2025 — tanggal tidak valid', TRUE),
  ('2025-12-20', '2026-01-01', 'menstruasi', '', FALSE),
  ('2026-01-14', '2026-01-25', 'menstruasi', '', FALSE),
  ('2026-02-08', '2025-02-16', 'menstruasi', 'Data asli: 08-02-2026 s/d 16-02-2025 — tahun end kemungkinan typo, harusnya 2026', TRUE),
  ('2026-02-27', '2026-03-12', 'menstruasi', '', FALSE),
  ('2026-03-24', '2026-04-03', 'menstruasi', '', FALSE),
  ('2026-04-19', '2026-04-27', 'menstruasi', '', FALSE),
  ('2026-05-07', '2026-05-22', 'menstruasi', '', FALSE),
  ('2026-06-12', '2026-06-12', 'flek',       'Flek saja', FALSE),
  ('2026-06-24', '2026-07-02', 'menstruasi', '', FALSE),
  ('2026-08-01', '2026-08-07', 'menstruasi', '', FALSE),
  ('2026-09-09', '2026-09-15', 'menstruasi', '', FALSE),
  ('2026-10-05', '2026-10-18', 'menstruasi', '', FALSE),
  ('2025-11-16', '2026-11-23', 'menstruasi', 'Data asli: 16-11-2025 s/d 23-11-2026 — rentang hampir 1 tahun, kemungkinan typo', TRUE);
