# Airport Management System

A database-backed Airport Management System mini project using the existing SQL Server database **[Airport Management]**.

## Current database tables
- Airport
- Aircraft
- Terminal
- Gate
- Flight

## Planned application
- Dashboard with airport, aircraft, terminal, gate and flight summaries
- CRUD screens for the five tables
- Flight search and joined flight details
- Parameterized SQL queries through ADO.NET
- Input validation and clear status messages

## Technology target
- C# / ASP.NET on .NET Framework (Visual Studio 2015 compatible)
- ADO.NET
- Microsoft SQL Server
- HTML, CSS and Bootstrap

## Database schema confirmation
Before implementing table-specific CRUD, run [docs/inspect-database.sql](docs/inspect-database.sql) in SQL Server Management Studio and share the result grids. This confirms exact column names, SQL types, primary keys, foreign keys and identity settings.

Do not commit database passwords or connection strings containing credentials.

## Local setup
1. Open the solution in Visual Studio 2015.
2. Configure your local SQL Server connection string in Web.config.
3. Ensure the database named `Airport Management` exists.
4. Build and run the application.
