-- Create draft_proposals table (for work-in-progress proposals)
create table if not exists public.draft_proposals (
  id text primary key,
  company_id text references public.companies(id) on delete set null,
  client_name text,
  client_email text,
  client_phone_number text,
  project_title text,
  project_description text,
  selected_items jsonb not null default '[]'::jsonb,
  items jsonb not null default '[]'::jsonb,
  notes text,
  valid_until text,
  terms jsonb not null default '{}'::jsonb,
  company jsonb, -- snapshot of company data at draft time
  total numeric(12, 2) default 0,
  status text not null default 'draft', -- 'draft', 'sent', 'archived'
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

-- Add indexes for faster queries
create index if not exists draft_proposals_created_at_idx
  on public.draft_proposals (created_at desc);

create index if not exists draft_proposals_status_idx
  on public.draft_proposals (status);

create index if not exists draft_proposals_company_id_idx
  on public.draft_proposals (company_id);

-- Enable RLS
alter table public.draft_proposals enable row level security;

-- RLS policy: Anyone can read draft proposals (can be restricted to user_id later if auth is added)
drop policy if exists "draft_proposals_select" on public.draft_proposals;
create policy "draft_proposals_select"
  on public.draft_proposals
  for select
  using (true);

-- RLS policy: Anyone can insert draft proposals
drop policy if exists "draft_proposals_insert" on public.draft_proposals;
create policy "draft_proposals_insert"
  on public.draft_proposals
  for insert
  with check (true);

-- RLS policy: Anyone can update draft proposals
drop policy if exists "draft_proposals_update" on public.draft_proposals;
create policy "draft_proposals_update"
  on public.draft_proposals
  for update
  using (true)
  with check (true);

-- RLS policy: Anyone can delete draft proposals
drop policy if exists "draft_proposals_delete" on public.draft_proposals;
create policy "draft_proposals_delete"
  on public.draft_proposals
  for delete
  using (true);

-- Update trigger for updated_at
drop trigger if exists set_draft_proposals_updated_at on public.draft_proposals;
create trigger set_draft_proposals_updated_at
before update on public.draft_proposals
for each row
execute function public.set_updated_at_timestamp();
