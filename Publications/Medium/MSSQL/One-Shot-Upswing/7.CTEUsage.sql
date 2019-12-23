---------------------------------------------------------------------------- With joins and CTE usage
;
WITH T1
AS (
	SELECT *
		, NULL AS Def
	FROM GradesDetail
	WHERE Test = 'D'
	)
SELECT T1.Id
	, T1.SSN
	, T1.FullName
	, T1.Test
	, T1.Score
	, ISNULL(T2.Score, T1.Def) AS [Lead]
FROM T1
LEFT JOIN T1 AS T2
	ON T1.Id = T2.Id - 1;
GO
