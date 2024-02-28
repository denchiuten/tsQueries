SELECT d.date, nt.hour_number AS "hour", to_char(d.date + (nt.hour_number::text || ' hours'::text)::interval, 'YYYY-MM-DD HH24:00:00') AS "timestamp"
   FROM plumbing.dates d
  CROSS JOIN plumbing.hours_in_day nt
   LEFT JOIN ( SELECT DISTINCT event.start_date AS date
      FROM calendar.event
     WHERE 1 = 1 AND event.calendar_list_id::text = 'en.singapore#holiday@group.v.calendar.google.com'::text) holidays ON d.date = holidays.date
  WHERE 1 = 1 AND "date_part"('dow'::text, d.date) <> 0 AND "date_part"('dow'::text, d.date) <> 6 AND holidays.date IS NULL AND nt.hour_number >= 9 AND nt.hour_number <= 16 AND d.date <= ('now'::text::date + 365)
  ORDER BY d.date, nt.hour_number;