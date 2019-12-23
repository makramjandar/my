------------------------------------------------------------------------------ With Analytic Function
SELECT *
	, LEAD(Score) OVER (ORDER BY Id) Lead
FROM GradesDetail
WHERE Test = 'D';
GO
