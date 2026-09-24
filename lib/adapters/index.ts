export type FoundBusiness={business_name:string;website?:string;email?:string;phone?:string;country?:string;city?:string;niche?:string;source:string};
export interface ProspectSearchAdapter{search(input:{country:string;niche:string;limit:number}):Promise<FoundBusiness[]>}
export interface SiteInspectionAdapter{inspect(url:string):Promise<{facts:string[];screenshots?:string[]}>}
export interface EmailAdapter{send(input:{to:string;subject:string;text:string;replyToExternalId?:string}):Promise<{externalId:string}>}
export interface ContractAdapter{create(input:{proposalId:string;templateVersion:string;variables:Record<string,string|number>}):Promise<{documentUrl:string;externalId?:string}>}
export interface PaymentAdapter{createPix(input:{amount:number;description:string}):Promise<{externalId:string;copyPaste:string}>;verify(externalId:string):Promise<{confirmed:boolean;confirmedAt?:string}>}
export interface DeployAdapter{publish(input:{projectId:string;approvedBy:string}):Promise<{productionUrl:string}>}
// Concrete providers are plugged in here only after credentials, terms and commercial rules are approved.