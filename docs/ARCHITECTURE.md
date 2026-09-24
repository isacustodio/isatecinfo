# Architecture

## Core flow
Prospect Search → Website Inspection → Qualification → Offer/Demo → Outreach → Follow-up → Negotiation → Proposal → Contract → Verified Payment → Human Publish Approval → Deploy.

## Boundaries
1. Search and inspection adapters may collect only information appropriate for commercial prospecting.
2. Website audits must store evidence; the model must not invent performance or SEO claims.
3. Sales messages identify Isa TecInfo. The system never impersonates Isabella.
4. Prices come from commercial-rules.ts.
5. Discounts, custom clauses, unusual scope, disputes and production publishing escalate.
6. A screenshot or customer message is not payment confirmation.
7. Secret/service keys exist server-side only.
8. Every agent action should create an activity/agent_run record.

## Human-in-the-loop
Default mode is supervised. The system is designed to become more autonomous per step, not all at once.
