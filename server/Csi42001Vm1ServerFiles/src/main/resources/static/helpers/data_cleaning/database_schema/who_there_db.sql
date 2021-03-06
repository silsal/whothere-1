-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema who_there_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema who_there_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `who_there_db` DEFAULT CHARACTER SET utf8 ;
USE `who_there_db` ;

-- -----------------------------------------------------
-- Table `who_there_db`.`Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Module` (
  `Module_code` VARCHAR(45) NOT NULL,
  `Facilty` VARCHAR(90) NULL DEFAULT NULL,
  `Course_level` VARCHAR(90) NULL DEFAULT NULL,
  `Undergrad` TINYINT(1) NULL DEFAULT NULL,
  `Module_active` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`Module_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Room` (
  `Room_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Room_no` VARCHAR(45) NULL DEFAULT NULL,
  `Buildling` VARCHAR(45) NULL DEFAULT NULL,
  `Floor_no` VARCHAR(45) NULL DEFAULT NULL,
  `Campus` VARCHAR(45) NULL DEFAULT NULL,
  `Room_active` TINYINT(1) NULL DEFAULT NULL,
  `Capacity` INT(11) NULL DEFAULT NULL,
  `Plug_friendly` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Room_id`),
  UNIQUE INDEX `Room_id_UNIQUE` (`Room_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Processed_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Processed_data` (
  `Data_input_id` INT(11) NOT NULL,
  `Data` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`Data_input_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Ground_truth_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Ground_truth_data` (
  `Data_input_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Room_Room_id` INT(11) NULL DEFAULT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `Time` TIME NULL DEFAULT NULL,
  `Room_used` TINYINT(1) NULL DEFAULT NULL,
  `Percentage_room_full` FLOAT NULL DEFAULT NULL,
  `No_of_people` INT(11) NULL DEFAULT NULL,
  `Lecture` TINYINT(1) NULL DEFAULT NULL,
  `Tutorial` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Data_input_id`),
  UNIQUE INDEX `Data_input_id_UNIQUE` (`Data_input_id` ASC),
  INDEX `fk_ground_truth_data_Room1_idx` (`Room_Room_id` ASC),
  CONSTRAINT `fk_ground_truth_data_Room1`
    FOREIGN KEY (`Room_Room_id`)
    REFERENCES `who_there_db`.`Room` (`Room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Time_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Time_table` (
  `Date` DATE NOT NULL,
  `Time_period` TIME NOT NULL,
  `Room_Room_id` INT(11) NOT NULL,
  `Module_Module_code` VARCHAR(45) NOT NULL,
  `No_expected_students` INT(11) NULL DEFAULT NULL,
  `Tutorial` TINYINT(1) NULL DEFAULT NULL,
  `Double_module` TINYINT(1) NULL DEFAULT '0',
  `Class_went_ahead` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Date`, `Time_period`, `Room_Room_id`, `Module_Module_code`),
  INDEX `fk_time_table_Room1_idx` (`Room_Room_id` ASC),
  INDEX `fk_time_table_Module1_idx` (`Module_Module_code` ASC),
  CONSTRAINT `fk_time_table_Module1`
    FOREIGN KEY (`Module_Module_code`)
    REFERENCES `who_there_db`.`Module` (`Module_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_table_Room1`
    FOREIGN KEY (`Room_Room_id`)
    REFERENCES `who_there_db`.`Room` (`Room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Users` (
  `Users_id` INT(11) NOT NULL,
  `User_name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Admin` TINYINT(1) NOT NULL,
  `Acount_active` TINYINT(1) NULL DEFAULT NULL,
  `Ground_truth_access_code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Users_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `who_there_db`.`Wifi_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `who_there_db`.`Wifi_log` (
  `Wifi_log_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Room_Room_id` INT(11) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `Time` TIME NULL DEFAULT NULL,
  `Associated_client_counts` INT(11) NULL DEFAULT NULL,
  `Authenticated_client_counts` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Wifi_log_id`),
  UNIQUE INDEX `wifi_log_id_UNIQUE` (`Wifi_log_id` ASC),
  INDEX `fk_wifi_log_Room1_idx` (`Room_Room_id` ASC),
  CONSTRAINT `fk_wifi_log_Room1`
    FOREIGN KEY (`Room_Room_id`)
    REFERENCES `who_there_db`.`Room` (`Room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
