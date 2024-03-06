SELECT
	'Budget' AS type,
	b.id,
	b.olam_view,
	b.mv_cost_centre,
	b.team,
	b.country,
	b.mgmt_pnl_cost_type,
	b.general_ledger_desc,
	b.date,
	b.value,
	(SELECT MAX(close_date FROM finance.actuals)) AS close_date,
	b.lt_ppt_mapping,
	b.location,
	b.cash_commitment,
	b.pnl,
	b.finance_cost_centre
FROM finance.budget AS b	
WHERE
	-- date is between the start and end of the current year
	b.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE)))