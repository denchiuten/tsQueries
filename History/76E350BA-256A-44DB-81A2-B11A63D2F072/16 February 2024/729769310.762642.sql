SELECT *
FROM plumbing.vw_business_hours_sg AS h
ORDER BY ABS(EXTRACT(EPOCH FROM (h.timestamp_iso_utc - TIMESTAMP '2024-02-13T06:12:12.896Z')))
LIMIT 1;