# Isa TecInfo Business OS

Sistema interno da Isa TecInfo para CRM + operação comercial semiautônoma, da prospecção ao handoff.

## Visão do produto
O Business OS deve:
- procurar prospects em fontes aprovadas;
- analisar a presença/site com evidências;
- identificar oportunidades e criar uma ideia/demo personalizada de landing page, site, catálogo, reservas, automação ou sistema;
- abordar o prospect em nome da Isa TecInfo e conduzir follow-up/negociação dentro das regras comerciais;
- gerar proposta e contrato;
- perguntar obrigatoriamente se o cliente já possui domínio e hospedagem/servidor e se deseja manter ou contratar via Isa TecInfo;
- confirmar pagamento somente por fonte confiável;
- após pagamento verificado, iniciar entrega rápida com alvo de até 72 horas para serviços elegíveis;
- quando houver domínio/servidor a contratar, criar uma aprovação com custos para Isabella;
- depois do OK, provisionar/configurar a infraestrutura aprovada;
- construir, testar, configurar domínio/DNS/SSL e deixar o projeto pronto;
- exigir aprovação humana para publicação em produção no modo supervisionado;
- registrar toda a trilha no Supabase.

Fluxo: Prospecting → Audit → Opportunity/Demo → Outreach → Negotiation → Proposal → Contract → Verified Payment → Infrastructure Approval/Provisioning → Build/QA → Human Publish Approval → Deploy → Handoff.

Detalhes: `docs/AUTONOMOUS_SALES_AND_DELIVERY.md`.

## O que já está no código
- Next.js 16 + React 19 + TypeScript
- Supabase SSR Auth
- Dashboard e pipeline
- CRM de prospects
- regras de preço BRL/USD
- Website Auditor baseado em fatos observáveis
- Offer Builder
- Sales Agent com intake obrigatório de domínio/hospedagem
- orquestrador para auditoria → qualificação → proposta rascunho
- política de entrega rápida em 72h após pagamento verificado
- contratos de DomainProvider/HostingProvider/DeployAdapter
- schema SQL completo com RLS
- trilha de auditoria
- arquitetura desacoplada para provedores externos

## Segurança
O sistema começa em modo **supervised**. Compras de infraestrutura e publicação em produção exigem aprovação. Pagamento só pode ser marcado como confirmado por integração confiável. Nunca coloque SUPABASE_SECRET_KEY no browser.

## Setup
1. Use o projeto Supabase exclusivo da Isa TecInfo.
2. Aplique as migrations em `supabase/migrations/`.
3. Crie a usuária administrativa no Supabase Auth.
4. Copie `.env.example` para `.env.local` e configure as credenciais apenas no ambiente apropriado.
5. `npm install`
6. `npm run dev`

## Adapters ainda dependentes de provedor/credencial
- prospect search
- browser/site inspection
- AI/demo builder
- Gmail/outbound
- assinatura de contrato
- PIX/payment
- domínio (Vercel/Cloudflare ou outro)
- hosting (Vercel/Cloudflare/DigitalOcean ou outro)
- deploy/handoff
