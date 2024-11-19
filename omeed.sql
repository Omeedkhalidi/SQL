IF OBJECT_ID('SuccessfulMissions', 'U') IS NOT NULL
    DROP TABLE SuccessfulMissions;
SELECT 
    Spacecraft, 
    "Launch date", 
    "Carrier rocket", 
    Operator, 
    "Mission type"
INTO
    SuccessfulMissions
FROM 
    MoonMissions
WHERE 
    Outcome = 'Successful';

	Update SuccessfulMissions
	SET Operator = LTRIM(Operator);

SELECT 
    "Operator", 
    "Mission type", 
    COUNT(*) AS "Mission count"
FROM SuccessfulMissions
GROUP BY "Operator", "Mission type"
HAVING COUNT(*) > 1
ORDER BY "Operator", "Mission type";


UPDATE SuccessfulMissions
SET "Spacecraft" = LTRIM(RTRIM(LEFT("Spacecraft", CHARINDEX('(', "Spacecraft") - 1)))
WHERE "Spacecraft" LIKE '%(%';


SELECT 
    ID,
    UserName,
    Password,
    FirstName,
    LastName,
    Email,
    Phone,
    FirstName + ' ' + LastName AS Name,
    CASE
        WHEN CAST(SUBSTRING(ID, LEN(ID) - 1, 1) AS INT) % 2 = 0 THEN 'Female'
        ELSE 'Male'
    END AS Gender
INTO NewUsers
FROM Users;

GO

SELECT 
    UserName, 
    COUNT(*) AS DuplicateCount
FROM 
    NewUsers
GROUP BY 
    UserName
HAVING 
    COUNT(*) > 1;

GO


WITH CTE AS (
    SELECT Username, 
           ROW_NUMBER() OVER (PARTITION BY Username ORDER BY (SELECT NULL)) AS RowNum,
           ID -- Replace 'ID' with the correct unique identifier column for users
    FROM NewUsers
)
-- Step 2: Update duplicate usernames
UPDATE NewUsers
SET Username = CTE.Username + CAST(CTE.RowNum AS VARCHAR)
FROM NewUsers AS NU
JOIN CTE ON NU.ID = CTE.ID
WHERE CTE.RowNum > 1;  -- Only update duplicates

GO



DELETE FROM NewUsers
WHERE Gender = 'Female' 
  AND YEAR(DateOfBirth) < 1970;

GO

INSERT INTO NewUsers (ID, UserName, Password, [FirstName], LastName, Email, Phone, Name, Gender)
VALUES ('2', 'Omeedk', '12345', 'Omeed', 'Khalidi', 'Omeedkhalidi22@example.com', '123-456-7890', 'Omeedkhalidi', 'Female');
GO

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NewUsers';

SELECT 
    Gender,
    AVG(DATEDIFF(YEAR, DateOfBirth, GETDATE())) AS 'Average Age'
FROM NewUsers
GROUP BY Gender;
GO

