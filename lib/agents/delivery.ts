import {deliveryDeadline,deliveryException} from "@/lib/delivery-policy";
import {needsInfrastructureApproval,type InfrastructureAnswers} from "@/lib/infrastructure";
export function startDelivery(input:{service:string;verifiedPaymentAt:string;infrastructure:InfrastructureAnswers;missingCustomerInput?:boolean;customScope?:boolean}){
 const paidAt=new Date(input.verifiedPaymentAt);
 const eligibility=deliveryException({service:input.service,missingCustomerInput:input.missingCustomerInput,customScope:input.customScope});
 return {
  paymentVerified:true,
  targetDeadline:eligibility.eligible?deliveryDeadline(paidAt).toISOString():null,
  eligibility,
  infrastructureApprovalRequired:needsInfrastructureApproval(input.infrastructure),
  next:needsInfrastructureApproval(input.infrastructure)?"request_infrastructure_approval":"build"
 };
}
