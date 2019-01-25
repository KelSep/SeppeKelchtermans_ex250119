-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Medical genetics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Medical genetics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Medical genetics` ;
USE `Medical genetics` ;

-- -----------------------------------------------------
-- Table `Medical genetics`.`genes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical genetics`.`genes` ;

CREATE TABLE IF NOT EXISTS `Medical genetics`.`genes` (
  `id_gene` INT NOT NULL AUTO_INCREMENT,
  `gene_name` VARCHAR(45) NULL,
  `description affected gene` VARCHAR(200) NULL,
  `chromosome` CHAR(2) NULL,
  PRIMARY KEY (`id_gene`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medical genetics`.`mutations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical genetics`.`mutations` ;

CREATE TABLE IF NOT EXISTS `Medical genetics`.`mutations` (
  `id_mutations` INT NOT NULL AUTO_INCREMENT,
  `id_gene` INT NULL,
  `start_position` INT NULL,
  `end_position` VARCHAR(45) NULL,
  PRIMARY KEY (`id_mutations`),
  CONSTRAINT `fk_gene`
    FOREIGN KEY (`id_gene`)
    REFERENCES `Medical genetics`.`genes` (`id_gene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_gene_idx` ON `Medical genetics`.`mutations` (`id_gene` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Medical genetics`.`Syndrome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical genetics`.`Syndrome` ;

CREATE TABLE IF NOT EXISTS `Medical genetics`.`Syndrome` (
  `id_syndrome` INT NOT NULL AUTO_INCREMENT,
  `syndrome_description` VARCHAR(200) NULL,
  `syndrome_name` VARCHAR(45) NULL,
  `id_mutations` INT NOT NULL,
  `id_gene` INT NOT NULL,
  PRIMARY KEY (`id_syndrome`),
  CONSTRAINT `fk_mutation`
    FOREIGN KEY (`id_mutations`)
    REFERENCES `Medical genetics`.`mutations` (`id_mutations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_genes`
    FOREIGN KEY (`id_gene`)
    REFERENCES `Medical genetics`.`genes` (`id_gene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mutation_idx` ON `Medical genetics`.`Syndrome` (`id_mutations` ASC) VISIBLE;

CREATE INDEX `fk_genes_idx` ON `Medical genetics`.`Syndrome` (`id_gene` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Medical genetics`.`patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical genetics`.`patient` ;

CREATE TABLE IF NOT EXISTS `Medical genetics`.`patient` (
  `id_patient` INT NOT NULL,
  `patient_name` VARCHAR(45) NULL,
  `id_syndrome` INT NOT NULL,
  `gender` ENUM('M', 'V', 'X') NULL,
  `age at diagnosis` INT NULL,
  PRIMARY KEY (`id_patient`),
  CONSTRAINT `fk_syndrome`
    FOREIGN KEY (`id_syndrome`)
    REFERENCES `Medical genetics`.`Syndrome` (`id_syndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_syndrome_idx` ON `Medical genetics`.`patient` (`id_syndrome` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
