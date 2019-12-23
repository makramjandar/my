----------------------------------------------------------------------------------------------- Pivot
SELECT *
     , CAST(
             (
	       (([A]+[B]+[C]+[D])/6) + (Final/3)
	     ) AS DECIMAL(5, 2)
	    ) AS [Moy.]

FROM (
       SELECT SSN, FullName, Test, Score
       FROM GradesDetail
     ) p

PIVOT(
       SUM(Score) FOR Test IN (
                                [A], [B], [C], [D], [Final]
			      )
     ) AS pvt;
GO
