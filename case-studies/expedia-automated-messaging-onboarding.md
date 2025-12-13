# Expedia Automated Messaging and Onboarding for Lodging Partners

**One-line summary**  
Designed and delivered partner automation and onboarding programs that reduced manual work, accelerated partner activation, and unlocked supply growth—delivering $4.2M in annual savings and $2.7M in new revenue.

## Problem
Manual partner communications and a fragmented onboarding experience caused slow time-to-activation, high operational cost, and missed upsell opportunities for lodging partners. Operations teams spent significant time on repetitive messaging and manual validations, limiting scale.

## Approach
- **Prioritize high-impact touchpoints** — focus on confirmations, missing-data prompts, verification reminders, and targeted upsells.  
- **Instrumentation first** — define success metrics (time-to-activation, ops hours saved, conversion, upsell rate) and build telemetry before automating.  
- **Phased pilots** — validate with cohorts, run A/B tests on content and timing, iterate on results, then scale.  
- **Guardrails and monitoring** — implement throttling, opt-outs, rollback plans, and alerting to protect partner experience.

## Execution
1. **Discovery** — Mapped manual workflows, measured ops time per message type, and estimated revenue impact from faster activations.  
2. **Design** — Wrote message templates, defined triggers and acceptance criteria, and created rollback and escalation plans.  
3. **Pilot** — Launched automation for a small cohort, ran A/B tests on message variants, and instrumented telemetry for conversion and error tracking.  
4. **Scale** — Iterated on pilot learnings, expanded coverage, integrated with CRM and onboarding systems, and trained partner success teams on exception handling.  
5. **Sustain** — Built dashboards, alerts, and a decision log to govern future changes and maintain performance.

## Outcome
- **$4.2M** annual cost savings from reduced manual messaging and handling.  
- **$700K** incremental revenue from improved conversion and targeted upsells.  
- **$2.7M** revenue uplift from a guided Add-a-Property onboarding flow and **$400K** in operational savings.  
- **$800K** annual savings from a Salesforce/Dropbox integration and **$600K** in enabled revenue.  
- A repeatable automation playbook, monitoring stack, and decision log for future partner programs.

## Key decisions and tradeoffs
- **Pilot vs Big Bang** — chose phased pilots to validate ROI and reduce rollback risk.  
- **Scope** — prioritized onboarding touchpoints first to deliver measurable impact quickly.  
- **Personalization** — limited template variants to balance conversion lift with maintenance overhead.

## Artifacts
See `artifacts/` for message templates, telemetry queries, playbooks, decision log, stakeholder map, and Copilot prompts.
