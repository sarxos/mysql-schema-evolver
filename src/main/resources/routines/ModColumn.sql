
DELIMITER $$

-- -----------------------------------------
-- Modifies column if exists
-- -----------------------------------------

DROP PROCEDURE IF EXISTS ModColumn $$
CREATE PROCEDURE ModColumn(
    IN param_table_name VARCHAR(100),
    IN param_column VARCHAR(100),
    IN param_column_new VARCHAR(100),
    IN param_column_details VARCHAR(100)
)
BEGIN
    IF EXISTS (
           SELECT
               NULL
           FROM
               information_schema.COLUMNS
        WHERE
            COLUMN_NAME = param_column AND
            TABLE_NAME = param_table_name AND
            table_schema = database()
    )
    THEN
        SET @ParamTable = param_table_name;
        SET @ParamColumn = param_column;
        SET @ParamColumnNew = param_column_new;
        SET @ParamColumnDetails = param_column_details;
        SET @StatementToExecute = concat('ALTER TABLE `', @ParamTable, '` CHANGE COLUMN `', @ParamColumn, '` `', @ParamColumnNew, '` ', @ParamColumnDetails);
        prepare DynamicStatement FROM @StatementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement;
    END IF;
END $$

DELIMITER ;
