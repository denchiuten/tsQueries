DROP TABLE IF EXISTS finance.actuals;
CREATE TABLE finance.actuals (
	id BIGINT IDENTITY(1,1),
	olam_view varchar(256),
	mv_cost_centre varchar(256),
	team varchar(256),
	country varchar(256),
	mgmt_pnl_cost_type varchar(256),
	general_ledger_desc varchar(256),
	description varchar(256),
	date date,
	value double precision,
	import_date date,
	lt_ppt_mapping varchar(256),
	location varchar(256),
	cash_commitment boolean,
	pnl boolean,
	finance_cost_centre bigint
);