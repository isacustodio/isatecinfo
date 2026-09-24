export type AutonomyMode="manual"|"supervised"|"autonomous";
export type ServiceKey="landing"|"institutional"|"redesign"|"booking"|"catalog"|"system"|"automation"|"dashboard"|"ai";
export const PRICE_RULES={
 BRL:{landing:[900,1800],institutional:[1500,3500],redesign:[1200,3000],booking:[1800,4000],catalog:[1500,3500],system:[3000,8000],automation:[1500,5000],dashboard:[2000,6000],ai:[2000,6000]},
 USD:{landing:[300,600],institutional:[500,1200],redesign:[400,900],booking:[600,1500],catalog:[500,1200],system:[1000,3000],automation:[500,1800],dashboard:[700,2000],ai:[700,2000]}
} as const;
export const RECURRING={BRL:{care:[190,390],growth:[390,790],automation:[490,1500]},USD:{care:[70,99],growth:[149,149],automation:[249,499]}} as const;
export const ESCALATE_WHEN=["discount_outside_rule","custom_contract_clause","scope_outside_catalog","unverified_technical_answer","exceptional_deadline","unapproved_expense","material_customization","complaint_or_conflict","production_publish"] as const;
export function autonomyMode():AutonomyMode{return (process.env.ISA_AUTONOMY_MODE as AutonomyMode)||"supervised"}
export function canAutoSend(kind:string){const mode=autonomyMode();if(mode==="manual")return false;if(ESCALATE_WHEN.includes(kind as any))return false;return true}
export function priceRange(service:ServiceKey,currency:"BRL"|"USD"){return PRICE_RULES[currency][service]}