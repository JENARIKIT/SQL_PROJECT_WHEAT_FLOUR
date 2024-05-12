--IN 2023 USE TRADE

CREATE VIEW IN_2023_USE_TRADE
AS

SELECT 
	T.Trade,
	SUM(FG.FGQuatity/1000.0)*-1 AS QUANTITY,
	strftime('%Y-%m',P.start_date) AS MonthID
FROM ProcessOrder as P,Material AS M,FG,Trade As T
WHERE M.Material = P.Material_ID
AND P.ProcessOrder = FG.RowLabels
AND T.Material = P.Material_ID
AND MonthID like '2023%'
Group by T.Trade,MonthID
Order by MonthID;