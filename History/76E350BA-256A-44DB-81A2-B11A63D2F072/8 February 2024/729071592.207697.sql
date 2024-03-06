ALTER TABLE finance.actuals DROP COLUMN cash_commitment_binary;
ALTER TABLE finance.actuals DROP COLUMN pnl;
ALTER TABLE finance.actuals ADD COLUMN cash_commitment BOOLEAN;
ALTER TABLE finance.actuals ADD COLUMN pnl BOOLEAN;