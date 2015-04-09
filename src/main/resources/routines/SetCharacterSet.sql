
DELIMITER $$

-- -----------------------------------------------------
-- Set characters set.
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS SetCharacterSet $$
CREATE PROCEDURE SetCharacterSet(
    IN param_table_name VARCHAR(100),
    IN param_cset VARCHAR(100)
)
BEGIN
    IF EXISTS (
        SELECT TRUE
        FROM
            INFORMATION_SCHEMA.TABLES T,
            INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY CCSA
        WHERE CCSA.collation_name = T.table_collation
            AND TABLE_SCHEMA = database()
            AND TABLE_NAME = param_table_name
            AND CCSA.character_set_name != param_cset
    )
    THEN
        SET @paramTable = param_table_name ;
        SET @paramCSet = param_cset ;
        SET @statementToExecute = concat('ALTER TABLE `', @paramTable, '` CHARACTER SET = ', @paramCSet);
        prepare DynamicStatement FROM @statementToExecute;
        execute DynamicStatement;
        deallocate prepare DynamicStatement ;
    END IF;
END $$

DELIMITER ;
