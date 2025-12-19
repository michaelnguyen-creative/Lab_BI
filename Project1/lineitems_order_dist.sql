-- Distribution of line items per order
SELECT 
    LineItemCount,
    COUNT(*) AS NumberOfOrders,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS PercentOfOrders
FROM (
    SELECT 
        SalesOrderID,
        COUNT(*) AS LineItemCount
    FROM Sales.SalesOrderDetail
    GROUP BY SalesOrderID
) AS OrderSizes
GROUP BY LineItemCount
ORDER BY LineItemCount;
