create extension if not exists pgcrypto;

create type public.prospect_stage as enum ('prospecting','qualified','contacted','interested','demo','proposal','contract','paid','won','lost','discarded');
create type public.proposal_status as enum ('draft','sent','negotiating','accepted','rejected','expired');
create type public.project_status as enum ('planned','in_progress','review','paid_waiting_publish','published','cancelled');

create table public.profiles(
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'operator' check(role in('admin','operator','viewer')),
  created_at timestamptz not null default now()
);
create table public.prospects(
  id uuid primary key default gen_random_uuid(),
  business_name text not null, country text, city text, niche text, website text,
  contact_name text, email text, phone text, source text, grade text check(grade in('A','B','C')),
  stage public.prospect_stage not null default 'prospecting',
  problem text, suggested_offer text, estimated_value numeric(14,2), currency text check(currency in('BRL','USD')),
  next_action_at timestamptz, last_contact_at timestamptz, notes text,
  created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table public.website_audits(
  id uuid primary key default gen_random_uuid(), prospect_id uuid not null references public.prospects(id) on delete cascade,
  score int check(score between 0 and 100), summary text, observations jsonb not null default '[]', opportunities jsonb not null default '[]',
  evidence jsonb not null default '[]', screenshot_url text, created_at timestamptz not null default now()
);
create table public.clients(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id),
  company text not null, contact_name text, country text, email text, phone text, status text not null default 'active',
  acquisition_source text, start_date date default current_date, has_domain boolean, has_hosting boolean,
  domain text, hosting_notes text, created_at timestamptz not null default now()
);
create table public.proposals(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id) on delete cascade,
  client_id uuid references public.clients(id), service text not null, scope jsonb not null default '[]',
  timeline text, currency text not null check(currency in('BRL','USD')), amount numeric(14,2) not null,
  recurring_amount numeric(14,2), status public.proposal_status not null default 'draft',
  sent_at timestamptz, valid_until date, accepted_at timestamptz, created_at timestamptz not null default now()
);
create table public.contracts(
  id uuid primary key default gen_random_uuid(), proposal_id uuid not null references public.proposals(id),
  template_version text not null, status text not null default 'draft' check(status in('draft','sent','signed','cancelled')),
  document_url text, signed_at timestamptz, created_at timestamptz not null default now()
);
create table public.payments(
  id uuid primary key default gen_random_uuid(), proposal_id uuid references public.proposals(id), client_id uuid references public.clients(id),
  provider text, external_id text, method text, currency text not null check(currency in('BRL','USD')),
  amount numeric(14,2) not null, status text not null default 'pending' check(status in('pending','confirmed','failed','refunded')),
  confirmed_at timestamptz, evidence jsonb, created_at timestamptz not null default now()
);
create table public.projects(
  id uuid primary key default gen_random_uuid(), client_id uuid not null references public.clients(id), proposal_id uuid references public.proposals(id),
  name text not null, service text, status public.project_status not null default 'planned', start_date date, deadline date,
  price numeric(14,2), currency text check(currency in('BRL','USD')), estimated_hours numeric(8,2), actual_hours numeric(8,2),
  production_url text, created_at timestamptz not null default now()
);
create table public.subscriptions(
  id uuid primary key default gen_random_uuid(), client_id uuid not null references public.clients(id), plan text not null,
  monthly_value numeric(14,2) not null, currency text not null check(currency in('BRL','USD')), status text not null default 'active',
  next_billing date, created_at timestamptz not null default now()
);
create table public.transactions(
  id uuid primary key default gen_random_uuid(), type text not null check(type in('revenue','expense')),
  category text, project_id uuid references public.projects(id), client_id uuid references public.clients(id),
  amount numeric(14,2) not null, currency text not null check(currency in('BRL','USD')), occurred_on date not null default current_date,
  recurring boolean not null default false, notes text, created_at timestamptz not null default now()
);
create table public.activities(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id) on delete cascade,
  client_id uuid references public.clients(id), type text not null, channel text, direction text check(direction in('inbound','outbound','internal')),
  summary text not null, external_id text, created_at timestamptz not null default now()
);
create table public.tasks(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id), client_id uuid references public.clients(id),
  title text not null, due_at timestamptz, priority text default 'normal', status text default 'open', created_at timestamptz not null default now()
);
create table public.agent_runs(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id), agent text not null,
  status text not null, input jsonb, output jsonb, requires_human boolean not null default false,
  error text, started_at timestamptz not null default now(), finished_at timestamptz
);
create table public.approvals(
  id uuid primary key default gen_random_uuid(), prospect_id uuid references public.prospects(id), project_id uuid references public.projects(id),
  kind text not null, payload jsonb not null default '{}', status text not null default 'pending' check(status in('pending','approved','rejected')),
  requested_at timestamptz not null default now(), resolved_at timestamptz, resolved_by uuid references auth.users(id)
);
create table public.settings(
  key text primary key, value jsonb not null, updated_at timestamptz not null default now()
);

create index prospects_stage_idx on public.prospects(stage);
create index prospects_next_action_idx on public.prospects(next_action_at);
create index activities_prospect_idx on public.activities(prospect_id,created_at desc);
create index proposals_status_idx on public.proposals(status);
create index payments_status_idx on public.payments(status);
create index approvals_status_idx on public.approvals(status);

alter table public.profiles enable row level security;
alter table public.prospects enable row level security;
alter table public.website_audits enable row level security;
alter table public.clients enable row level security;
alter table public.proposals enable row level security;
alter table public.contracts enable row level security;
alter table public.payments enable row level security;
alter table public.projects enable row level security;
alter table public.subscriptions enable row level security;
alter table public.transactions enable row level security;
alter table public.activities enable row level security;
alter table public.tasks enable row level security;
alter table public.agent_runs enable row level security;
alter table public.approvals enable row level security;
alter table public.settings enable row level security;

create or replace function public.is_staff()
returns boolean language sql stable security invoker
set search_path='' as $$ select exists(select 1 from public.profiles p where p.id=(select auth.uid()) and p.role in('admin','operator')); $$;

create policy "own profile read" on public.profiles for select to authenticated using(id=(select auth.uid()));
create policy "staff prospects" on public.prospects for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff audits" on public.website_audits for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff clients" on public.clients for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff proposals" on public.proposals for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff contracts" on public.contracts for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff payments" on public.payments for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff projects" on public.projects for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff subscriptions" on public.subscriptions for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff transactions" on public.transactions for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff activities" on public.activities for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff tasks" on public.tasks for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff agent runs" on public.agent_runs for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff approvals" on public.approvals for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
create policy "staff settings" on public.settings for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));

grant usage on schema public to authenticated;
grant select,insert,update,delete on all tables in schema public to authenticated;

insert into public.settings(key,value) values
('autonomy','{"mode":"supervised","production_publish_requires_human":true,"payment_requires_verified_source":true}'),
('commercial','{"ask_domain":true,"ask_hosting":true,"currencies":["BRL","USD"]}')
on conflict(key) do nothing;
