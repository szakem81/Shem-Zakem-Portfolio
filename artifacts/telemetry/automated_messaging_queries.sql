**Time To Activation**
SELECT
  DATE(created_at) AS cohort_date,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY activation_time_hours) AS median_hours,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY activation_time_hours) AS p90_hours,
  COUNT(*) AS properties
FROM onboarding_events
WHERE created_at >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY DATE(created_at)
ORDER BY cohort_date;

**Operation Hours Saved**
WITH counts AS (
  SELECT
    SUM(CASE WHEN automated THEN 1 ELSE 0 END) AS automated_count,
    SUM(CASE WHEN automated THEN 0 ELSE 1 END) AS manual_count
  FROM partner_messages
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT
  (manual_count * 10.0 - automated_count * 1.5) / 60.0 AS estimated_hours_saved
FROM counts;

**Activation Conversion Lift By Cohort**
SELECT
  cohort,
  COUNT(*) FILTER (WHERE activated = true) * 1.0 / COUNT(*) AS activation_rate,
  COUNT(*) FILTER (WHERE upsell_accepted = true) * 1.0 / COUNT(*) AS upsell_rate
FROM (
  SELECT
    DATE_TRUNC('week', created_at) AS cohort,
    property_id,
    MAX(CASE WHEN event = 'activated' THEN 1 ELSE 0 END) AS activated,
    MAX(CASE WHEN event = 'upsell_accepted' THEN 1 ELSE 0 END) AS upsell_accepted
  FROM onboarding_events
  WHERE created_at >= CURRENT_DATE - INTERVAL '90 days'
  GROUP BY cohort, property_id
) s
GROUP BY cohort
ORDER BY cohort;

**A/B test analysis**
SELECT
  variant,
  COUNT(*) AS messages_sent,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) AS activations,
  SUM(CASE WHEN triggered_event = 'activated' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS activation_rate
FROM message_ab_tests
WHERE test_id = '{test_id}'
GROUP BY variant;
