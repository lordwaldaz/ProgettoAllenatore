-- Basket Coach: database condiviso per lo staff.
-- Esegui tutto questo script in Supabase > SQL Editor.
create table if not exists public.training_sheets (
  id uuid primary key default gen_random_uuid(),
  title text not null default 'Allenamento senza titolo',
  session_date date,
  team text default '',
  duration integer,
  goal text default '',
  court_mode text not null default 'half',
  payload jsonb not null default '{}'::jsonb,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.training_sheets enable row level security;

-- Gli utenti autorizzati al progetto (account creati/invitati dall'amministratore)
-- condividono l'archivio dello staff.
drop policy if exists "staff can read sheets" on public.training_sheets;
create policy "staff can read sheets"
on public.training_sheets for select
to authenticated
using (true);

drop policy if exists "staff can create sheets" on public.training_sheets;
create policy "staff can create sheets"
on public.training_sheets for insert
to authenticated
with check (auth.uid() = created_by);

drop policy if exists "staff can update sheets" on public.training_sheets;
create policy "staff can update sheets"
on public.training_sheets for update
to authenticated
using (true)
with check (true);

drop policy if exists "staff can delete sheets" on public.training_sheets;
create policy "staff can delete sheets"
on public.training_sheets for delete
to authenticated
using (true);

create index if not exists training_sheets_updated_at_idx
on public.training_sheets (updated_at desc);

-- IMPORTANTE:
-- In Supabase > Authentication > Providers/Sign In, disattiva le registrazioni pubbliche.
-- Crea/invita soltanto gli account degli allenatori autorizzati.
-- Non inserire mai la service_role key nel sito: usare esclusivamente la anon/publishable key.
