# Expedia Automated Messaging and Onboarding for Lodging Partners

**One-line summary**  
Designed and delivered partner automation and onboarding programs that reduced manual work, accelerated partner activation, and unlocked supply growth—delivering $4.2M in annual savings and $2.7M in new revenue.

---

## Problem
Manual partner communications and a fragmented onboarding experience caused slow time‑to‑activation, high operational cost, and missed upsell opportunities. Operations teams spent significant time on repetitive messaging and manual validations, limiting scale.

---

## Approach
- Prioritize high‑impact touchpoints: confirmations, missing‑data prompts, verification reminders, and targeted upsells.  
- Instrumentation first: define success metrics (time‑to‑activation, ops hours saved, conversion, upsell rate) and build telemetry before automating.  
- Phased pilots: validate with cohorts, run A/B tests on content and timing, iterate, then scale.  
- Guardrails and monitoring: throttling, opt‑outs, rollback plans, and alerting to protect partner experience.

---

## Execution
1. **Discovery** — Mapped manual workflows, measured ops time per message type, and estimated revenue impact from faster activations.  
2. **Design** — Wrote message templates, defined triggers and acceptance criteria, and created rollback and escalation plans.  
3. **Pilot** — Launched automation for a small cohort, ran A/B tests on message variants, and instrumented telemetry for conversion and error tracking.  
4. **Scale** — Iterated on pilot learnings, expanded coverage, integrated with CRM and onboarding systems, and trained partner success teams on exception handling.  
5. **Sustain** — Built dashboards, alerts, and a decision log to govern future changes and maintain performance.

---

## Outcome
- **$4.2M** annual cost savings from reduced manual messaging and handling.  
- **$700K** incremental revenue from improved conversion and targeted upsells.  
- **$2.7M** revenue uplift from a guided Add‑a‑Property onboarding flow and **$400K** in operational savings.  
- **$800K** annual savings from a Salesforce/Dropbox integration and **$600K** in enabled revenue.  
- A repeatable automation playbook, monitoring stack, and decision log for future partner programs.

---

## Artifacts (embedded)

### Message templates

- `artifacts/templates/example_automated_messaging_confirmation.md`
- `artifacts/templates/example_automated_messaging_missing_data.md`
- `artifacts/templates/example_automated_messaging_verification_reminder.md`
- `artifacts/templates/example_automated_messaging_upsell_offer.md`
- `artifacts/templates/example_automated_messaging_activation_confirmation.md`

---

### Telemetry queries (SQL)
**Time to activation distribution**
```sql
SELECT
  DATE(created_at) AS cohort_date,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY activation_time_hours) AS median_hours,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY activation_time_hours) AS p90_hours,
  COUNT(*) AS properties
FROM onboarding_events
WHERE created_at >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY DATE(created_at)
ORDER BY cohort_date;
WITH counts AS (
  SELECT
    SUM(CASE WHEN automated THEN 1 ELSE 0 END) AS automated_count,
    SUM(CASE WHEN automated THEN 0 ELSE 1 END) AS manual_count
  FROM partner_messages
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT
  automated_count,
  manual_count,
  (manual_count * 10.0 - automated_count * 1.5) / 60.0 AS estimated_hours_saved
FROM counts;
SELECT
  variant,
  COUNT(*) AS messages_sent,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) AS activations,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS activation_rate
FROM message_ab_tests
WHERE test_id = '{test_id}'
GROUP BY variant;
Triage
- Monitor dashboard for cohort p90 and activation outliers.
- If activation_time > p90, open a ticket and assign to Partner Success.

Message cadence
- Confirmation → 24h missing data prompt → 48h verification reminder → final notice at 7 days.
- Respect opt‑outs and throttling rules.

Exception handling
- Partner replies with missing info: update system and trigger manual verification.
- Document upload failures: send secure upload link and escalate if repeated.
- High error cohort: pause automation for cohort and run root cause analysis.

Upsell flow
- Route accepted upsells to Sales Enablement with partner profile and recommended package.
- Track conversion and revenue attribution.
1. Pilot vs Big Bang
- Date: 2019-03-12
- Decision: Use phased pilots for onboarding automation.
- Rationale: Validate ROI, reduce rollback risk, and gather partner feedback.

2. Automation Scope
- Date: 2019-04-02
- Decision: Prioritize onboarding touchpoints (confirmations, missing data, verification).
- Rationale: High volume and clear ROI; easier to measure impact.

3. Personalization Tradeoff
- Date: 2019-05-15
- Decision: Limit template variants to reduce maintenance overhead.
- Rationale: Personalization improves conversion but increases operational complexity.
Stakeholders: Partner Operations; Partner Success; SRE; Engineering; Finance; Legal; Sales Enablement.
Tech: Onboarding APIs; CRM (Salesforce); Messaging service; Telemetry/analytics platform; Document storage (Dropbox); Internal partner portal.
Prompt: "Generate a SQL query that returns median and p90 activation_time_hours by week for the last 90 days from onboarding_events."
Prompt: "Draft three concise missing-data message variants that encourage quick action."
Prompt: "Create a 10-slide executive presentation outline summarizing pilot results and recommended next steps."
