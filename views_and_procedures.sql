-- Create view
CREATE VIEW ResidentBills AS
SELECT r.name, u.name AS utility, b.billing_month, b.amount_due, b.paid_status
FROM Billing b
JOIN Residents r ON b.resident_id = r.resident_id
JOIN Utilities u ON b.utility_id = u.utility_id;

select * from ResidentBills;

-- Stored Procedures

-- Get Total Usage by Zone for a Specific Utility
DELIMITER $$

CREATE PROCEDURE GetZoneUtilityUsage(IN util_id INT)
BEGIN
    SELECT 
        z.zone_name,
        SUM(ur.usage_unit) AS total_usage
    FROM UsageRecords ur
    JOIN Residents r ON ur.resident_id = r.resident_id
    JOIN Zones z ON r.zone_id = z.zone_id
    WHERE ur.utility_id = util_id
    GROUP BY z.zone_name;
END $$

DELIMITER ;

CALL GetZoneUtilityUsage(1);  -- For water usage

DELIMITER $$

CREATE PROCEDURE GetUnpaidBillsByZone()
BEGIN
    SELECT 
        z.zone_name,
        r.name AS resident_name,
        u.name AS utility_name,
        b.amount_due
    FROM Billing b
    JOIN Residents r ON b.resident_id = r.resident_id
    JOIN Zones z ON r.zone_id = z.zone_id
    JOIN Utilities u ON b.utility_id = u.utility_id
    WHERE b.paid_status = 'Unpaid';
END $$

DELIMITER ;

CALL GetUnpaidBillsByZone();