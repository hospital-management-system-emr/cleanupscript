


---Insert admin employeee
	INSERT INTO EMP_Employee (FirstName, LastName, DateOfJoining, CreatedBy,CreatedOn, IsActive,FullName,IsExternal)

    SELECT 'admin' AS FirstName, 'admin' AS LastName, GETDATE() AS DateOfJoining, 1 AS CreatedBy, GETDATE() AS CreatedOn, 
    1 AS IsActive, 'admin admin' AS FullName, 0 AS IsExternal
    GO


	---Insert administrator departement
INSERT INTO MST_Department(
    DepartmentCode, DepartmentName, Description, DepartmentHead, 
    IsActive, IsAppointmentApplicable, CreatedBy, ModifiedBy, CreatedOn, 
    ModifiedOn, ParentDepartmentId, RoomNumber, NoticeText, 
    OpdNewPatientServiceItemId, OpdOldPatientServiceItemId, FollowupServiceItemId
) 
Select * from (
SELECT 'ADM' AS DepartmentCode, 'Administration' AS DepartmentName, 'Administration Department' AS Description, NULL AS DepartmentHead, 1 AS IsActive,
1 AS IsAppointmentApplicable, 1 AS CreatedBy, 1 AS ModifiedBy, GETDATE() AS CreatedOn, GETDATE() AS ModifiedOn, NULL AS ParentDepartmentId,
'101' AS RoomNumber, null AS NoticeText, NULL AS OpdNewPatientServiceItemId, NULL AS OpdOldPatientServiceItemId, NULL AS FollowupServiceItemId
UNION ALL 
SELECT 'PTHO' AS DepartmentCode, 'Pathology' AS DepartmentName, 'Pathology Department' AS Description, NULL AS DepartmentHead, 1 AS IsActive,
1 AS IsAppointmentApplicable, 1 AS CreatedBy, 1 AS ModifiedBy, GETDATE() AS CreatedOn, GETDATE() AS ModifiedOn, NULL AS ParentDepartmentId,
'102' AS RoomNumber, null AS NoticeText, NULL AS OpdNewPatientServiceItemId, NULL AS OpdOldPatientServiceItemId, NULL AS FollowupServiceItemId
UNION ALL 
SELECT 'RAD' AS DepartmentCode, 'Radiology' AS DepartmentName, 'Radiology Department' AS Description, NULL AS DepartmentHead, 1 AS IsActive,
1 AS IsAppointmentApplicable, 1 AS CreatedBy, 1 AS ModifiedBy, GETDATE() AS CreatedOn, GETDATE() AS ModifiedOn, NULL AS ParentDepartmentId,
'103' AS RoomNumber, null AS NoticeText, NULL AS OpdNewPatientServiceItemId, NULL AS OpdOldPatientServiceItemId, NULL AS FollowupServiceItemId
UNION ALL 
SELECT 'OPD' AS DepartmentCode, 'OPD' AS DepartmentName, 'OPD Department' AS Description, NULL AS DepartmentHead, 1 AS IsActive,
1 AS IsAppointmentApplicable, 1 AS CreatedBy, 1 AS ModifiedBy, GETDATE() AS CreatedOn, GETDATE() AS ModifiedOn, NULL AS ParentDepartmentId,
'104' AS RoomNumber, null AS NoticeText, NULL AS OpdNewPatientServiceItemId, NULL AS OpdOldPatientServiceItemId, NULL AS FollowupServiceItemId
UNION ALL 
SELECT 'IP' AS DepartmentCode, 'InPatientBedCharge' AS DepartmentName, 'InPatientBedCharge Department' AS Description, NULL AS DepartmentHead, 1 AS IsActive,
1 AS IsAppointmentApplicable, 1 AS CreatedBy, 1 AS ModifiedBy, GETDATE() AS CreatedOn, GETDATE() AS ModifiedOn, NULL AS ParentDepartmentId,
'105' AS RoomNumber, null AS NoticeText, NULL AS OpdNewPatientServiceItemId, NULL AS OpdOldPatientServiceItemId, NULL AS FollowupServiceItemId
) dept
where dept.DepartmentName not in (Select DepartmentName from MST_Department ) 
GO

