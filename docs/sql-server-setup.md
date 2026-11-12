# SQL Server setup

The application uses your existing database and does not create or rename the five tables.

## 1. Check your SQL Server instance
In SQL Server Management Studio, connect to the instance where the **Airport Management** database is stored. In Object Explorer, the server name at the top is the value required in the connection string.

## 2. Configure the connection
Open `Web.config` in Visual Studio and replace `YOUR_SERVER_NAME` in the `AirportDb` connection string with your SQL Server instance name.

Examples:
- LocalDB: `(localdb)\\MSSQLLocalDB`
- SQL Express: `.\\SQLEXPRESS`
- Default local instance: `.`

The supplied connection string uses Windows Authentication. If your SQL Server uses SQL Authentication, configure credentials locally and do not commit passwords to GitHub.

## 3. Open and run
1. Open `AirportManagement.sln` in Visual Studio 2015.
2. If prompted, allow Visual Studio to retarget the project to .NET Framework 4.5.2 or install that targeting pack.
3. Set the project as the startup project.
4. Press **Ctrl + F5**.
5. The dashboard should show counts from Airport, Aircraft, Terminal, Gate and Flight.

## Existing schema expected

- Airport(`Airport_ID`, `Airport_name`, `Location`)
- Aircraft(`Aircraft_ID`, `Aircraft_type`, `Capacity`)
- Terminal(`Terminal_ID`, `Terminal_name`, `Location`, `Airport_ID`)
- Gate(`Gate_ID`, `Gate_No`, `Terminal_ID`)
- Flight(`Flight_ID`, `Flight_No`, `Date`, `Airport_ID`, `Aircraft_ID`, `Gate_ID`)

All primary-key columns are manually supplied (they are not IDENTITY columns). Foreign-key constraints remain enforced by SQL Server. A delete can fail when another record references the row; this is expected relational-database behavior.

## Notes
- The dashboard's flight schedule joins Flight to Airport, Aircraft and Gate.
- The management screen supports listing, adding, editing and deleting records.
- Do not run a table-recreation script against your existing project database.
