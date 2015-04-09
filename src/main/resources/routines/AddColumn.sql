
DELIMITER $$

-- -----------------------------------------------------
-- Add procedure to add column only if not exists
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS AddColumn $$
CREATE PROCEDURE AddColumn(
    IN param_table_name VARCHAR(100),
    IN param_column VARCHAR(100),
    IN param_column_details VARCHAR(100)
)
BEGIN
    IF NOT EXISTS (
        SELECT
            NULL
        FROM
            information_schema.COLUMNS
        WHERE
            COLUMN_NAME = param_column AND
            TABLE_NAME=param_table_name AND
            table_schema = database()
    )
    THEN
        SET @paramTable = param_table_name ;
        SET @paramColumn = param_column ;
        SET @paramColumnDetails = param_column_details;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` ADD COLUMN `', @paramColumn, '` ', @paramColumnDetails);
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement ;
    END IF;
END $$

DELIMITER ;
