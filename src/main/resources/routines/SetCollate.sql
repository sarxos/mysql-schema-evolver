
DELIMITER $$

-- -----------------------------------------------------
-- Set table collate.
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS SetCollate $$
CREATE PROCEDURE SetCollate(
    IN param_table_name VARCHAR(100),
    IN param_collate VARCHAR(100)
)
BEGIN
    IF EXISTS (
        SELECT TRUE
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = database()
            AND TABLE_NAME = param_table_name
            AND TABLE_COLLATION != param_collate
    )
    THEN
        SET @paramTable = param_table_name ;
        SET @paramCollate = param_collate ;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` COLLATE = ', @paramCollate);
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement ;
    END IF;
END $$

DELIMITER ;
