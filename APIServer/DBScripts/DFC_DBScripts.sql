CREATE SCHEMA `dfc` ;


CREATE TABLE `dfc`.`UserDetails` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EMail` VARCHAR(100) NULL,
  `Mobile` VARCHAR(20) NULL,
  `AlternateMobile` VARCHAR(20) NULL,
  `HomePhone` VARCHAR(20) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) 
);
  
CREATE TABLE `dfc`.`Passwords` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PasswordHash` VARCHAR(255) NULL,
  `PasswordSalt` VARCHAR(255) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) 
);

CREATE TABLE `dfc`.`Users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Active` tinyint NOT NULL DEFAULT '1',
  `DetailID` int(11) NOT NULL,
  `PasswordID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`),
  CONSTRAINT `Users_DetailID` FOREIGN KEY (`DetailID`) REFERENCES `userdetails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Users_PasswordID` FOREIGN KEY (`PasswordID`) REFERENCES `passwords` (`id`) ON DELETE CASCADE
) ;

CREATE TABLE `dfc`.`ScreenGroups` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);
	
CREATE TABLE `dfc`.`Screens` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(100) NULL,
  `ScreenGroupID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)  
);

CREATE TABLE `dfc`.`ScreenElements` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ControlID` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Description` VARCHAR(100) NULL,
  `ScreenID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE  
);
	
CREATE TABLE `dfc`.`Roles` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(255) NULL,
  `Active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);

CREATE TABLE `dfc`.`RolePermissions` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RoleID` INT NOT NULL,
  `ScreenGroupID` INT NOT NULL,
  `ScreenID` INT NOT NULL,
  `ScreenElementID` INT NULL,
  `Allowed` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)  
);
	
CREATE TABLE `dfc`.`UserRoles` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `RoleID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)  
);
		
CREATE TABLE `dfc`.`Countries` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `CreatedByUserID` INT NULL,
  `CreatedDateTime` DATETIME NULL,
  `UpdatedByUserID` INT NULL,
  `UpdatedDateTime` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)  
);

CREATE TABLE `dfc`.`States` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `CountryID` INT NOT NULL,
  `CreatedByUserID` INT NULL,
  `CreatedDateTime` DATETIME NULL,
  `UpdatedByUserID` INT NULL,
  `UpdatedDateTime` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)  
);

CREATE TABLE `dfc`.`Districts` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `StateID` INT NOT NULL,
  `CreatedByUserID` INT NULL,
  `CreatedDateTime` DATETIME NULL,
  `UpdatedByUserID` INT NULL,
  `UpdatedDateTime` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)    
);


CREATE TABLE `dfc`.`Cities` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `CityType` VARCHAR(10) NULL,
  `Active` tinyint NOT NULL DEFAULT '1',
  `DistrictID` INT NOT NULL,
  `CreatedByUserID` INT NULL,
  `CreatedDateTime` DATETIME NULL,
  `UpdatedByUserID` INT NULL,
  `UpdatedDateTime` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);


CREATE TABLE `dfc`.`Currencies` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);

CREATE TABLE `dfc`.`Units` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);

CREATE TABLE `dfc`.`DocumentTypes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);	

CREATE TABLE `dfc`.`StatusCodes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NULL,
  `AssociatedEntity` VARCHAR(1) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC)
);	

CREATE TABLE `dfc`.`ProjectTradeLimits` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`BuyLimitMin` FLOAT,
	`SellLimitMin` FLOAT,
	`BuyLimitMax` FLOAT,
	`SellLimitMax` FLOAT,
	`UpdatedByUserID` INT NULL,
	`UpdatedDateTime` DATETIME NULL,
	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
	CONSTRAINT `ProjectTradeLimits_UpdatedByUserID` FOREIGN KEY (`UpdatedByUserID`) REFERENCES `Users` (`ID`)
);

CREATE TABLE `dfc`.`ProjectContents` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Content` VARCHAR(5000) NOT NULL,
	`UpdatedByUserID` INT NULL,
	`UpdatedDateTime` DATETIME NULL,
	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
	CONSTRAINT `ProjectContents_UpdatedByUserID` FOREIGN KEY (`UpdatedByUserID`) REFERENCES `Users` (`ID`)
);

