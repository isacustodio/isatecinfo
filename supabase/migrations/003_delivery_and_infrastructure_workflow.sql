alter table public.prospects add column if not exists has_domain boolean;
alter table public.prospects add column if not exists domain text;
alter table public.prospects add column if not exists has_hosting boolean;
alter table public.prospects add column if not exists hosting_provider text;
alter table public.prospects add column if not exists wants_isa_infrastructure boolean;

alter table public.projects add column if not exists payment_verified_at timestamptz;
alter table public.projects add column if not exists target_delivery_at timestamptz;
alter table public.projects add column if not exists delivered_at timestamptz;

create table if not exists public.infrastructure_resources(
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 kind text not null check(kind in('domain','hosting','server','dns','ssl','other')),
 provider text not null,
 resource_name text,
 external_id text,
 currency text check(currency in('BRL','USD')),
 one_time_cost numeric(14,2),
 recurring_cost numeric(14,2),
 recurrence text check(recurrence in('monthly','yearly')),
 status text not null default 'planned' check(status in('planned','awaiting_approval','approved','provisioning','active','failed','cancelled')),
 approved_by uuid references auth.users(id),
 approved_at timestamptz,
 metadata jsonb not null default '{}',
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists infrastructure_resources_project_id_idx on public.infrastructure_resources(project_id);
alter table public.infrastructure_resources enable row level security;
create policy "staff infrastructure resources" on public.infrastructure_resources for all to authenticated using((select public.is_staff())) with check((select public.is_staff()));
grant select,insert,update,delete on public.infrastructure_resources to authenticated;

insert into public.settings(key,value) values
('delivery','{"standard_target_hours":72,"starts_after_verified_payment":true,"production_publish_requires_human":true}'),
('infrastructure','{"paid_purchase_requires_human":true,"destructive_actions_autonomous":false,"ask_domain":true,"ask_hosting":true}')
on conflict(key) do update set value=excluded.value,updated_at=now();
