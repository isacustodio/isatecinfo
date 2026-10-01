import{autonomyMode,ESCALATE_WHEN}from"@/lib/commercial-rules";
export function decisionGate(input:{kind:string;recipient?:string;hasVerifiedPayment?:boolean;hasHumanApproval?:boolean}){
 const reasons:string[]=[];if(autonomyMode()==="manual")reasons.push("manual_mode");
 if(ESCALATE_WHEN.includes(input.kind as any))reasons.push("escalation_rule");
 if(["publish","purchase_infrastructure","provision_paid_infrastructure"].includes(input.kind)&&!input.hasHumanApproval)reasons.push("human_approval_required");
 if(input.kind==="mark_paid"&&!input.hasVerifiedPayment)reasons.push("payment_not_verified");
 return{allowed:reasons.length===0,reasons};
}