Declare @pathsrvId int = (Select DepartmentId from MST_Department where DepartmentName='Pathology')
Declare @RadsrvId int = (Select DepartmentId from MST_Department where DepartmentName='Radiology')
Declare @bedsrvId int = (Select DepartmentId from MST_Department where DepartmentName='InPatientBedCharge')

INSERT INTO BIL_MST_ServiceDepartment(
 ServiceDepartmentName
,ServiceDepartmentShortName
,DepartmentId
,CreatedBy
,CreatedOn
,ModifiedOn
,ModifiedBy
,UpdatedBy
,UpdatedOn
,IsActive
,IntegrationName
,ParentServiceDepartmentId
)
Select * from (
Select 
'ENDOCRINOLOGY' as ServiceDepartmentName
,'END' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'HISTOLOGY/CYTOLOGY' as ServiceDepartmentName
,'HISTO' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'IMMUNOLOGY' as ServiceDepartmentName
,'IMMU' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'MICROBIOLOGY' as ServiceDepartmentName
,'MICRO' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'Molecular Biology' as ServiceDepartmentName
,'MOLE' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'PARASITOLOGY' as ServiceDepartmentName
,'PAR' as ServiceDepartmentShortName
,@pathsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'LAB' as IntegrationName
,null as ParentServiceDepartmentId

----inserting Radiology 
UNION ALL
SELECT 
'CT-Sacan' as ServiceDepartmentName
,'CT' as ServiceDepartmentShortName
,@RadsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'RADIOLOGY' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'USG' as ServiceDepartmentName
,'usg' as ServiceDepartmentShortName
,@RadsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'RADIOLOGY' as IntegrationName
,null as ParentServiceDepartmentId
UNION ALL
SELECT 
'X-ray' as ServiceDepartmentName
,'xray' as ServiceDepartmentShortName
,@RadsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'RADIOLOGY' as IntegrationName
,null as ParentServiceDepartmentId
--inset Bed charge  
UNION ALL
SELECT 
'Bed Charge' as ServiceDepartmentName
,'Bed' as ServiceDepartmentShortName
,@bedsrvId as DepartmentId
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedOn
,null as ModifiedBy
,null as UpdatedBy
,null as UpdatedOn
,1 as IsActive
,'Bed Charges' as IntegrationName
,null as ParentServiceDepartmentId
) drv 
where ServiceDepartmentName not in (select ServiceDepartmentName from BIL_MST_ServiceDepartment)

-----Insert admin user
	INSERT INTO RBAC_User (
 EmployeeId
,UserName
,Password
,Email
,NeedsPasswordUpdate
,CreatedBy
,CreatedOn
,IsActive
,LandingPageRouteId)
Select  1 as EmployeeId
,'admin' as UserName
,'28A7hi0jvH0=' as Password --- password : pass123
,'admin'+'@'+'danpheHealth.com' as Email
,0 as NeedsPasswordUpdate
,1 as CreatedBy
,GETDATE() as CreatedOn
,1 as IsActive
,0 as LandingPageRouteId
GO


---Insert Doctor role
insert into EMP_EmployeeRole(
 EmployeeRoleName
,CreatedBy
,CreatedOn
,IsActive
)
Select  'FullTime' as EmployeeTypeName,1 as CreatedBy,GETDATE() as CreatedOn,1 as IsActive
UNION ALL 
Select  'PartTime' as EmployeeTypeName,1 as CreatedBy,GETDATE() as CreatedOn,1 as IsActive
GO


---Insert admin employeeType
insert into EMP_EmployeeType (
 EmployeeTypeName
,CreatedBy
,CreatedOn
,IsActive)
Select  'Doctor' as EmployeeTypeName,1 as CreatedBy,GETDATE() as CreatedOn,1 as IsActive
GO
---Insert Anonymous employeee
SET IDENTITY_INSERT EMP_Employee ON
IF NOT EXISTS (select fullname  from EMP_Employee where fullname ='Dr. PHRM Anonymous Doctor' )
begin
INSERT INTO EMP_Employee (
	EmployeeId,FirstName,MiddleName,LastName,Salutation,Gender,ContactNumber,DepartmentId,DateOfBirth,DateOfJoining,Email,
	EmployeeRoleId,EmployeeTypeId,LongSignature,MedCertificationNo,CreatedBy,CreatedOn,IsActive,IsAppointmentApplicable,
	DisplaySequence,FullName,IsExternal,IsIncentiveApplicable
	)