CREATE TABLE `dfc`.`Projects` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(255) NOT NULL,
	`ShortDescription` VARCHAR(255) NOT NULL,
	`StartDate` DATE NOT NULL,
	`EndDate` DATE NULL,
	`TotalArea` FLOAT NOT NULL,
	`NoofUnits` INT NOT NULL,
	`BasePrice` DECIMAL(11,4) NOT NULL,

	`StatusID` INT NOT NULL,
	`UnitID` INT NOT NULL,
	`CurrencyID` INT NOT NULL,
	`TradeLimitID` INT NOT NULL,
	`ContentID` INT NOT NULL,

	`Active` tinyint NOT NULL DEFAULT '1',
	`CreatedByUserID` INT NULL,
	`CreatedDateTime` DATETIME NULL,
	`UpdatedByUserID` INT NULL,
	`UpdatedDateTime` DATETIME NULL,

	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
	CONSTRAINT `Projects_UnitID` FOREIGN KEY (`UnitID`) REFERENCES `Units` (`ID`),
	CONSTRAINT `Projects_StatusID` FOREIGN KEY (`StatusID`) REFERENCES `StatusCodes` (`ID`),
	CONSTRAINT `Projects_TradeLimitID` FOREIGN KEY (`TradeLimitID`) REFERENCES `ProjectTradeLimits` (`ID`),
	CONSTRAINT `Projects_ContentID` FOREIGN KEY (`ContentID`) REFERENCES `ProjectContents` (`ID`),
	CONSTRAINT `Projects_CreatedByUserID` FOREIGN KEY (`CreatedByUserID`) REFERENCES `Users` (`ID`),
	CONSTRAINT `Projects_UpdatedByUserID` FOREIGN KEY (`UpdatedByUserID`) REFERENCES `Users` (`ID`)
);

CREATE TABLE `dfc`.`ProjectDocuments` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(255) NOT NULL,
	`ProjectID` int NULL,
	`DocumentTypeID` int NOT NULL,
	`Description` VARCHAR(500) NOT NULL,
	`Remarks` VARCHAR(500) NOT NULL,
	`Location` VARCHAR(500) NOT NULL,
	`IsAgentVisible` BOOLEAN NOT NULL,
	`IsVendorVisible` BOOLEAN NOT NULL,
	`IsCustomerVisible` BOOLEAN NOT NULL,
	`IsPrivateVisible` BOOLEAN NOT NULL,
	`CreatedByUserID` INT NULL,
	`CreatedDateTime` DATETIME NULL,
	`UpdatedByUserID` INT NULL,
	`UpdatedDateTime` DATETIME NULL,

	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
	CONSTRAINT `ProjectDocuments_ProjectID` FOREIGN KEY (`ProjectID`) REFERENCES `Projects` (`ID`),
	CONSTRAINT `ProjectDocuments_DocumentTypeID` FOREIGN KEY (`DocumentTypeID`) REFERENCES `DocumentTypes` (`ID`),
	CONSTRAINT `ProjectDocuments_CreatedByUserID` FOREIGN KEY (`CreatedByUserID`) REFERENCES `Users` (`ID`),
	CONSTRAINT `ProjectDocuments_UpdatedByUserID` FOREIGN KEY (`UpdatedByUserID`) REFERENCES `Users` (`ID`)
);

CREATE TABLE `dfc`.`ProjectReviews` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`ProjectID` int NOT NULL,
	`Remarks` VARCHAR(500) NOT NULL,
	`ReviewedByUserID` INT NULL,
	`ReviewDateTime` DATETIME NULL,
	`StatusID` INT NOT NULL,

	PRIMARY KEY (`ID`),
	UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
	CONSTRAINT `ProjectReviews_ProjectID` FOREIGN KEY (`ProjectID`) REFERENCES `Projects` (`ID`),
	CONSTRAINT `ProjectReviews_StatusID` FOREIGN KEY (`StatusID`) REFERENCES `StatusCodes` (`ID`),
	CONSTRAINT `ProjectReviews_ReviewedByUserID` FOREIGN KEY (`ReviewedByUserID`) REFERENCES `Users` (`ID`)
);








