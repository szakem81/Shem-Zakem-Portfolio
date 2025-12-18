# Private Consultant Case Study — Restaurant Growth and Efficiency

## Summary  
Transformed operations and launched new digital revenue channels for independent restaurants, driving a **36%** lift in online sales and a **21%** monthly revenue uplift; **leveraged LLM and ML along with generative AI** to accelerate analysis, strategy identification, roadmap planning, and presentation generation.

---

## Problem
Independent restaurants faced thin margins, inconsistent order accuracy, and limited digital sales channels that constrained growth and profitability.

---

## Approach
- **Prioritize high‑ROI interventions:** ordering integrations, order‑management optimization, menu engineering, and staff workflows.  
- **Repeatable playbook:** discovery → pilot → iterate → scale.  
- **LLM + ML + generative AI:** accelerate insight generation, rank opportunities, draft roadmaps, and produce stakeholder materials while keeping humans in the loop for verification and decisions.

---

## Execution
1. **Discovery & measurement** — mapped order flows, measured order handling time and error rates, and ran margin analysis to identify high‑impact menu items. LLMs drafted initial SQL and ML models suggested cohort definitions.  
2. **Integrations** — implemented multi‑platform mobile ordering and a direct ordering integration to centralize orders and reduce reconciliation.  
3. **Workflow redesign** — reworked kitchen order flows, introduced first‑pass quality checks, and trained staff.  
4. **Productization** — launched branded products and new menu items with targeted promotions.  
5. **Iteration & scaling** — ran weekly experiments, instrumented results, and rolled successful changes across locations; ML models helped prioritize experiments by predicted ROI.

---

## Outcome
- **36%** lift in online sales.  
- **21%** reduction in order handling time and **29%** improvement in first‑pass accuracy.  
- **21%** monthly revenue uplift from new menu and branded products.  
- **~50%** reduction in time to produce analysis and presentation materials using LLM/ML and generative AI‑assisted workflows.  
- A documented, repeatable playbook for rapid rollouts and clearer stakeholder alignment.

---

## Artifacts (embedded)

### Message templates (operations)
- `artifacts/templates/example_online_ordering_confirmation_order.md`
- `artifacts/templates/example_online_ordering_activation_confirmation.md`

---

### Telemetry queries (SQL) Example

**Median and P90 time to activation by week**
```sql
SELECT
  DATE_TRUNC('week', event_time) AS cohort_week,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY time_to_activation_hours) AS median_hours,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY time_to_activation_hours) AS p90_hours,
  COUNT(DISTINCT location_id) AS locations
FROM restaurant_events
WHERE event_time >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY DATE_TRUNC('week', event_time)
ORDER BY cohort_week;
WITH counts AS (
  SELECT
    SUM(CASE WHEN automated THEN 1 ELSE 0 END) AS automated_count,
    SUM(CASE WHEN automated THEN 0 ELSE 1 END) AS manual_count
  FROM order_messages
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
)

```

**Operational Time Savings**

```sql

SELECT
  automated_count,
  manual_count,
  (manual_count * 10.0 - automated_count * 1.5) / 60.0 AS estimated_hours_saved
FROM counts;

```

**A/B Testing**

```sql

SELECT
  variant,
  COUNT(*) AS messages_sent,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) AS activations,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS activation_rate
FROM message_ab_tests
WHERE test_id = '{test_id}'
GROUP BY variant;

```

---
## Generative/Agentic AI Prompt Examples

**Prompt:** 

"Given the restaurant_events table with columns event_time, location_id, event_type, and time_to_activation_hours, generate a SQL query that returns median and p90 time_to_activation_hours by week for the last 90 days."

**Prompt:** 

"Summarize the top 5 high‑impact interventions given these inputs: margin per order, average order handling time, first‑pass accuracy, and owner feedback themes. Rank by estimated revenue lift and implementation effort."

**Prompt:** 

"Create a 10‑slide presentation outline for owners summarizing pilot results: problem, approach, key metrics, before/after charts, recommended next steps, and a one‑page action plan."
