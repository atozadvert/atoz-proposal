-- Create companies table
create table if not exists public.companies (
  id text primary key,
  business_name text not null,
  email text not null,
  mobile_number text,
  whatsapp text,
  address text,
  currency text not null default 'USD',
  logo text,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

-- Add indexes for faster queries
create index if not exists companies_created_at_idx
  on public.companies (created_at desc);

create index if not exists companies_email_idx
  on public.companies (email);

-- Enable RLS
alter table public.companies enable row level security;

-- RLS policy: Anyone can read companies
drop policy if exists "companies_select" on public.companies;
create policy "companies_select"
  on public.companies
  for select
  using (true);

-- RLS policy: Anyone can insert companies
drop policy if exists "companies_insert" on public.companies;
create policy "companies_insert"
  on public.companies
  for insert
  with check (true);

-- RLS policy: Anyone can update companies
drop policy if exists "companies_update" on public.companies;
create policy "companies_update"
  on public.companies
  for update
  using (true)
  with check (true);

-- RLS policy: Anyone can delete companies
drop policy if exists "companies_delete" on public.companies;
create policy "companies_delete"
  on public.companies
  for delete
  using (true);

create or replace function public.set_updated_at_timestamp()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

-- Update trigger for updated_at
drop trigger if exists set_companies_updated_at on public.companies;
create trigger set_companies_updated_at
before update on public.companies
for each row
execute function public.set_updated_at_timestamp();
