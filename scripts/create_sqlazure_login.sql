IF (NOT EXISTS(SELECT TOP 1 1 FROM sys.sql_logins WHERE [name] = '$(SqlUserName)'))
BEGIN
    CREATE LOGIN $(SqlUserName) WITH password='$(SqlUserPassword)';
END
