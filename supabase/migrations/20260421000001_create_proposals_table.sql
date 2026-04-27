create table if not exists public.proposals (
  id text primary key,
  company_id text,
  client_name text not null,
  client_email text,
  client_phone_number text,
  project_title text not null,
  project_description text,
  selected_items jsonb not null default '[]'::jsonb,
  items jsonb not null default '[]'::jsonb,
  notes text,
  valid_until text,
  proposal_date text,
  terms jsonb not null default '{}'::jsonb,
  company jsonb not null default '{}'::jsonb,
  total numeric(12,2) not null default 0,
  status text not null default 'submitted',
  submitted_at timestamptz not null default timezone('utc', now()),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists proposals_submitted_at_idx
  on public.proposals (submitted_at desc);

create index if not exists proposals_client_email_idx
  on public.proposals (client_email);

alter table public.proposals enable row level security;

drop policy if exists "proposals_select" on public.proposals;
create policy "proposals_select"
  on public.proposals
  for select
  using (true);

drop policy if exists "proposals_insert" on public.proposals;
create policy "proposals_insert"
  on public.proposals
  for insert
  with check (true);

drop policy if exists "proposals_update" on public.proposals;
create policy "proposals_update"
  on public.proposals
  for update
  using (true)
  with check (true);

drop policy if exists "proposals_delete" on public.proposals;
create policy "proposals_delete"
  on public.proposals
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

drop trigger if exists set_proposals_updated_at on public.proposals;
create trigger set_proposals_updated_at
before update on public.proposals
for each row
execute function public.set_updated_at_timestamp();