SELECT
	-1 AS 'EmployeeId','PHRM' AS 'FirstName', 'Anonymous' AS 'MiddleName','Doctor' AS 'LastName','Dr' AS  'Salutation','Male' AS 'Gender',000000  AS 'ContactNumber',1 AS 'DepartmentId','2001-01-01 00:00:00.000' AS 'DateOfBirth',GetDate() AS 'DateOfJoining','phrmanonymousdoc@danphe.com' AS 'Email',
	1 AS 'EmployeeRoleId',1 AS 'EmployeeTypeId','Dr. PHRM Anonymous Doctor' AS  'LongSignature',1234 AS 'MedCertificationNo',1 AS 'CreatedBy',GetDate() AS 'CreatedOn',1 AS 'IsActive',0 AS 'IsAppointmentApplicable',
	100 AS 'DisplaySequence','Dr. PHRM Anonymous Doctor' AS 'FullName',0 AS 'IsExternal',0 AS 'IsIncentiveApplicable'
	END
SET IDENTITY_INSERT EMP_Employee OFF
GO
---Insert super admin role map
INSERT INTO RBAC_MAP_UserRole(
 UserId
,RoleId
,CreatedBy
,CreatedOn
,IsActive)
Select 1 as  UserId
,1 as RoleId
,1 as CreatedBy
,getdate() as CreatedOn
,1 as IsActive
GO


--insert data into BIL_MST_ServiceCategory
INSERT INTO BIL_MST_ServiceCategory
(
	 ServiceCategoryCode
	,ServiceCategoryName
	,Description
	,CreatedBy
	,CreatedOn
	,IsActive
)
VALUES
 ('SERVCH','Service Charges',	'Service Charges Grouping', 1, GETDATE(), 1)
,('INVSTCH'	,'Investigation Charges',	'Investigation Charges Grouping', 1, GETDATE(), 1)
,('PROCEDCH','Procedure Charges',	'Procedure Charges Grouping', 1, GETDATE(), 1)
,('BEDCH'	,'Bed Charges',	'Bed Charges Grouping', 1, GETDATE(), 1)
,('OPERNCH'	,'Operation Charges',	'Operation Charges Grouping', 1, GETDATE(), 1)
,('CONSUMCH','Consumable Charges',	'Consumable Charges Grouping', 1, GETDATE(), 1)
,('AMBLNCH'	,'Ambulance Charges',	'Ambulance Charges Grouping', 1, GETDATE(), 1)
,('PACKGCH'	,'Package Charges',	'Package Charges Grouping', 1, GETDATE(), 1)
,('BLBNKCH'	,'Blood Bank Charges',	'Blood Bank Charges Grouping', 1, GETDATE(), 1)
,('PHRMCH'	,'Pharmacy Charges','Pharmacy Charges Grouping', 1, GETDATE(), 1)
,('CONSLTCH','Consultation Charges','Consultation Charges Grouping', 1, GETDATE(), 1)
GO

