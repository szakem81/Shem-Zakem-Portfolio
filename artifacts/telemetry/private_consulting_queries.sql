-- Median and P90 time to activation by week (adapt table/field names to your schema)
SELECT
  DATE_TRUNC('week', event_time) AS cohort_week,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY time_to_activation_hours) AS median_hours,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY time_to_activation_hours) AS p90_hours,
  COUNT(DISTINCT location_id) AS locations
FROM restaurant_events
WHERE event_time >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY DATE_TRUNC('week', event_time)
ORDER BY cohort_week;

-- Ops hours saved estimate (adapt assumptions and table names)
WITH counts AS (
  SELECT
    SUM(CASE WHEN automated THEN 1 ELSE 0 END) AS automated_count,
    SUM(CASE WHEN automated THEN 0 ELSE 1 END) AS manual_count
  FROM order_messages
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT
  automated_count,
  manual_count,
  (manual_count * 10.0 - automated_count * 1.5) / 60.0 AS estimated_hours_saved
FROM counts;
