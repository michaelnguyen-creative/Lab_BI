SELECT 
    d.CalendarYear,
    d.CalendarQuarter,
    d.MonthNumberOfYear,
    SUM(s.SalesAmount) as TotalRevenue,
    SUM(s.TotalProductCost) as COGS,
    SUM(s.SalesAmount) - SUM(s.TotalProductCost) as GrossProfits,
    --Gross margin %
    (SUM(s.SalesAmount) - SUM(s.TotalProductCost)) * 100 / NULLIF(SUM(s.SalesAmount), 0) as GrossMarginPct
FROM
    (SELECT 
	    [ProductKey]
        ,[OrderDateKey]
        ,[OrderQuantity]
        ,[UnitPrice]
        ,[ProductStandardCost]
        ,[TotalProductCost]
        ,[SalesAmount]
    FROM dbo.FactInternetSales 
    UNION ALL
    SELECT 
        [ProductKey]
        ,[OrderDateKey]
        ,[OrderQuantity]
        ,[UnitPrice]
        ,[ProductStandardCost]
        ,[TotalProductCost]
        ,[SalesAmount]
    FROM dbo.FactResellerSales) AS s
LEFT JOIN dbo.DimDate d ON
    s.OrderDateKey = d.DateKey
GROUP BY d.CalendarYear, d.CalendarQuarter, d.MonthNumberOfYear
ORDER BY d.CalendarYear, d.CalendarQuarter, d.MonthNumberOfYear;