--Insert PHRM ANONYMOUS patient
SET IDENTITY_INSERT PAT_Patient ON
INSERT INTO PAT_Patient (
PatientId
,PatientCode
,PatientNo
,Salutation
,FirstName
,MiddleName
,LastName
,Gender
,Age
,DateOfBirth
,PhoneNumber
,Address
,PANNumber
,CountrySubDivisionId
,CountryId
,BloodGroup
,MaritalStatus
,Email
,EMPI
,PhoneAcceptsText
,IDCardNumber
,IDCardType
,Race
,EthnicGroup
,Occupation
,PreviousLastName
,EmployerInfo
,IsDobVerified
,MembershipTypeId
,IsOutdoorPat
,CreatedOn
,CreatedBy
,ModifiedBy
,ModifiedOn
,IsActive
,PatientNameLocal
,DialysisCode
,LandLineNumber
,PassportNumber
,ShortName
,Ins_HasInsurance
,Ins_NshiNumber
,Ins_InsuranceBalance
,IsSSUPatient
,FatherName
,MotherName
,SSU_IsActive
,Ins_LatestClaimCode
,IsVaccinationPatient
,IsVaccinationActive
,VaccinationRegNo
,VaccinationFiscalYearId
,MunicipalityId
,Telmed_Patient_GUID
,Posting
,Rank
,DependentId
,IsFlagged
,FlagDescription
,WardNumber
)
select 
-1 as PatientId
,'1806000001' as PatientCode
,0 as PatientNo
,'Mr/Ms' as Salutation
,'PHRM' as FirstName
,null as MiddleName
,'ANONYMOUS' as LastName
,'Others' as Gender
,'0Y' as Age
,'2018-06-13 14:04:00.000' as DateOfBirth
,'N/A' as PhoneNumber
,'N/A' as Address
,null as PANNumber
,76 as CountrySubDivisionId
,1 as CountryId
,null as BloodGroup
,null as MaritalStatus
,null as Email
,'DPH-1' as EMPI
,0 as PhoneAcceptsText
,null as IDCardNumber
,null as IDCardType
,null as Race
,null as EthnicGroup
,null as Occupation
,null as PreviousLastName
,null as EmployerInfo
,0 as IsDobVerified
,null as MembershipTypeId
,1 as IsOutdoorPat
,'2020-01-19 11:52:14.667' as CreatedOn
,1 as CreatedBy
,null as ModifiedBy
,null as ModifiedOn
,0 as IsActive
,NULL AS PatientNameLocal
,NULL AS DialysisCode
,NULL AS LandLineNumber
,NULL AS PassportNumber
,'PHRM  ANONYMOUS' as ShortName
,0 as Ins_HasInsurance
,null as Ins_NshiNumber
,0 as Ins_InsuranceBalance
,0 as IsSSUPatient
,null as FatherName
,null as MotherName
,0 as SSU_IsActive
,null as Ins_LatestClaimCode
,0 as IsVaccinationPatient
,0 as IsVaccinationActive
,null as VaccinationRegNo
,null as VaccinationFiscalYearId
,null as MunicipalityId
,null as Telmed_Patient_GUID
,null as Posting
,null as Rank
,null as DependentId
,0 as IsFlagged
,null as FlagDescription
,null as WardNumber


SET IDENTITY_INSERT PAT_Patient OFF
GO

--Insert default PriceCAtegory
insert into BIL_CFG_PriceCategory(
 PriceCategoryName
,Description
,IsDefault
,CreatedOn
,CreatedBy
,IsActive
,IsPharmacyRateDifferent
,PriceCategoryCode
,ShowInRegistration
,ShowInAdmission)

Select 
 'Normal' as PriceCategoryName
,null as Description
,1 as IsDefault
,GETDATE() as CreatedOn
,1 as CreatedBy
,1 as IsActive
,0 as IsPharmacyRateDifferent
,'NRM' as PriceCategoryCode
,1 as ShowInRegistration
,1 as ShowInAdmission
GO 

