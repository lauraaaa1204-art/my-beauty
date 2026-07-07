-- ====== 面部医美百科 - Supabase 数据库架构 ======

-- 1. 手术项目表
CREATE TABLE procedures (
  id TEXT PRIMARY KEY,
  region TEXT NOT NULL,
  region_name TEXT NOT NULL,
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('surgery','injection','dermatology')),
  description TEXT,
  duration TEXT,
  price_range TEXT,
  risks TEXT[],
  materials JSONB DEFAULT '[]',
  feedback JSONB,
  humanities JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. 材料库表
CREATE TABLE materials (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('injectable','implant','adjuvant','topical','device')),
  reversible TEXT,
  principle TEXT,
  brands TEXT,
  sites TEXT,
  contraindications TEXT,
  duration TEXT,
  pros TEXT,
  cons TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. 皮肤问题表
CREATE TABLE skin_conditions (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  problem TEXT,
  cause TEXT,
  treatments JSONB DEFAULT '[]',
  feedback JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. 思辨文章表
CREATE TABLE humanities_essays (
  id TEXT PRIMARY KEY,
  num TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  themes TEXT[],
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. 部位人文观察表
CREATE TABLE humanities_regions (
  id SERIAL PRIMARY KEY,
  region TEXT NOT NULL,
  aesthetic TEXT,
  autonomy TEXT,
  social_context TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 启用 Row Level Security（公开读取）
ALTER TABLE procedures ENABLE ROW LEVEL SECURITY;
ALTER TABLE materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE skin_conditions ENABLE ROW LEVEL SECURITY;
ALTER TABLE humanities_essays ENABLE ROW LEVEL SECURITY;
ALTER TABLE humanities_regions ENABLE ROW LEVEL SECURITY;

-- 允许所有人读取
CREATE POLICY "Allow public read" ON procedures FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON materials FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON skin_conditions FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON humanities_essays FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON humanities_regions FOR SELECT USING (true);

