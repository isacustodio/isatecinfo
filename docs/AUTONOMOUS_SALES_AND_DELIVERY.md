# Autonomous Sales & 72-hour Delivery

## Objective
Isa TecInfo Business OS should operate the commercial funnel with AI while keeping irreversible infrastructure purchases and production release behind explicit approval.

## Target flow
1. Prospecting agent finds small businesses from approved public/commercial sources.
2. Site inspector records evidence about the current digital presence.
3. Opportunity agent proposes a concrete improvement (landing page, site, catalog, booking, WhatsApp automation or system).
4. Demo builder creates a personalized concept/landing preview for qualified prospects.
5. Sales agent contacts the prospect as Isa TecInfo, presents the opportunity and handles approved follow-ups/negotiation.
6. Before closing, the bot MUST ask:
   - Do you already own a domain?
   - Which domain?
   - Do you already have hosting/server?
   - Which provider?
   - Do you want to keep the current infrastructure or have Isa TecInfo provide it?
7. Proposal records scope, implementation price, recurring fees, infrastructure responsibility and target delivery.
8. Contract is generated from an approved template.
9. Payment is only considered approved after verification from the configured payment provider/bank integration. Screenshots/messages are not proof.
10. After verified payment, a delivery clock starts. Standard target: ready for customer handoff within 72 hours (3 calendar days) for eligible catalog services.
11. If new domain/hosting is required, the system creates an infrastructure approval for Isabella containing provider, domain, one-time cost, recurring cost and currency.
12. No domain/server purchase occurs until Isabella approves.
13. After approval, infrastructure adapters provision the approved resources.
14. Build/deploy agent creates/configures the purchased solution, attaches domain, DNS and SSL where supported, and runs checks.
15. Isabella receives a final production approval request.
16. After approval, deploy/handoff marks the project published and prepares the customer handoff.

## 72-hour rule
The 72-hour target applies only after verified payment and only when the purchased scope is eligible for fast delivery. The system must not promise 72 hours for custom scope, missing customer content/access, premium/manual domain operations, provider outages, legal/compliance blockers, or material changes. Those cases create an exception approval and a revised date.

Suggested internal checkpoints:
- T+0–4h: payment verified, intake complete, infrastructure decision recorded.
- T+4–24h: build/demo converted into production implementation.
- T+24–48h: integrations, content, responsive QA.
- T+48–60h: domain/DNS/SSL and automated checks.
- T+60–72h: human approval, production release and handoff.

## Guardrails
- Never impersonate Isabella; identify as Isa TecInfo.
- No invented audit claims; store evidence.
- No discount outside configured commercial rules.
- No custom legal clause or out-of-catalog scope without approval.
- No paid infrastructure purchase without explicit approval.
- No payment confirmation from screenshot/chat.
- No production publish without Isabella approval in supervised mode.
- No automatic destructive infrastructure actions.
- Store an activity/agent_run/approval for material agent actions.

## Required provider interfaces
ProspectSearchAdapter, SiteInspectionAdapter, AI/DemoBuilder, MessagingAdapter, ContractAdapter, PaymentAdapter, DomainProvider, HostingProvider and DeployAdapter.

## Definition of done
A paid project is done when its agreed scope is deployed, domain/SSL checks pass where applicable, the production URL is stored, human approval is recorded, customer handoff is prepared, and all costs/recurrences are registered.
