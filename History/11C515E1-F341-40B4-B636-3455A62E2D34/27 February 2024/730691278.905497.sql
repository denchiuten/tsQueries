SELECT DISTINCT
close_date,
(DATE_TRUNC('year', f.close_date)::DATE + INTERVAL '1 year' - INTERVAL '1 day')
FROM finance.actuals AS f