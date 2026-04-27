-- Create proposal_responses table (to track client accept/decline responses)
create table if not exists public.proposal_responses (
  id text primary key,
  proposal_id text not null references public.proposals(id) on delete cascade,
  response_type text not null, -- 'accepted', 'declined', 'viewed'
  client_name text,
  client_email text,
  response_notes text,
  responded_at timestamptz not null default timezone('utc', now()),
  created_at timestamptz not null default timezone('utc', now())
);

-- Add indexes for faster queries
create index if not exists proposal_responses_proposal_id_idx
  on public.proposal_responses (proposal_id);

create index if not exists proposal_responses_responded_at_idx
  on public.proposal_responses (responded_at desc);

create index if not exists proposal_responses_response_type_idx
  on public.proposal_responses (response_type);

-- Enable RLS
alter table public.proposal_responses enable row level security;

-- RLS policy: Anyone can read proposal responses
drop policy if exists "proposal_responses_select" on public.proposal_responses;
create policy "proposal_responses_select"
  on public.proposal_responses
  for select
  using (true);

-- RLS policy: Anyone can insert proposal responses
drop policy if exists "proposal_responses_insert" on public.proposal_responses;
create policy "proposal_responses_insert"
  on public.proposal_responses
  for insert
  with check (true);

-- RLS policy: Anyone can update proposal responses
drop policy if exists "proposal_responses_update" on public.proposal_responses;
create policy "proposal_responses_update"
  on public.proposal_responses
  for update
  using (true)
  with check (true);

-- RLS policy: Anyone can delete proposal responses
drop policy if exists "proposal_responses_delete" on public.proposal_responses;
create policy "proposal_responses_delete"
  on public.proposal_responses
  for delete
  using (true);

-- Update trigger for created_at (no need for updated_at in this table)
-- since we're mostly recording immutable response events
