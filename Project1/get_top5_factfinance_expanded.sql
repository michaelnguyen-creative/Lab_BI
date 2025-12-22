SELECT TOP 5 * FROM FactFinance ff
JOIN DimAccount da ON ff.AccountKey = da.AccountKey
JOIN DimScenario ds ON ff.ScenarioKey = ds.ScenarioKey;