--insert default scheme
INSERT INTO BIL_CFG_Scheme(
     SchemeCode, SchemeName, Description, CommunityName, ValidFromDate, ValidToDate, 
    IsMembershipApplicable, IsMemberNumberCompulsory, DefaultPaymentMode, IsCreditApplicable, 
    IsCreditOnlyScheme, IsOpCreditLimited, IsIpCreditLimited, IsGeneralCreditLimited, 
    GeneralCreditLimit, OpCreditLimit, IpCreditLimit, IsRegistrationCreditApplicable, 
    IsOpBillCreditApplicable, IsIpBillCreditApplicable, IsAdmissionCreditApplicable, 
    IsOpPhrmCreditApplicable, IsIpPhrmCreditApplicable, IsVisitCompulsoryInBilling, 
    IsVisitCompulsoryInPharmacy, IsBillingCoPayment, IsPharmacyCoPayment, BillCoPayCashPercent, 
    BillCoPayCreditPercent, PharmacyCoPayCashPercent, PharmacyCoPayCreditPercent, 
    IsDiscountApplicable, DiscountPercent, IsDiscountEditable, IsRegDiscountApplicable, 
    RegDiscountPercent, IsRegDiscountEditable, IsOpBillDiscountApplicable, OpBillDiscountPercent, 
    IsOpBillDiscountEditable, IsIpBillDiscountApplicable, IpBillDiscountPercent, 
    IsIpBillDiscountEditable, IsAdmissionDiscountApplicable, AdmissionDiscountPercent, 
    IsAdmissionDiscountEditable, IsOpPhrmDiscountApplicable, OpPhrmDiscountPercent, 
    IsOpPhrmDiscountEditable, IsIpPhrmDiscountApplicable, IpPhrmDiscountPercent, 
    IsIpPhrmDiscountEditable, DefaultCreditOrganizationId, CreatedBy, CreatedOn, ModifiedBy, 
    ModifiedOn, IsActive, ApiIntegrationName, FieldSettingParamName, DefaultPriceCategoryId, 
    IsSystemDefault, RegStickerGroupCode, HasSubScheme, AllowProvisionalBilling, 
    IsPharmacyCappingApplicable, IsBillingCappingApplicable, IsPharmacySalePriceEditable, 
    UseCappingAPI
)
select 
    'GEN' as  SchemeCode 
    ,'GENRAL' as  SchemeName 
    ,'A scheme for general services' as  Description 
    ,'GENERAL' as  CommunityName 
    ,null as  ValidFromDate 
    ,null  as  ValidToDate 
    ,0 as  IsMembershipApplicable 
    ,0 as  IsMemberNumberCompulsory 
    ,'Cash' as  DefaultPaymentMode 
    ,0 as  IsCreditApplicable 
    ,0 as  IsCreditOnlyScheme 
    ,0 as  IsOpCreditLimited 
    ,0 as  IsIpCreditLimited 
    ,0 as  IsGeneralCreditLimited 
    ,0 as  GeneralCreditLimit 
    ,0 as  OpCreditLimit 
    ,0 as  IpCreditLimit 
    ,0 as  IsRegistrationCreditApplicable 
    ,0 as  IsOpBillCreditApplicable 
    ,0 as  IsIpBillCreditApplicable 
    ,0 as  IsAdmissionCreditApplicable 
    ,0 as  IsOpPhrmCreditApplicable 
    ,0 as  IsIpPhrmCreditApplicable 
    ,0 as  IsVisitCompulsoryInBilling 
    ,0 as  IsVisitCompulsoryInPharmacy 
    ,0 as  IsBillingCoPayment 
    ,0 as  IsPharmacyCoPayment 
    ,0 as  BillCoPayCashPercent 
    ,0 as  BillCoPayCreditPercent 
    ,0 as  PharmacyCoPayCashPercent 
    ,0 as  PharmacyCoPayCreditPercent 
    ,1 as  IsDiscountApplicable 
    ,0 as  DiscountPercent 
    ,1 as  IsDiscountEditable 
    ,1 as  IsRegDiscountApplicable 
    ,0 as  RegDiscountPercent 
    ,1 as  IsRegDiscountEditable 
    ,1 as  IsOpBillDiscountApplicable 
    ,0 as  OpBillDiscountPercent 
    ,1 as  IsOpBillDiscountEditable 
    ,1 as  IsIpBillDiscountApplicable 
    ,0 as  IpBillDiscountPercent 
    ,1 as  IsIpBillDiscountEditable 
    ,1 as  IsAdmissionDiscountApplicable 
    ,0 as  AdmissionDiscountPercent 
    ,1 as  IsAdmissionDiscountEditable 
    ,1 as  IsOpPhrmDiscountApplicable 
    ,0 as  OpPhrmDiscountPercent 
    ,1 as  IsOpPhrmDiscountEditable 
    ,1 as  IsIpPhrmDiscountApplicable 
    ,0 as  IpPhrmDiscountPercent 
    ,1 as  IsIpPhrmDiscountEditable 
    ,null as  DefaultCreditOrganizationId 
    ,1 as  CreatedBy 
    ,GETDATE() as  CreatedOn 
    ,NULL as  ModifiedBy 
    ,NULL as  ModifiedOn 
    ,1 as  IsActive 
    ,' ' as  ApiIntegrationName 
    ,' ' as FieldSettingParamName 
    ,1 as  DefaultPriceCategoryId 
    ,1 as  IsSystemDefault 
    ,'General' as RegStickerGroupCode 
    ,0 as  HasSubScheme 
    ,1 as  AllowProvisionalBilling 
    ,1 as IsPharmacyCappingApplicable 
    ,1 as IsBillingCappingApplicable 
    ,1 as  IsPharmacySalePriceEditable
    ,0 as  UseCappingAPI 
	GO

	----Insert Default Credit organization and default vendor
