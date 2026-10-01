# Architecture

## Core flow
Prospect Search → Website Inspection → Qualification → Opportunity/Demo → Outreach → Follow-up → Negotiation → Proposal → Contract → Verified Payment → Infrastructure Intake → Infrastructure Approval/Provisioning → Build/QA → Human Publish Approval → Deploy → Customer Handoff.

The standard delivery target for eligible catalog services is 72 hours after verified payment. See `AUTONOMOUS_SALES_AND_DELIVERY.md`.

## Infrastructure intake
Before closing, the sales bot asks whether the customer owns a domain and hosting/server, records providers/current domain, and asks whether existing infrastructure should be kept or Isa TecInfo should provide it.

If Isa TecInfo must buy/provision infrastructure, the agent prepares the provider/resource/cost/recurrence and creates a human approval. No paid resource is purchased before approval.

## Boundaries
1. Search and inspection adapters may collect only information appropriate for commercial prospecting.
2. Website audits must store evidence; the model must not invent performance or SEO claims.
3. Sales messages identify Isa TecInfo. The system never impersonates Isabella.
4. Prices come from commercial-rules.ts.
5. Discounts, custom clauses, unusual scope, disputes, paid infrastructure and production publishing escalate.
6. A screenshot or customer message is not payment confirmation.
7. Secret/service keys exist server-side only.
8. Every material agent action should create an activity/agent_run/approval record.
9. Destructive domain/hosting operations are never autonomous.
10. A 72-hour target cannot be promised when customer inputs, custom scope or provider dependencies block delivery.

## Human-in-the-loop
Default mode is supervised. The system is designed to become more autonomous per step, not all at once.
