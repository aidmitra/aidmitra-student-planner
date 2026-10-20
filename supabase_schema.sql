-- AidMitra MVP 3.0 Supabase schema
-- Run this in Supabase Dashboard > SQL Editor.
-- The client must use the anon/publishable key only. Never expose service_role keys.

create table if not exists public.student_planners (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"classes":[],"tasks":[],"exams":[],"profile":{}}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.student_planners enable row level security;

drop policy if exists "Students can read their own planner" on public.student_planners;
create policy "Students can read their own planner"
  on public.student_planners for select
  using (auth.uid() = user_id);

drop policy if exists "Students can insert their own planner" on public.student_planners;
create policy "Students can insert their own planner"
  on public.student_planners for insert
  with check (auth.uid() = user_id);

drop policy if exists "Students can update their own planner" on public.student_planners;
create policy "Students can update their own planner"
  on public.student_planners for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Recommended: leave delete disabled from client until account deletion flow exists.
