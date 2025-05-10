-- Show all residents and their zone
SELECT r.name, z.zone_name
FROM Residents r
JOIN Zones z ON r.zone_id = z.zone_id;

--  Get total water usage in each zone
SELECT z.zone_name, SUM(u.usage_unit) AS total_usage
FROM UsageRecords u
JOIN Residents r ON u.resident_id = r.resident_id
JOIN Zones z ON r.zone_id = z.zone_id
WHERE u.utility_id = 2
GROUP BY z.zone_name;

--  List all unpaid bills
SELECT r.name, b.amount_due
FROM Billing b
JOIN Residents r ON b.resident_id = r.resident_id
WHERE b.paid_status = 'Unpaid';