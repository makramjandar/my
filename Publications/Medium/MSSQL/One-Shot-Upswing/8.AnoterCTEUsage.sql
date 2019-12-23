------------------------------------------------------------------------ Another CTE usage with joins
;
WITH T1
AS (
     SELECT *
     FROM GradesDetail
     WHERE Test = 'D'
    )
SELECT T2.*
     , T3.Score AS [Lead]

FROM T1 AS T2

LEFT JOIN T1 AS T3
	ON T3.Id = T2.Id + 1;
GO
