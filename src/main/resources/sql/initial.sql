
-- -----------------------------------------------------
-- Table `version`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `version` (
  `id` INT NOT NULL ,
  `version` VARCHAR(21) NOT NULL DEFAULT '00.00.00.00.00.00.000' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

START TRANSACTION;
INSERT INTO `version` (id, version) VALUES (1, '00.00.00.00.00.00.001');
COMMIT;
