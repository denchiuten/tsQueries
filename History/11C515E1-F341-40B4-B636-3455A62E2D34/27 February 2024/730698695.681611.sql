SELECT
DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE)))