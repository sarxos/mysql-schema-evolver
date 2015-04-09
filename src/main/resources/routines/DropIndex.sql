
DELIMITER $$

-- -----------------------------------------------------
-- Add procedure to drop column only if column exists
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS DropIndex $$
CREATE PROCEDURE DropIndex(
    IN param_table_name VARCHAR(100),
    IN param_index_name VARCHAR(100)
)
BEGIN
    IF EXISTS (
        SELECT TRUE
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = database()
            AND TABLE_NAME = param_table_name
            AND INDEX_NAME = param_index_name
    )
    THEN
        SET @paramTable = param_table_name ;
        SET @paramIndex = param_index_name ;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` DROP INDEX `', @paramIndex ,'`');
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement ;
    END IF;
END $$

DELIMITER ;
