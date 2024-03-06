SELECT DISTINCT
close_date,
DATE_ADD('year', 1, DATE_TRUNC('year', f.close_date))
FROM finance.actuals AS f