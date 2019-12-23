------------------------------------------------------------------------------ No joins and CTE usage
;
WITH T1
AS (
    SELECT *
    FROM dbo.GradesDetail T2
    WHERE T2.Test = 'D'
   )
SELECT *
       , CASE WHEN Id % 2 = 1 THEN MAX(
       				       CASE 
				       	  WHEN 
					    Id % 2 = 0
				          THEN 
					    Score END
				      ) OVER (PARTITION BY (Id + 1) / 2) 
       	      ELSE MAX(
	      	       CASE 
		         WHEN 
			   Id % 2 = 1 
			 THEN 
			   Score END
		      ) OVER (PARTITION BY Id / 2) 
	      END [Lead]
FROM T1 Score
GO
