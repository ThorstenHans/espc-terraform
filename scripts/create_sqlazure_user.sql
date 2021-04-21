IF (NOT EXISTS ( SELECT [name] FROM sys.database_principals WHERE [name] = '$(SqlUserName)' ))
BEGIN
    CREATE USER $(SqlUserName) FROM LOGIN $(SqlUserName);
    EXEC sp_addrolemember 'db_owner', '$(SqlUserName)';
END
