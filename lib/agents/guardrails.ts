import{autonomyMode,ESCALATE_WHEN}from"@/lib/commercial-rules";
export function decisionGate(input:{kind:string;recipient?:string;hasVerifiedPayment?:boolean;hasHumanApproval?:boolean}){
 const reasons:string[]=[];if(autonomyMode()==="manual")reasons.push("manual_mode");
 if(ESCALATE_WHEN.includes(input.kind as any))reasons.push("escalation_rule");
 if(input.kind==="publish"&&!input.hasHumanApproval)reasons.push("publish_requires_human");
 if(input.kind==="mark_paid"&&!input.hasVerifiedPayment)reasons.push("payment_not_verified");
 return{allowed:reasons.length===0,reasons};
}