SELECT *
FROM finance.monthly_report AS m
WHERE
	1 = 1
	AND import_date = (SELECT MAX(import_date) FROM finance.monthly_report)