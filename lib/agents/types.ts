export type ProspectInput={id:string,business_name:string,website?:string|null,niche?:string|null,country?:string|null,city?:string|null,email?:string|null};
export type AuditResult={score:number,summary:string,observations:string[],opportunities:string[],evidence:string[]};
export type Offer={service:string,currency:"BRL"|"USD",price:number,recurring?:number,scope:string[],timeline:string,requires_human:boolean};
export type AgentDecision={action:string,reason:string,requires_human:boolean,payload?:Record<string,unknown>};