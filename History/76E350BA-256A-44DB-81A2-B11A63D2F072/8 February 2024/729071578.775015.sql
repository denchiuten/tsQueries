ALTER TABLE finance.budget DROP COLUMN cash_commitment_binary;
ALTER TABLE finance.budget DROP COLUMN pnl;
ALTER TABLE finance.budget ADD COLUMN cash_commitment BOOLEAN;
ALTER TABLE finance.budget ADD COLUMN pnl BOOLEAN;