INSERT INTO BIL_MST_Credit_Organization(
 OrganizationName
,IsActive
,CreatedOn
,CreatedBy
,ModifiedOn
,ModifiedBy
,IsDefault
,IsClaimManagementApplicable
,IsClaimCodeCompulsory
,IsClaimCodeAutoGenerate
,DisplayName
,CreditOrganizationCode
)
Select 
 'Default' as OrganizationName
,1 as IsActive
,GETDATE() as CreatedOn
,1 as CreatedBy
,NULL AS ModifiedOn
,NULL AS ModifiedBy
,1 AS IsDefault
,0 AS IsClaimManagementApplicable
,0 AS IsClaimCodeCompulsory
,0 AS IsClaimCodeAutoGenerate
,1 AS DisplayName
,'Def' AS CreditOrganizationCode
GO 

INSERT INTO Lab_MST_LabVendors(
 VendorCode
,VendorName
,IsExternal
,ContactAddress
,ContactNo
,Email
,Remarks
,CreatedBy
,CreatedOn
,IsActive
,IsDefault
)
Select 
 '001' as VendorCode
,'Default' as VendorName
,1 as IsExternal
,'Default' as ContactAddress
,000 as ContactNo
,'Default@gmail.com' as Email
,'Default' as Remarks
,1 as CreatedBy
,GETDATE() as CreatedOn
,1 as IsActive
,1 as IsDefault
GO 


INSERT INTO BIL_MAP_PriceCategoryVsScheme(
 SchemeId
,PriceCategoryId
,IsDefault
,IsActive
,CreatedBy
,CreatedOn
,ModifiedBy
,ModifiedOn
)
Select
SchemeId 
 SchemeId
,PriceCategoryId
,scheme.IsSystemDefault 'IsDefault'
,1 as IsActive
,1 as CreatedBy
,GETDATE() as CreatedOn
,null as ModifiedBy
,null as ModifiedOn
from BIL_CFG_Scheme scheme 
cross join BIL_CFG_PriceCategory price 
GO 





-----Section Start: Naming Correction of Existing Primary Keys with invalid names---
--/*
--* Dynamic Query to Rename Invalid Primary Key Constraint in All Tables----
--* Created: 23Apr'23: Krishna/Sud
--* Expected Name format for PrimaryKey: PK_{TableName}
--* Logic used:
--     1. Insert invalid PrimaryKeys into a Temp table
--	     --Table autogenerated by EntityFramework are excluded 
--	 2. 'While Loop' thorugh these and Rename them one by one
--	 3. Print summarized error message at the end if there was any issue during execution
--*/

--IF OBJECT_ID('tempDB..#tmpTbl_PKsToUpdate', 'U') IS NOT NULL
--DROP TABLE #tmpTbl_PKsToUpdate
--GO
--select tbl.object_id 'Table_ObjectId', tbl.name 'TableName', indx.name 'PK_CurrentName', 'PK_'+tbl.name 'RequiredPkName'
--INTO #tmpTbl_PKsToUpdate 
--from sys.indexes indx inner join sys.tables tbl on indx.object_id=tbl.object_id
--where is_primary_key=1
--  and indx.name != 'PK_'+tbl.name
-----exclude inbuilt tables generated by Entity Framework---
--AND tbl.name NOT IN ( '__MigrationHistory','BedInformationModels','EmployeeInfoModels','WardInformationModels')
--order by tbl.name

--Declare @CurrentObjId INT, @CurrTblName varchar(200), @CurrentPKName Varchar(200), @NewPkName Varchar(200)
--Declare @ErrorMsgStr varchar(8000)='ERRORS:-----', @CurrentUpdateQuery varchar(1000)

