CREATE TABLE finance.monthly_report (
    id INT IDENTITY(1,1),
    olam_view VARCHAR(256),
	mv_cost_centre VARCHAR(256),
	finance_cost_centre VARCHAR(256),
	team VARCHAR(256),
	country VARCHAR(256),
	pnl INT,
	cash_commitment_binary INT,
	mgmt_pnl_cost_type VARCHAR(256),
	general_ledger_desc VARCHAR(256),
	description VARCHAR(256),
	date DATE,
	value FLOAT
);