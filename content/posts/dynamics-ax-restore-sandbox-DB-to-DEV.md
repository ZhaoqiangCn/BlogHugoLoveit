---
title: "如何把Dynamics 365 FO UAT的数据库还原到开发环境"
subtitle: ""
date: 2023-07-05T21:18:03+08:00
lastmod: 2023-07-05T21:18:03+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: "如何把Dynamics 365 FO UAT的数据库还原到开发环境How to restore sandbox DB to DEV"

tags: ["Dynamics365"]
categories: ["Dynamicsax"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

<!--more-->
Here is the procedure to restore Sandbox DB to DEV.

1. LCS -> UAT -> Maintain -> Move Database -> Export database
2. The bacpac file will be exported to Asset Library
3. Download the database from LCS Asset Library in your target machine
4. Download SqlPackage and using this version sqlpackage-win7-x64-en-16.0.6161.0.zip
5. run the script in cmd
```
SqlPackage.exe /a:import /sf:D:\Exportedbacpac\my.bacpac /tsn:localhost /tdn:<target database name> /p:CommandTimeout=1200
 
Example
Demo
1.	SqlPackage.exe /a:import /sf:J:\MSSQL_BACKUP\Demo_PreProdbackup.bacpac /tsn:localhost /tdn:PreProd_20220712 /p:CommandTimeout=1200
 
Demo
2.	SqlPackage.exe /a:import /sf:J:\MSSQL_BACKUP\Demo_uatbackup.bacpac /tsn:localhost /tdn:uat_20221028 /p:CommandTimeout=1200
```
6. Waiting
7. Run below script after restore the database, change the database name in below line:
```
ALTER DATABASE [uatbackup_20190401.bacpac] SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 6 DAYS, AUTO_CLEANUP = ON)

--
CREATE USER axdeployuser FROM LOGIN axdeployuser
EXEC sp_addrolemember 'db_owner', 'axdeployuser'
 
CREATE USER axdbadmin FROM LOGIN axdbadmin
EXEC sp_addrolemember 'db_owner', 'axdbadmin'
 
CREATE USER axmrruntimeuser FROM LOGIN axmrruntimeuser
EXEC sp_addrolemember 'db_datareader', 'axmrruntimeuser'
EXEC sp_addrolemember 'db_datawriter', 'axmrruntimeuser'
 
CREATE USER axretaildatasyncuser FROM LOGIN axretaildatasyncuser
EXEC sp_addrolemember 'DataSyncUsersRole', 'axretaildatasyncuser'
 
CREATE USER axretailruntimeuser FROM LOGIN axretailruntimeuser
EXEC sp_addrolemember 'UsersRole', 'axretailruntimeuser'
EXEC sp_addrolemember 'ReportUsersRole', 'axretailruntimeuser'
 
CREATE USER axdeployextuser FROM LOGIN axdeployextuser
EXEC sp_addrolemember 'DeployExtensibilityRole', 'axdeployextuser'
 
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FROM LOGIN [NT AUTHORITY\NETWORK SERVICE]
EXEC sp_addrolemember 'db_owner', 'NT AUTHORITY\NETWORK SERVICE'
 
 
UPDATE T1
SET T1.storageproviderid = 0
, T1.accessinformation =''
, T1.modifiedby = 'Admin'
, T1.modifieddatetime = getdate()
FROM docuvalue T1
WHERE T1.storageproviderid = 1 --Azure storage
 
ALTER DATABASE [uatbackup_20190401.bacpac] SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 6 DAYS, AUTO_CLEANUP = ON)
GO
DROP PROCEDURE IF EXISTS SP_ConfigureTablesForChangeTracking
DROP PROCEDURE IF EXISTS SP_ConfigureTablesForChangeTracking_V2
GO
 
-- Begin Refresh Retail FullText Catalogs
DECLARE @RFTXNAME NVARCHAR(MAX);
DECLARE @RFTXSQL NVARCHAR(MAX);
DECLARE retail_ftx CURSOR FOR
SELECT OBJECT_SCHEMA_NAME(object_id) + '.' + OBJECT_NAME(object_id) fullname FROM SYS.FULLTEXT_INDEXES
WHERE FULLTEXT_CATALOG_ID = (SELECT TOP 1 FULLTEXT_CATALOG_ID FROM SYS.FULLTEXT_CATALOGS WHERE NAME = 'COMMERCEFULLTEXTCATALOG');
OPEN retail_ftx;
FETCH NEXT FROM retail_ftx INTO @RFTXNAME;
 
BEGIN TRY
WHILE @@FETCH_STATUS = 0
BEGIN
PRINT 'Refreshing Full Text Index ' + @RFTXNAME;
EXEC SP_FULLTEXT_TABLE @RFTXNAME, 'activate';
SET @RFTXSQL = 'ALTER FULLTEXT INDEX ON ' + @RFTXNAME + ' START FULL POPULATION';
EXEC SP_EXECUTESQL @RFTXSQL;
FETCH NEXT FROM retail_ftx INTO @RFTXNAME;
END
END TRY
BEGIN CATCH
PRINT error_message()
END CATCH
 
CLOSE retail_ftx;
DEALLOCATE retail_ftx;
-- End Refresh Retail FullText Catalogs
==
```
8. Stop all D365 related service.
9. Rename AXDB to AXDB_OldYYYYMMDD
10. Rename restored database to AXDB
11. Open Visual Studio and run database synchronization.
12. Start all D365 related service.
