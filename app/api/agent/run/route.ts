import{NextResponse}from"next/server";
export async function GET(){return NextResponse.json({
 status:"ready",
 message:"Business OS workflow installed. External actions remain gated until provider credentials and approval rules are configured.",
 deliveryTargetHours:72,
 flow:["prospecting","audit","opportunity","demo","contact","negotiation","proposal","contract","verified_payment","infrastructure_intake","infrastructure_approval","provisioning","build","qa","publish_approval","deploy","handoff"]
})}