INSERT INTO `dfc`.`UserDetails` (`EMail`, `Mobile`) VALUES ('admin@df.com', '1234567890');

INSERT INTO `dfc`.`Passwords` (`PasswordHash`, `PasswordSalt`) VALUES ('RaSQ1sthyXMMsVB4w6KamTYx/MHnG7vcAOOaZvhWhUe9J1PymDjtaorD+0c3m6z9sGDWgh82rIgykE2c9G9uvg==', '2/9a6IxXi1BForaZSpc2kDfKEzXy2Em74noXFJhnlr41gfa4G4456oNMYZaPrhawtxTQkEydutMc9vo1CDxpRm5IgogrgDY/Hl8KnX4FsKRsmOqT1jmwVaPayJSBGMaPGfAGiltID8mEJdTCevxPAhJP5uinratp82O1XeDMmIo=');
  
INSERT INTO `dfc`.`Users` (`UserName`, `FirstName`, `LastName`, `Active`, `DetailID`, `PasswordID`) VALUES ('admin', 'Administrator', 'Admin', '1', 1, 1);
  
INSERT INTO `dfc`.`Countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('India', '1', '2018-09-18');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Sri Lanka', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Pakistan', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('USA', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('England', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Bangladesh', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Nepal', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Bhutan', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('China', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Myanmar', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Malaysia', '1', '2018-09-18 00:00:00');
INSERT INTO `dfc`.`countries` (`Name`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Singapore', '1', '2018-09-18 00:00:00');

INSERT INTO `dfc`.`states` (`Name`, `CountryID`) VALUES ('Tamil Nadu', '1');
INSERT INTO `dfc`.`states` (`Name`, `CountryID`) VALUES ('Kerala', '1');
INSERT INTO `dfc`.`states` (`Name`, `CountryID`) VALUES ('Karnataka', '1');
INSERT INTO `dfc`.`states` (`Name`, `CountryID`) VALUES ('Andra Pradesh', '1');
INSERT INTO `dfc`.`states` (`Name`, `CountryID`) VALUES ('Telangana', '1');
INSERT INTO `dfc`.`ScreenGroups` (`Name`, `Description`) VALUES ('MasterData', 'Manage Master Data');

INSERT INTO `dfc`.`screens` (`Name`, `Description`, `ScreenGroupID`) VALUES ('Projects', 'Project List/Details','1');
INSERT INTO `dfc`.`screens` (`Name`, `Description`, `ScreenGroupID`) VALUES ('Agents', 'Agent List/Details','1');

INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Save', 'Add New Record', '1', 'save');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Update', 'Edit Record', '1', 'update');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Delete', 'Delete single record', '1', 'delete');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Delete Selected', 'Delete multipe records', '1', 'deleteMultiple');

INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Save', 'Add New Record', '2', 'save');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Update', 'Edit Record', '2', 'update');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Delete', 'Delete single record', '2', 'delete');
INSERT INTO `dfc`.`screenelements` (`Name`, `Description`, `ScreenID`, `ControlID`) VALUES ('Delete Selected', 'Delete multipe records', '2', 'deleteMultiple');

INSERT INTO `dfc`.`roles` (`Name`, `Description`, `Active`) VALUES ('Administrator', 'Administrate the site', '1');

INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '1', '1', '1');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '1', '2', '1');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '1', '3', '0');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '1', '4', '0');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '2', '1', '1');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '2', '2', '1');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '2', '3', '1');
INSERT INTO `dfc`.`rolepermissions` (`RoleID`, `ScreenGroupID`, `ScreenID`, `ScreenElementID`, `Allowed`) VALUES ('1', '1', '2', '4', '1');


INSERT INTO `dfc`.`documenttypes` (`Name`) VALUES ('Parent Document');
INSERT INTO `dfc`.`documenttypes` (`Name`) VALUES ('Sale Deed');
INSERT INTO `dfc`.`documenttypes` (`Name`) VALUES ('Sale Agreement');
INSERT INTO `dfc`.`documenttypes` (`Name`) VALUES ('Legal Document');

INSERT INTO `dfc`.`units` (`Name`) VALUES ('Acre');
INSERT INTO `dfc`.`units` (`Name`) VALUES ('Square Feet');
INSERT INTO `dfc`.`units` (`Name`) VALUES ('Arpent');
INSERT INTO `dfc`.`units` (`Name`) VALUES ('Chain');
INSERT INTO `dfc`.`units` (`Name`) VALUES ('Hectare');

INSERT INTO `dfc`.`currencies` (`Name`) VALUES ('USD - US Dollar');
INSERT INTO `dfc`.`currencies` (`Name`) VALUES ('GBP - British Pound');
INSERT INTO `dfc`.`currencies` (`Name`) VALUES ('INR - Indian Rupee');
INSERT INTO `dfc`.`currencies` (`Name`) VALUES ('SGD - Singapore Dollar');
INSERT INTO `dfc`.`currencies` (`Name`) VALUES ('CNY - Chinese Yuan Renminbi');

INSERT INTO `dfc`.`statuscodes` (`Name`, `AssociatedEntity`) VALUES ('Draft', 'P');
INSERT INTO `dfc`.`statuscodes` (`Name`, `AssociatedEntity`) VALUES ('Submitted For Approval', 'P');
INSERT INTO `dfc`.`statuscodes` (`Name`, `AssociatedEntity`) VALUES ('Approved', 'P');
INSERT INTO `dfc`.`statuscodes` (`Name`, `AssociatedEntity`) VALUES ('Rejected', 'P');

INSERT INTO `dfc`.`projectcontents` (`Content`) VALUES ('Test Project 1 Content');
INSERT INTO `dfc`.`projectcontents` (`Content`) VALUES ('Test Project 2 Content');

INSERT INTO `dfc`.`projecttradelimits` (`BuyLimitMin`, `SellLimitMin`, `BuyLimitMax`, `SellLimitMax`) VALUES ('10', '10', '50', '50');
INSERT INTO `dfc`.`projecttradelimits` (`BuyLimitMin`, `SellLimitMin`, `BuyLimitMax`, `SellLimitMax`) VALUES ('10', '10', '50', '50');

INSERT INTO `dfc`.`projects` (`Name`, `ShortDescription`, `StartDate`, `EndDate`, `TotalArea`, `NoofUnits`, `BasePrice`, `StatusID`, `UnitID`, `CurrencyID`, `TradeLimitID`, `ContentID`, `Active`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Project 1', 'Some description about the project', '2018-01-01', '2020-01-01', '100', '50000', '0.10', '1', '1', '1', '1', '1', '1', '1', '2018-01-01');

INSERT INTO `dfc`.`projects` (`Name`, `ShortDescription`, `StartDate`, `EndDate`, `TotalArea`, `NoofUnits`, `BasePrice`, `StatusID`, `UnitID`, `CurrencyID`, `TradeLimitID`, `ContentID`, `Active`, `CreatedByUserID`, `CreatedDateTime`) VALUES ('Project 2', 'Some description about the project', '2018-01-01', '2020-01-01', '50', '60000', '0.20', '1', '2', '2', '2', '2', '1', '1', '2018-01-01');


INSERT INTO `dfc`.`projectdocuments` (`Name`, `ProjectID`, `DocumentTypeID`, `Description`, `Remarks`, `Location`, `IsAgentVisible`, `IsVendorVisible`, `IsCustomerVisible`, `IsPrivateVisible`) VALUES ('Document 1', '1', '1', 'Desc', 'Rem', '\\Docs\\Project1\\Doc1.pdf', '1', '1', '1', '1');

INSERT INTO `dfc`.`projectdocuments` (`Name`, `ProjectID`, `DocumentTypeID`, `Description`, `Remarks`, `Location`, `IsAgentVisible`, `IsVendorVisible`, `IsCustomerVisible`, `IsPrivateVisible`) VALUES ('Document 2', '1', '2', 'Desc', 'Rem', '\\Docs\\Project1\\Doc2.pdf', '1', '1', '1', '1');

INSERT INTO `dfc`.`projectreviews` (`ProjectID`, `Remarks`, `ReviewedByUserID`, `ReviewDateTime`, `StatusID`) VALUES ('1', 'Incomplete content details', '1', '2018-01-02', '2');
