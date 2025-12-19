SELECT 
    COUNT(*) AS TotalLineItems,
    COUNT(DISTINCT sod.SalesOrderID) AS TotalOrders,
    COUNT(DISTINCT sod.ProductID) AS TotalProductsSold,
    
    -- Avg line items per order (what you asked for)
    COUNT(*) * 1.0 / COUNT(DISTINCT sod.SalesOrderID) AS AvgLineItemsPerOrder,
    
    -- Revenue metrics (per line item grain)
    MIN(sod.LineTotal) AS MinLineRevenue,
    MAX(sod.LineTotal) AS MaxLineRevenue,
    AVG(sod.LineTotal) AS AvgLineRevenue,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh 
    ON sod.SalesOrderID = soh.SalesOrderID
WHERE soh.Status = 5;  -- Only shipped orders