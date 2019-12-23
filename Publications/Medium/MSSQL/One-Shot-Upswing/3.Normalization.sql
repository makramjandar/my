--------------------------------------------------------------------------------------- Normalization
;
WITH T1 AS
  (SELECT Rtrim(Cast(SSN AS NVARCHAR(MAX))) AS SSN ,
          Rtrim(Cast(First_name AS NVARCHAR(MAX)) + ' ' + Cast(Last_name AS NVARCHAR(MAX))) AS FullName ,
          Test1 AS A ,
          Test2 AS B ,
          Abs(Test3) AS C ,
          Abs(Test4) AS D ,
          Final
   FROM DBO.grades),

T2 AS 
  (SELECT SSN , FullName , 'A' AS Test , A AS Score
FROM T1
UNION
SELECT SSN , FullName , 'B' AS Test , B AS Score FROM T1
UNION
SELECT SSN ,FullName ,'C' AS Test ,C AS Score FROM T1
UNION
SELECT SSN , FullName , 'D' AS Test , D AS Score FROM T1
UNION
SELECT SSN , FullName , 'Final' AS Test , Final AS Score FROM T1
)
INSERT INTO GradesDetail (SSN, FullName, Test, Score)
SELECT * FROM T2
ORDER BY Test, SSN;
GO
