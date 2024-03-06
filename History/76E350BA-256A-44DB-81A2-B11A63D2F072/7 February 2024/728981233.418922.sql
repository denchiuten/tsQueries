DROP TABLE IF EXISTS plumbing.auth0_to_hubspot_company;
CREATE TABLE plumbing.auth0_to_hubspot_company (
    id BIGINT IDENTITY(1,1),
    auth0_id VARCHAR(255),
    company_id DOUBLE PRECISION
);