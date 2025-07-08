

DECLARE @sql NVARCHAR(MAX) = '';
DECLARE @table_name NVARCHAR(255);
DECLARE @identity_column NVARCHAR(255);

-- Create a table variable to store the exclusion list
DECLARE @ExclusionList TABLE (
    TableName NVARCHAR(255)
);

-- Populate the exclusion list with table names to exclude
INSERT INTO @ExclusionList (TableName)
VALUES 
    ('RBAC_Permission'),
    ('BIL_CFG_FiscalYears'),
	('INV_CFG_FiscalYears'),
	('PHRM_CFG_FiscalYears'),
	('MST_FiscalYear'),
    ('RBAC_Role'),
    ('RBAC_RouteConfig'),
    ('RBAC_Application'),
    ('ICD_DiseaseGroup'),
    ('ICD_Emergency_DiseaseGroup'),
    ('ICD_Emergency_ReportingGroup'),
    ('ICD_ReportingGroup'),
    ('MST_ICD10'),
    ('BIL_CFG_Counter'),
    ('CFG_PaymentModeSettings'),
    ('CFG_PrinterSettings'),
    ('Lab_MST_RunNumberSettings'),
    ('MST_EthnicGroup'),
    ('MST_LabTypes'),
	('MST_Country'),
	('MST_CountrySubDivision'),
	('MST_Municipality'),
	('CLN_MST_Vitals'),
	('CLN_MST_MedicationFrequencyStandard'),
    ('CLN_MST_MedicationIntakeData'),
    ('CLN_MST_NoteType'),
    ('CLN_MST_PreDevelopedComponentList'),
	('CLN_MST_ClinicalNotes'),
    ('CLN_MST_ClinicalHeading'),
    ('CLN_MST_ClinicalField'),
    ('CLN_MST_ChiefComplain'),
    ('CLN_MST_Questionnaire'),
    ('CLN_MST_ClinicalQuestionOption'),
    ('CLN_MST_ClinicalFieldOption'),
    ('CLN_MST_ClinicalTemplates'),
    ('CLN_MST_Vitals'),
    ('CLN_MST_ClinicalNotesMaster'),
	('MST_Salutations'),
	('PHRM_MST_SalesCategory'),
	('PHRM_MST_Store'),
	('INV_MST_ItemCategory'),
	('RAD_MST_ImagingType'),
	('RAD_MST_FilmType');

-- Disable all triggers
PRINT 'Disabling Triggers...';
EXEC sp_MSforeachtable 'DISABLE TRIGGER ALL ON ?';

-- Disable all foreign key constraints
PRINT 'Disabling Foreign Key Constraints...';
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Cursor to iterate through tables (both child and parent) excluding those in the exclusion list
DECLARE table_cursor CURSOR FOR
SELECT DISTINCT
    tr.name AS table_name
FROM sys.foreign_keys AS fk
INNER JOIN sys.tables AS tp ON fk.referenced_object_id = tp.object_id
INNER JOIN sys.tables AS tr ON fk.parent_object_id = tr.object_id
WHERE tp.name NOT IN (SELECT TableName FROM @ExclusionList) -- Exclude parent tables
  AND tr.name NOT IN (SELECT TableName FROM @ExclusionList) -- Exclude child tables
UNION
SELECT DISTINCT
    tp.name AS table_name
FROM sys.foreign_keys AS fk
INNER JOIN sys.tables AS tp ON fk.referenced_object_id = tp.object_id
INNER JOIN sys.tables AS tr ON fk.parent_object_id = tr.object_id
WHERE tp.name NOT IN (SELECT TableName FROM @ExclusionList) -- Exclude parent tables
  AND tr.name NOT IN (SELECT TableName FROM @ExclusionList); -- Exclude child tables

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @table_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        -- Generate DELETE statement for the table
        SET @sql = '
        IF EXISTS (SELECT 1 FROM ' + QUOTENAME(@table_name) + ')
        BEGIN
            PRINT ''Deleting from ' + @table_name + '...'';
            DELETE FROM ' + QUOTENAME(@table_name) + ';
        END
        ';

        PRINT @sql; -- Debugging purpose
        EXEC sp_executesql @sql;

        -- Check if the table has an identity column
        SET @sql = '
        SELECT @identity_column = COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = ''' + @table_name + '''
        AND COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA + ''.'' + TABLE_NAME), COLUMN_NAME, ''IsIdentity'') = 1;
        ';

        EXEC sp_executesql @sql, N'@identity_column NVARCHAR(255) OUTPUT', @identity_column OUTPUT;

        -- Reseed identity column if necessary
        IF @identity_column IS NOT NULL
        BEGIN
            SET @sql = '
            IF IDENT_CURRENT(''' + @table_name + ''') >= 1
            BEGIN
                PRINT ''Reseeding identity column in ' + @table_name + '...'';
                DBCC CHECKIDENT (' + QUOTENAME(@table_name) + ', RESEED, 0);
            END
            ';

            PRINT @sql; -- Debugging purpose
            EXEC sp_executesql @sql;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error processing table ' + @table_name + ': ' + ERROR_MESSAGE();
    END CATCH

    FETCH NEXT FROM table_cursor INTO @table_name;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Enable all foreign key constraints back
PRINT 'Re-enabling Foreign Key Constraints...';
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';

-- Re-enable all triggers
PRINT 'Re-enabling Triggers...';
EXEC sp_MSforeachtable 'ENABLE TRIGGER ALL ON ?';
GO