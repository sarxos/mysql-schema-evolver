DELIMITER $$

-- -----------------------------------------------------
-- Add procedure to drop column only if column exists
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS DropColumn $$
CREATE PROCEDURE DropColumn(
    IN param_table_name VARCHAR(100),
    IN param_column VARCHAR(100)
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
        SET @paramTable = param_table_name ;
        SET @paramColumn = param_column ;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` DROP COLUMN `', @paramColumn, '`');
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement;
    END IF;
END $$

DELIMITER ;
