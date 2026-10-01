export type InfrastructureAnswers={
 hasDomain:boolean; domain?:string; hasHosting:boolean; hostingProvider?:string;
 keepExistingInfrastructure?:boolean; wantsIsaToProvide?:boolean;
};
export type InfrastructureQuote={provider:string;resource:string;currency:"BRL"|"USD";oneTime:number;recurring:number;recurrence?:"monthly"|"yearly";domain?:string};
export interface DomainProvider{
 check(domain:string):Promise<{available:boolean;currency:"BRL"|"USD";price:number;premium?:boolean}>;
 register(input:{domain:string;approvedBy:string}):Promise<{externalId:string;domain:string}>;
 configure?(input:{domain:string;target:string}):Promise<void>;
}
export interface HostingProvider{
 quote(input:{projectId:string;kind:string}):Promise<InfrastructureQuote>;
 provision(input:{projectId:string;approvedBy:string;quote:InfrastructureQuote}):Promise<{externalId:string;url?:string}>;
}
export function needsInfrastructureApproval(a:InfrastructureAnswers){
 return Boolean(a.wantsIsaToProvide||!a.hasDomain||!a.hasHosting);
}
