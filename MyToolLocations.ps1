@{SQLCmdAlias = "$($env:ProgramFiles)\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd.exe";
#We use SQL Code Guard just for code analysis.
CodeGuardAlias = "${env:ProgramFiles(x86)}\SQLCodeGuard\SqlCodeGuard30.Cmd.exe";
# We use SQL Compare to compare build script with database
# and for generating scripts.
SQLCompareAlias = "${env:ProgramFiles(x86)}\Red Gate\SQL Compare 14\sqlcompare.exe";
# We use SQL Compare to compare build script with database
# and for generating scripts.
SQLDataCompareAlias = "${env:ProgramFiles(x86)}\Red Gate\SQL Data Compare 14\SQLDataCompare.exe";
#we use pgdump for doing ProgreSQL build scripts
PGDumpAlias = "${env:ProgramFiles}\PostgreSQL\14\bin\pg_dump.exe";
#${env:ProgramFiles}\PostgreSQL\14\bin\pg_dump.exe
#we always use PSQL to access ProgreSQL
psqlAlias = "$($env:LOCALAPPDATA)\Programs\pgAdmin 4\v5\runtime\psql.exe";
#we always use sqlite.exe to access SQLite and get build scripts from it
sqliteAlias = 'C:\ProgramData\chocolatey\lib\SQLite\tools\sqlite-tools-win32-x86-3360000\sqlite3.exe';
#we always use Oracle's SqlCl to access oracle 
OracleCmdAlias = "$($env:ProgramFiles)\sqldeveloper\sqlcl\bin\sql.exe"
#we use MySQLDump for doing MySQL and MariaDB build scripts
MySQLDumpAlias = $null;
#we use MySQL.exe for doing queries to MySQL databases.
MySQLAlias = $null;
SQLPackageAlias="$($env:ProgramFiles)\Microsoft SQL Server\170\DAC\bin\SqlPackage.exe";
}
