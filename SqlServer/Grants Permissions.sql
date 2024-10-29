use TinderDB;
GO


CREATE USER user_compartido
FOR LOGIN user_compartido;
GO

-- Otorgar permisos de lectura y escritura según lo que se necesite
USE [TinderDB];
ALTER ROLE [db_datareader] ADD MEMBER [user_compartido];
ALTER ROLE [db_datawriter] ADD MEMBER [user_compartido];

ALTER LOGIN [user_compartido] WITH DEFAULT_DATABASE = [TinderDB];
