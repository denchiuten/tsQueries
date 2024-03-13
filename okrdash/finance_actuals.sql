SELECT 
	CASE 
		WHEN f.date <= f.close_date THEN 'Actual'
		ELSE 'Forecast'
		END AS type,
	f.olam_view,
	f.mv_cost_centre,
	f.team,
	f.country,
	f.mgmt_pnl_cost_type,
	f.general_ledger_desc,
	f.date,
	f.value,
	f.close_date,
	f.lt_ppt_mapping,
	f.location,
	f.cash_commitment,
	f.pnl,
	f.finance_cost_centre
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	-- date is between the start and end of the close_date year
	AND f.date BETWEEN DATE_TRUNC('year', f.close_date) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', f.close_date)))
	
UNION ALL

SELECT
	'Budget' AS type,
	b.olam_view,
	b.mv_cost_centre,
	b.team,
	b.country,
	b.mgmt_pnl_cost_type,
	b.general_ledger_desc,
	b.date,
	b.value,
	(SELECT MAX(close_date) FROM finance.actuals) AS close_date,
	b.lt_ppt_mapping,
	b.location,
	b.cash_commitment,
	b.pnl,
	b.finance_cost_centre
FROM finance.budget AS b	
WHERE
	-- date is between the start and end of the current year
	b.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE)))
	