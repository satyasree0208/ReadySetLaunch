-- ================================================================
--  ReadySetLaunch — Supabase Database Schema
--  Run this in: Supabase Dashboard → SQL Editor → New Query
-- ================================================================

-- ── 1. PROFILES ──────────────────────────────────────────────────
-- Auto-created when a user signs up (via trigger below)
create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  full_name   text,
  avatar_url  text,
  created_at  timestamptz default now()
);

-- Trigger: create a profile row whenever a new user signs up
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (
    new.id,
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'avatar_url'
  );
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();


-- ── 2. PROJECTS ───────────────────────────────────────────────────
create table if not exists public.projects (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references auth.users(id) on delete cascade,
  name                text not null,
  platform            text,                        -- android | ios | website | saas | etc.
  mode                text default 'practice',      -- practice | marketing
  target_users        text,
  problem_statement   text,
  key_features        text,
  readiness_score     int  default 0,
  created_at          timestamptz default now(),
  updated_at          timestamptz default now()
);

-- RLS: users can only see their own projects
alter table public.projects enable row level security;

create policy "Users can manage their own projects"
  on public.projects for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);


-- ── 3. CHECKLIST ITEMS ────────────────────────────────────────────
create table if not exists public.checklist_items (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  user_id     uuid not null references auth.users(id) on delete cascade,
  section     text not null,   -- market | tech | ops | ux
  label       text not null,
  is_done     boolean default false,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

alter table public.checklist_items enable row level security;

create policy "Users can manage their own checklist items"
  on public.checklist_items for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);


-- ── 4. SIMULATIONS ───────────────────────────────────────────────
create table if not exists public.simulations (
  id             uuid primary key default gen_random_uuid(),
  project_id     uuid not null references public.projects(id) on delete cascade,
  user_id        uuid not null references auth.users(id) on delete cascade,
  readiness      int,
  adoption_rate  int,
  risk_level     text,    -- low | medium | high
  risk_label     text,
  weeks_left     int,
  suggestions    jsonb,   -- array of { label, impact }
  created_at     timestamptz default now()
);

alter table public.simulations enable row level security;

create policy "Users can manage their own simulations"
  on public.simulations for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);


-- ── 5. INDEXES ───────────────────────────────────────────────────
create index if not exists idx_projects_user_id       on public.projects(user_id);
create index if not exists idx_checklist_project_id   on public.checklist_items(project_id);
create index if not exists idx_simulations_project_id on public.simulations(project_id);
