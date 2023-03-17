CREATE SCHEMA IF NOT EXISTS `dbwork`;
USE `dbwork` ;

CREATE TABLE IF NOT EXISTS `dbwork`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Gender` VARCHAR(10) NULL,
  `Phone_Number` VARCHAR(20) NULL,
  `Email` VARCHAR(100) NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC) );

CREATE TABLE IF NOT EXISTS `dbwork`.`Communications` (
  `CommunicationsID` INT NOT NULL AUTO_INCREMENT,
  `CommBody` VARCHAR(200) NULL,
  `Employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`CommunicationsID`),
  UNIQUE INDEX `CommunicationsID_UNIQUE` (`CommunicationsID` ASC) ,
  CONSTRAINT `fk_Communications_Employee`
    FOREIGN KEY (`Employee_EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `z`.`Loans` (
  `LoanID` INT NOT NULL  AUTO_INCREMENT,
  `Amount` VARCHAR(20) NULL,
  `Category` VARCHAR(45) NULL,
  `Benefiaciary` VARCHAR(50) NULL,
  `Date` VARCHAR(15) NULL,
  PRIMARY KEY (`LoanID`));

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `Email` VARCHAR(70) NULL,
  `Phone_Number` VARCHAR(20) NULL,
  `Gender` VARCHAR(10) NULL,
  `Loans_LoanID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) ,
  INDEX `fk_Customer_Loans1_idx` (`Loans_LoanID` ASC) ,
  CONSTRAINT `fk_Customer_Loans1`
    FOREIGN KEY (`Loans_LoanID`)
    REFERENCES `mydb`.`Loans` (`LoanID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `mydb`.`Deposit` (
  `DepositID` INT NOT NULL AUTO_INCREMENT,
  `Amount` VARCHAR(15) NULL,
  `Date` VARCHAR(15) NULL,
  `Time` VARCHAR(15) NULL,
  PRIMARY KEY (`DepositID`),
  UNIQUE INDEX `DepositID_UNIQUE` (`DepositID` ASC) );
CREATE TABLE IF NOT EXISTS `mydb`.`loans` (
  `loansID` INT NOT NULL,
  `loanType` VARCHAR(45) NOT NULL,
  `loanAmount` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`loansID`));
CREATE TABLE IF NOT EXISTS `mydb`.`BankResource` (
  `BankResourceID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Category` VARCHAR(20) NOT NULL,
  `Amount` VARCHAR(13) NULL,
  `Employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`BankResourceID`),
  INDEX `fk_BankResource_Employee1_idx` (`Employee_EmployeeID` ASC) ,
  CONSTRAINT `fk_BankResource_Employee1`
    FOREIGN KEY (`Employee_EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `mydb`.`Cheques` (
  `ChequeID` INT NOT NULL AUTO_INCREMENT,
  `Beneficiary` VARCHAR(50) NULL,
  `Benefactor` VARCHAR(50) NULL,
  `Amount` VARCHAR(15) NULL,
  `Date` VARCHAR(15) NULL,
  `Customer_CustomerID` INT NOT NULL,
  UNIQUE INDEX `ChequeID_UNIQUE` (`ChequeID` ASC) ,
  PRIMARY KEY (`ChequeID`),
  INDEX `fk_Cheques_Customer1_idx` (`Customer_CustomerID` ASC) ,
  CONSTRAINT `fk_Cheques_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
CREATE TABLE IF NOT EXISTS `mydb`.`Loan_Requests` (
  `Loan_RequestID` INT NOT NULL AUTO_INCREMENT,
  `Security` VARCHAR(80) NULL,
  `Amount` VARCHAR(15) NULL,
  `Beneficiary` VARCHAR(60) NULL,
  `Due Date` VARCHAR(20) NULL,
  `Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`Loan_RequestID`),
  UNIQUE INDEX `Loan_RequestID_UNIQUE` (`Loan_RequestID` ASC) ,
  INDEX `fk_Loan_Requests_Customer1_idx` (`Customer_CustomerID` ASC) ,
  CONSTRAINT `fk_Loan_Requests_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Withdrawal` (
  `WithdrawalID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(60) NULL,
  `Amount` VARCHAR(15) NULL,
  `Date` VARCHAR(20) NULL,
  UNIQUE INDEX `WithdrawalID_UNIQUE` (`WithdrawalID` ASC) ,
  PRIMARY KEY (`WithdrawalID`));

CREATE TABLE IF NOT EXISTS `mydb`.`Transfers` (
  `TransfersID` INT NOT NULL AUTO_INCREMENT,
  `Beneficiary` VARCHAR(60) NULL,
  `Benefactor` VARCHAR(60) NULL,
  `Amount` VARCHAR(15) NULL,
  `Date` VARCHAR(20) NULL,
  PRIMARY KEY (`TransfersID`),
  UNIQUE INDEX `TransfersID_UNIQUE` (`TransfersID` ASC)
);

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `AccountID` INT NOT NULL AUTO_INCREMENT,
  `AccountHolder` VARCHAR(60) NULL,
  `AccountType` VARCHAR(20) NULL,
  `Amount` VARCHAR(15) NULL,
  `DOC` VARCHAR(15) NULL,
  `Customer_CustomerID` INT NOT NULL,
  `Customer_CustomerID1` INT NOT NULL,
  PRIMARY KEY (`AccountID`, `Customer_CustomerID`),
  UNIQUE INDEX `AccountID_UNIQUE` (`AccountID` ASC) ,
  INDEX `fk_Account_Customer1_idx` (`Customer_CustomerID1` ASC) ,
  CONSTRAINT `fk_Account_Customer1`
    FOREIGN KEY (`Customer_CustomerID1`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `mydb`.`BankStatements` (
  `BankStatementsID` INT NOT NULL AUTO_INCREMENT,
  `Summary` VARCHAR(45) NULL,
  `Name` VARCHAR(60) NULL,
  `Date` VARCHAR(15) NULL,
  `Account_AccountID` INT NOT NULL,
  `Account_Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`BankStatementsID`),
  UNIQUE INDEX `BankStatementsID_UNIQUE` (`BankStatementsID` ASC) ,
  INDEX `fk_BankStatements_Account1_idx` (`Account_AccountID` ASC, `Account_Customer_CustomerID` ASC) ,
  CONSTRAINT `fk_BankStatements_Account1`
    FOREIGN KEY (`Account_AccountID` , `Account_Customer_CustomerID`)
    REFERENCES `mydb`.`Account` (`AccountID` , `Customer_CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `mydb`.`Customer_has_Transfers` (
  `Customer_CustomerID` INT NOT NULL,
  `Transfers_TransfersID` INT NOT NULL,
  INDEX `fk_Customer_has_Transfers_Customer1_idx` (`Customer_CustomerID` ASC) ,
  INDEX `fk_Customer_has_Transfers_Transfers1_idx` (`Transfers_TransfersID` ASC) ,
  CONSTRAINT `fk_Customer_has_Transfers_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Transfers_Transfers1`
    FOREIGN KEY (`Transfers_TransfersID`)
    REFERENCES `mydb`.`Transfers` (`TransfersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Customer_has_Withdrawal` (
  `Customer_CustomerID` INT NOT NULL,
  `Withdrawal_WithdrawalID` INT NOT NULL,
  PRIMARY KEY (`Customer_CustomerID`, `Withdrawal_WithdrawalID`),
  INDEX `fk_Customer_has_Withdrawal_Withdrawal1_idx` (`Withdrawal_WithdrawalID` ASC) ,
  INDEX `fk_Customer_has_Withdrawal_Customer1_idx` (`Customer_CustomerID` ASC) ,
  CONSTRAINT `fk_Customer_has_Withdrawal_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Withdrawal_Withdrawal1`
    FOREIGN KEY (`Withdrawal_WithdrawalID`)
    REFERENCES `mydb`.`Withdrawal` (`WithdrawalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE mydb.Customer_has_Deposit (
  Customer_CustomerID INT NOT NULL,
  Deposit_DepositID INT NOT NULL,
  PRIMARY KEY (Customer_CustomerID, Deposit_DepositID),
  CONSTRAINT fk_Customer_has_Deposit_Customer1
    FOREIGN KEY (Customer_CustomerID)
    REFERENCES mydb.Customer (CustomerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Customer_has_Deposit_Deposit1
    FOREIGN KEY (Deposit_DepositID)
    REFERENCES mydb.Deposit (DepositID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);