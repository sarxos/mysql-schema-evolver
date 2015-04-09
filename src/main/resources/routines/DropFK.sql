
DELIMITER $$

-- -----------------------------------------------------
-- Procedure to drop FK only if exists
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS DropFK $$
CREATE PROCEDURE DropFK(
    IN param_table_name VARCHAR(100),
    IN fk_name VARCHAR(100)
)
BEGIN
    IF EXISTS (
        SELECT TRUE
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
            AND TABLE_SCHEMA = database()
            AND CONSTRAINT_NAME = fk_name
    )
    THEN
        SET @paramTable = param_table_name ;
        SET @paramFK = fk_name ;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` DROP FOREIGN KEY `', @paramFK , '`');
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement ;
    END IF;
END $$

DELIMITER ;
