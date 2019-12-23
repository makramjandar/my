------------------------------------------------- And the Winner is !!! the Co-Related Subquery usage
SELECT *
	, (
		SELECT Score
		FROM GradesDetail
		WHERE Test = 'D'
			AND Id = T1.Id + 1
		) AS Lead
FROM GradesDetail AS T1
WHERE T1.Test = 'D';
GO
