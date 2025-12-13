SELECT
  DATE(created_at) AS cohort_date,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY activation_time_hours) AS median_hours,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY activation_time_hours) AS p90_hours,
  COUNT(*) AS properties
FROM onboarding_events
WHERE created_at >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY DATE(created_at)
ORDER BY cohort_date;
