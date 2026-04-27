alter table if exists public.proposals
  add column if not exists pdf_base64 text;

alter table if exists public.proposals
  add column if not exists response_at timestamptz;

