# Isa TecInfo Business OS

Sistema interno da Isa TecInfo para CRM + operação comercial semiautônoma.

## O que já está no código
- Next.js 16 + React 19 + TypeScript
- Supabase SSR Auth
- Dashboard e pipeline
- CRM de prospects
- regras de preço BRL/USD
- Website Auditor baseado em fatos observáveis
- Offer Builder
- Sales Agent com pergunta obrigatória sobre domínio/hospedagem
- orquestrador para auditoria → qualificação → proposta rascunho
- schema SQL completo com RLS
- trilha de auditoria
- arquitetura pronta para adapters de busca, e-mail, contrato e pagamento

## Segurança
O sistema começa em modo **supervised**. Envio externo, contratos e pagamento não devem ser habilitados antes de configurar provedores, limites e modelos aprovados. Nunca coloque SUPABASE_SECRET_KEY no browser.

## Setup
1. Crie/defina um projeto Supabase exclusivo para Isa TecInfo.
2. Rode `supabase/migrations/001_business_os.sql` no projeto.
3. Crie a usuária administrativa no Supabase Auth.
4. Copie `.env.example` para `.env.local` e preencha URL + publishable key + secret key no ambiente do servidor.
5. `npm install`
6. `npm run dev`

## Próximos adapters
- prospect search provider
- browser/site inspection
- AI provider
- Gmail/outbound e-mail
- assinatura de contrato
- PIX/payment provider
- deploy/handoff

Esses adapters ficam deliberadamente desacoplados para que nenhum agente envie mensagem, contrato ou trate pagamento como confirmado sem uma fonte confiável e regras comerciais explícitas.
