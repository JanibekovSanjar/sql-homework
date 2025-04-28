WITH AllShipments AS (
    SELECT Num FROM Shipments
    UNION ALL
    SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0
    UNION ALL SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0
    UNION ALL SELECT 0
),
OrderedShipments AS (
    SELECT 
        Num,
        ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllShipments
)
SELECT
    AVG(1.0 * Num) AS Median
FROM OrderedShipments
WHERE rn IN (20, 21);
