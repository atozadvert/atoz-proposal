-- Add additional branding fields to companies table
alter table if exists public.companies
add column if not exists website text,
add column if not exists registration_number text,
add column if not exists instagram text,
add column if not exists linkedin text,
add column if not exists twitter text,
add column if not exists facebook text,
add column if not exists youtube text,
add column if not exists pinterest text;

-- Add a dedicated reply_to_email column for explicit control (optional, can override company email)
alter table if exists public.companies
add column if not exists reply_to_email text;

-- Create indexes for frequently queried fields
create index if not exists companies_website_idx
  on public.companies (website)
  where website is not null;

-- Add comment documenting the branding fields
comment on column public.companies.website is 'Company website URL for branding';
comment on column public.companies.registration_number is 'Company registration/tax number';
comment on column public.companies.instagram is 'Company Instagram profile URL';
comment on column public.companies.linkedin is 'Company LinkedIn profile URL';
comment on column public.companies.twitter is 'Company Twitter profile URL';
comment on column public.companies.facebook is 'Company Facebook profile URL';
comment on column public.companies.youtube is 'Company YouTube channel URL';
comment on column public.companies.pinterest is 'Company Pinterest profile URL';
comment on column public.companies.reply_to_email is 'Email address for replies (defaults to email if not set)';
