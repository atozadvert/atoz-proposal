-- Create company_services table
create table if not exists public.company_services (
  id text primary key,
  company_id text not null references public.companies(id) on delete cascade,
  name text not null,
  description text,
  price numeric(12, 2) not null,
  currency text not null default 'USD',
  category text default 'General',
  quantity integer default 1,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

-- Add indexes for faster queries
create index if not exists company_services_company_id_idx
  on public.company_services (company_id);

create index if not exists company_services_created_at_idx
  on public.company_services (created_at desc);

-- Enable RLS
alter table public.company_services enable row level security;

-- RLS policy: Anyone can read company services
drop policy if exists "company_services_select" on public.company_services;
create policy "company_services_select"
  on public.company_services
  for select
  using (true);

-- RLS policy: Anyone can insert company services
drop policy if exists "company_services_insert" on public.company_services;
create policy "company_services_insert"
  on public.company_services
  for insert
  with check (true);

-- RLS policy: Anyone can update company services
drop policy if exists "company_services_update" on public.company_services;
create policy "company_services_update"
  on public.company_services
  for update
  using (true)
  with check (true);

-- RLS policy: Anyone can delete company services
drop policy if exists "company_services_delete" on public.company_services;
create policy "company_services_delete"
  on public.company_services
  for delete
  using (true);

-- Update trigger for updated_at
drop trigger if exists set_company_services_updated_at on public.company_services;
create trigger set_company_services_updated_at
before update on public.company_services
for each row
execute function public.set_updated_at_timestamp();
