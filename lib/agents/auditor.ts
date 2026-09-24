import type {AuditResult} from "./types";
export function evaluateWebsite(input:{url?:string|null;facts:string[]}):AuditResult{
 const facts=input.facts.filter(Boolean);let score=50;const obs:string[]=[];const opp:string[]=[];
 const text=facts.join(" ").toLowerCase();
 if(/sem site|no website/.test(text)){score=15;obs.push("Não foi identificado site ativo.");opp.push("Criar presença digital completa.");}
 if(/não responsivo|not responsive/.test(text)){score-=15;obs.push("Problema de responsividade observado.");opp.push("Reconstrução mobile-first.");}
 if(/sem (cta|agendamento|booking)/.test(text)){score-=10;obs.push("Conversão/contato pode ser simplificado.");opp.push("Adicionar CTA e fluxo de contato/agendamento.");}
 if(!opp.length)opp.push("Revisar conversão, clareza da oferta e automações possíveis.");
 return{score:Math.max(0,Math.min(100,score)),summary:score<40?"Oportunidade digital forte":"Oportunidade a validar",observations:obs,opportunities:opp,evidence:facts};
}
// IMPORTANT: production crawling must provide observable facts; this function never invents metrics.