-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- Drop existing tables if they exist
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders`;
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu_Items`;
DROP TABLE IF EXISTS `LittleLemonDB`.`Menus`;
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings`;
DROP TABLE IF EXISTS `LittleLemonDB`.`Customers`;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `Customer_ID` INT NOT NULL,
  `Full_Name` VARCHAR(45) NULL,
  `Contact_Number` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_ID`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `Booking_ID` INT NOT NULL,
  `Customer_ID` INT NULL,
  `Table_Number` INT NULL,
  `Booking_Date` DATE NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `Customer ID_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `Customer ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `LittleLemonDB`.`Customers` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_Items` (
  `Menu_Items_ID` INT NOT NULL,
  `Course_Name` VARCHAR(45) NULL,
  `Starter_Name` VARCHAR(45) NULL,
  `Sesert_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Menu_Items_ID`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `Menu_ID` INT NOT NULL,
  `Menu_Items_ID` INT NULL,
  `Menu_Name` VARCHAR(45) NULL,
  `Cuisine` VARCHAR(45) NULL,
  PRIMARY KEY (`Menu_ID`),
  INDEX `Menu Items ID_idx` (`Menu_Items_ID` ASC) VISIBLE,
  CONSTRAINT `Menu Items ID`
    FOREIGN KEY (`Menu_Items_ID`)
    REFERENCES `LittleLemonDB`.`Menu_Items` (`Menu_Items_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `Order_ID` INT NOT NULL,
  `Menu_ID` INT NULL,
  `Customer_ID` INT NULL,
  `Order_Date` DATE NULL,
  `Quantity` INT NULL,
  `Total_Cost` DECIMAL(10,2) NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Menu ID_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Customer ID_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Menu_ID`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `LittleLemonDB`.`Menus` (`Menu_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `LittleLemonDB`.`Customers` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
