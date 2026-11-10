USE [Airport Management];
GO

-- Exact columns, types, nullability and identity
SELECT
    TABLE_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE,
    COLUMNPROPERTY(
        OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)),
        COLUMN_NAME,
        'IsIdentity'
    ) AS IS_IDENTITY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('Airport', 'Aircraft', 'Terminal', 'Gate', 'Flight')
ORDER BY TABLE_NAME, ORDINAL_POSITION;
GO

-- Primary keys
SELECT
    tc.TABLE_NAME,
    kcu.COLUMN_NAME,
    tc.CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND tc.TABLE_NAME IN ('Airport', 'Aircraft', 'Terminal', 'Gate', 'Flight')
ORDER BY tc.TABLE_NAME, kcu.ORDINAL_POSITION;
GO

-- Foreign keys
SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fkc.parent_object_id) AS TableName,
    pc.name AS ColumnName,
    OBJECT_NAME(fkc.referenced_object_id) AS ReferencedTable,
    rc.name AS ReferencedColumn
FROM sys.foreign_keys AS fk
JOIN sys.foreign_key_columns AS fkc
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns AS pc
    ON pc.object_id = fkc.parent_object_id
   AND pc.column_id = fkc.parent_column_id
JOIN sys.columns AS rc
    ON rc.object_id = fkc.referenced_object_id
   AND rc.column_id = fkc.referenced_column_id
WHERE OBJECT_NAME(fkc.parent_object_id) IN ('Airport', 'Aircraft', 'Terminal', 'Gate', 'Flight')
ORDER BY TableName, ForeignKeyName;
GO
