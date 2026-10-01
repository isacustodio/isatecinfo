export const FAST_DELIVERY_HOURS = 72 as const;
export const FAST_DELIVERY_SERVICES = ["landing","institutional","redesign","booking","catalog","automation","ai"] as const;
export type FastDeliveryService=(typeof FAST_DELIVERY_SERVICES)[number];

export function deliveryDeadline(verifiedPaymentAt:Date,hours=FAST_DELIVERY_HOURS){
  return new Date(verifiedPaymentAt.getTime()+hours*60*60*1000);
}
export function fastDeliveryEligible(service:string){
  return (FAST_DELIVERY_SERVICES as readonly string[]).includes(service);
}
export function deliveryException(input:{service:string;missingCustomerInput?:boolean;customScope?:boolean;providerBlocked?:boolean}){
  const reasons:string[]=[];
  if(!fastDeliveryEligible(input.service))reasons.push("service_not_fast_delivery");
  if(input.missingCustomerInput)reasons.push("missing_customer_input");
  if(input.customScope)reasons.push("custom_scope");
  if(input.providerBlocked)reasons.push("provider_blocked");
  return {eligible:reasons.length===0,reasons};
}
