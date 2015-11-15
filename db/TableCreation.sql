-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Photography
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Photography
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `Photography` ;
-- USE `Photography` ;

-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Person` (
  `PersonID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NULL,
  PRIMARY KEY (`PersonID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Photographers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Photographers` (
  `PhotographerID` INT NOT NULL,
  `PersonID` INT NOT NULL,
  `Rating` INT NULL,
  PRIMARY KEY (`PhotographerID`),
  CONSTRAINT `fk_Photographers_Person`
    FOREIGN KEY (`PersonID`)
    REFERENCES `Person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Customers` (
  `CustomerID` INT NOT NULL,
  `BillingInfo` VARCHAR(100) NOT NULL,
  `PersonID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `fk_Customers_Person1`
    FOREIGN KEY (`PersonID`)
    REFERENCES `Person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comment` (
  `CommentID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Content` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CommentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Review` (
  `ReviewID` INT NOT NULL,
  `Rating` INT NOT NULL,
  `Comment` VARCHAR(300) NULL,
  `Customers_CustomerID` INT NOT NULL,
  `Photographers_PhotographerID` INT NOT NULL,
  `Comment_CommentID` INT NOT NULL,
  PRIMARY KEY (`ReviewID`),
  CONSTRAINT `fk_Review_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_Photographers1`
    FOREIGN KEY (`Photographers_PhotographerID`)
    REFERENCES `Photographers` (`PhotographerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_Comment1`
    FOREIGN KEY (`Comment_CommentID`)
    REFERENCES `Comment` (`CommentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PhotoPackages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PhotoPackages` (
  `PackageID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `Description` VARCHAR(100) NULL,
  PRIMARY KEY (`PackageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Booking` (
  `BookingID` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `EventType` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  `CustomerID` INT NOT NULL,
  `PhotoPackages_PackageID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  CONSTRAINT `fk_Booking_Customers1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_PhotoPackages1`
    FOREIGN KEY (`PhotoPackages_PackageID`)
    REFERENCES `PhotoPackages` (`PackageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Photographs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Photographs` (
  `PhotoID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `DateTaken` DATE NOT NULL,
  `Description` VARCHAR(100) NULL,
  `Picture` POLYGON NOT NULL,
  `Photographers_PhotographerID` INT NOT NULL,
  `Booking_BookingID` INT NULL,
  `Customers_CustomerID` INT NULL,
  PRIMARY KEY (`PhotoID`),
  CONSTRAINT `fk_Photographs_Photographers1`
    FOREIGN KEY (`Photographers_PhotographerID`)
    REFERENCES `Photographers` (`PhotographerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Photographs_Booking1`
    FOREIGN KEY (`Booking_BookingID`)
    REFERENCES `Booking` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Photographs_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Blog` (
  `PostID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `NumLikes` INT NULL,
  `Content` VARCHAR(1000) NOT NULL,
  `Category` VARCHAR(45) NULL,
  `Photographers_PhotographerID` INT NOT NULL,
  PRIMARY KEY (`PostID`),
  CONSTRAINT `fk_Blog_Photographers1`
    FOREIGN KEY (`Photographers_PhotographerID`)
    REFERENCES `Photographers` (`PhotographerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ScheduledPhotographers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ScheduledPhotographers` (
  `Photographers_PhotographerID` INT NOT NULL,
  `Booking_BookingID` INT NOT NULL,
  CONSTRAINT `fk_ScheduledPhotographers_Photographers1`
    FOREIGN KEY (`Photographers_PhotographerID`)
    REFERENCES `Photographers` (`PhotographerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ScheduledPhotographers_Booking1`
    FOREIGN KEY (`Booking_BookingID`)
    REFERENCES `Booking` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PostComments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostComments` (
  `Blog_PostID` INT NOT NULL,
  `Comment_CommentID` INT NOT NULL,
  PRIMARY KEY (`Blog_PostID`, `Comment_CommentID`),
  CONSTRAINT `fk_PostComments_Blog1`
    FOREIGN KEY (`Blog_PostID`)
    REFERENCES `Blog` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PostComments_Comment1`
    FOREIGN KEY (`Comment_CommentID`)
    REFERENCES `Comment` (`CommentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
