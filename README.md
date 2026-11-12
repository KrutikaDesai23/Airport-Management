# Airport Management System

A college RDBMS project built around the existing **Airport Management** SQL Server database.

## Application
- ASP.NET Web Forms / C# / ADO.NET
- Visual Studio 2015-compatible project targeting .NET Framework 4.5.2
- Dashboard with Airport, Aircraft, Terminal, Gate and Flight counts
- Flight schedule with Airport, Aircraft and Gate details
- Table management screens for viewing, inserting, editing and deleting records
- Parameterized SQL commands for data changes

## Database
The application connects to the existing five-table schema and does not recreate it. IDs are entered manually because the primary-key columns are not identity columns.

## Run locally
See [docs/sql-server-setup.md](docs/sql-server-setup.md) for the connection-string setup and launch instructions.

**Important:** Replace `YOUR_SERVER_NAME` in the local `Web.config` connection string. Do not commit database passwords or secrets.