--WHILE((Select count(*) from #tmpTbl_PKsToUpdate)>0)
--BEGIN
    
--	 SELECT  @CurrentObjId=Table_ObjectId, @CurrTblName = TableName, @CurrentPKName=PK_CurrentName, @NewPkName=RequiredPkName
--	 from #tmpTbl_PKsToUpdate

--	 	 --Create Dynamic Query for Renaming---
--	 SET @CurrentUpdateQuery= 'EXEC sp_rename '+ @CurrentPKName + ','+ @NewPkName
--	 IF(@CurrentUpdateQuery IS NOT NULL)
--	 BEGIN
--		 BEGIN TRY	
--			 --this will rename current name with new name----
--			 EXEC(@CurrentUpdateQuery) -- Comment This LINE until you've Reviewed the Ouptput Query---
--			 PRINT(@CurrentUpdateQuery+' --Success')
--		 END TRY
--		 BEGIN CATCH
--			SET @ErrorMsgStr = @ErrorMsgStr + ERROR_MESSAGE()+'---'+CHAR(13)
--		 END CATCH

--	 END -- END if
--	 ---Need to delete Current Table from the List, else it will go into Infinite Loop---
--	 delete from #tmpTbl_PKsToUpdate
--	 WHERE Table_ObjectId=@CurrentObjId
--END

--print(@ErrorMsgStr)
--GO


-----Section End: Naming Correction of Existing Primary Keys with invalid names---




-----Section Start: Naming Correction of Existing Default Constraints with invalid names---

--/*
--* Dynamic Query to Rename invalid Default Constraint in All Tables----
--* Created: 23Apr'23: Krishna/Sud
--* Expected Name format for DefaultKey: DF_{TableName}_{ColumnName}
--* Logic used:
--     1. Insert invalid Default into a Temp table
--	 2. 'While Loop' through these and Rename them one by one
--	 3. Print summarized error message at the end if there was any issue during execution---
--*/
-----List out all Invalid Names into a Temporary Table---
--SELECT 
--    tbl.object_id 'Table_ObjectId',
--    tbl.name AS TableName, 
--    col.name AS ColumnName, 
--    df.name AS Df_CurrentName,
--	'DF_'+tbl.name+'_'+col.name AS 'Df_RequiredName'
--INTO #tmpTbl_DefConstraintsToUpdate
--FROM sys.default_constraints df
--INNER JOIN sys.columns col ON
--    df.parent_object_id = col.object_id
--    AND df.parent_column_id = col.column_id
--INNER JOIN sys.tables tbl ON
--    tbl.object_id = col.object_id
--WHERE df.name != 'DF_'+tbl.name+'_'+col.name


--Declare @CurrentTblObjId INT, @CurrTblName varchar(200), @CurrentColName Varchar(200),
--@CurrentDfConstName Varchar(200), @NewDfConstName Varchar(200)
--Declare @ErrorMsgStr varchar(8000)='ERRORS:-----', @CurrentUpdateQuery Varchar(1000)

--WHILE((Select count(*) from #tmpTbl_DefConstraintsToUpdate)>0)
--BEGIN
    
--	 SELECT  @CurrentTblObjId=Table_ObjectId, @CurrTblName = TableName, 
--	 @CurrentColName = ColumnName,
--	 @CurrentDfConstName= Df_CurrentName, @NewDfConstName= Df_RequiredName
--	 from #tmpTbl_DefConstraintsToUpdate

--	 --Create Dynamic Query for Renaming---
--	 SET @CurrentUpdateQuery= 'EXEC sp_rename '+ @CurrentDfConstName+ ','+ @NewDfConstName
--	 IF(@CurrentUpdateQuery IS NOT NULL)
--	 BEGIN

--		 BEGIN TRY	
--			 --this will rename current name with new name----
--			 EXEC(@CurrentUpdateQuery)
--			 PRINT(@CurrentUpdateQuery+' --Success')
--		 END TRY
--		 BEGIN CATCH
--			SET @ErrorMsgStr = @ErrorMsgStr + ERROR_MESSAGE()+'---'+CHAR(13)
--		 END CATCH

--	 END -- end IF

--	 ---Need to delete Current Table+Column from the List, else it will go into Infinite Loop---
--	 delete from #tmpTbl_DefConstraintsToUpdate
--	 WHERE Table_ObjectId=@CurrentTblObjId and ColumnName=@CurrentColName

	 
--END

--print(@ErrorMsgStr)

--IF OBJECT_ID('tempDB..#tmpTbl_DefConstraintsToUpdate', 'U') IS NOT NULL
-- DROP TABLE #tmpTbl_DefConstraintsToUpdate
--GO
-----Section End: Naming Correction of Existing Default Constraints with invalid names---

------End:Sud:23Apr'23---(Dynamic Query) Naming correction of PK and Default Constraints--

