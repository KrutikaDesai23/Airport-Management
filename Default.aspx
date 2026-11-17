<%@ Page Language="C#" ResponseEncoding="utf-8" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AirportManagement.DefaultPage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>SkyPort | Airport Operations</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=DM+Sans:wght@400;500;600;700;800&family=Manrope:wght@500;600;700;800&display=swap" rel="stylesheet" />
    <link href="Content/Site.css?v=8" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
<input type="hidden" name="activeTable" value="<%= ViewState["CurrentTable"] %>" />
<div class="app-shell">
    <aside class="sidebar">
        <a class="brand" href="Default.aspx">
            <span class="brand-symbol">&#9992;</span>
            <span class="brand-name">SKYPORT<small> AIRPORT OPERATIONS</small></span>
        </a>
        <div class="terminal-label">NAVIGATION <span>01—06</span></div>
        <asp:LinkButton ID="DashboardLink" runat="server" CssClass="nav-link active" OnClick="DashboardLink_Click"><span class="nav-code">00</span><span>Operations board</span><span class="nav-arrow">&#8599;</span></asp:LinkButton>
        <div class="nav-divider"><span>MANAGE DATA</span></div>
        <asp:LinkButton ID="AirportLink" runat="server" CssClass="nav-link" CommandArgument="Airport" OnCommand="TableLink_Command"><span class="nav-code">01</span><span>Airports</span></asp:LinkButton>
        <asp:LinkButton ID="AircraftLink" runat="server" CssClass="nav-link" CommandArgument="Aircraft" OnCommand="TableLink_Command"><span class="nav-code">02</span><span>Aircraft</span></asp:LinkButton>
        <asp:LinkButton ID="TerminalLink" runat="server" CssClass="nav-link" CommandArgument="Terminal" OnCommand="TableLink_Command"><span class="nav-code">03</span><span>Terminals</span></asp:LinkButton>
        <asp:LinkButton ID="GateLink" runat="server" CssClass="nav-link" CommandArgument="Gate" OnCommand="TableLink_Command"><span class="nav-code">04</span><span>Boarding gates</span></asp:LinkButton>
        <asp:LinkButton ID="FlightLink" runat="server" CssClass="nav-link" CommandArgument="Flight" OnCommand="TableLink_Command"><span class="nav-code">05</span><span>Flight records</span></asp:LinkButton>
        <div class="sidebar-bottom">
            <div class="connection-mark"><i></i> DATABASE CONNECTED</div>
            <p>SKYPORT SYSTEMS<br /><span>LOCAL SQL SERVER INSTANCE</span></p>
            <small>STUDENT EDITION <b>·</b> 01.0</small>
        </div>
    </aside>

    <main class="main-content">
        <header class="page-topline">
            <div class="breadcrumb">SKYPORT <span>/</span> AIRPORT OPERATIONS <span>/</span> <asp:Literal ID="PageHeading" runat="server" Text="Operations overview" /></div>
            <div class="topline-right"><span class="clock-label">OPERATIONS DESK</span><span class="desk-avatar">SP</span></div>
        </header>

        <asp:Panel ID="DashboardPanel" runat="server">
            <section class="intro-row">
                <div>
                    <div class="section-index">OPERATIONS CENTRE <span>—</span> 01</div>
                    <h1>Flight information<span class="title-period">.</span></h1>
                    <p class="intro-description">A clear view of the records and resources behind every journey.</p>
                </div>
                <div class="airport-stamp"><span>SP</span><small>SKYPORT<br />AIR OPERATIONS</small></div>
            </section>

            <section class="flight-board">
                <div class="board-heading">
                    <div><span class="board-kicker">FLIGHT REGISTER / DATABASE FEED</span><h2>Latest flight entries</h2></div>
                    <div class="board-status"><i></i> CONNECTED TO SQL SERVER</div>
                </div>
                <div class="board-columns"><span>RECENTLY ADDED FLIGHTS</span><span>RECORDS FROM YOUR DATABASE</span></div>
                <div class="board-table-wrap">
                    <asp:GridView ID="RecentFlights" runat="server" CssClass="data-grid flight-grid" GridLines="None" AutoGenerateColumns="true" EmptyDataText="No flight records found." />
                </div>
                <div class="board-footer"><span>SKYPORT <b>FLIGHT REGISTER</b></span><asp:LinkButton ID="HeroFlightsLink" runat="server" CssClass="board-link" CommandArgument="Flight" OnCommand="TableLink_Command">VIEW ALL FLIGHT RECORDS <span>&#8594;</span></asp:LinkButton></div>
            </section>

            <section class="metrics-section">
                <div class="metrics-heading"><div><span class="section-index">AIRPORT DIRECTORY <span>—</span> 02</span><h2>Network at a glance</h2></div><span class="metrics-note">LIVE DATABASE COUNTS</span></div>
                <div class="metrics-grid">
                    <div class="metric"><span class="metric-code">01 / LOCATION</span><strong><asp:Literal ID="AirportCount" runat="server" /></strong><span class="metric-name">Airports</span><span class="metric-mark">&#8962;</span></div>
                    <div class="metric"><span class="metric-code">02 / FLEET</span><strong><asp:Literal ID="AircraftCount" runat="server" /></strong><span class="metric-name">Aircraft</span><span class="metric-mark">&#9992;</span></div>
                    <div class="metric"><span class="metric-code">03 / BUILDING</span><strong><asp:Literal ID="TerminalCount" runat="server" /></strong><span class="metric-name">Terminals</span><span class="metric-mark">&#9636;</span></div>
                    <div class="metric"><span class="metric-code">04 / ACCESS</span><strong><asp:Literal ID="GateCount" runat="server" /></strong><span class="metric-name">Boarding gates</span><span class="metric-mark">&#8677;</span></div>
                    <div class="metric metric-accent"><span class="metric-code">05 / SCHEDULE</span><strong><asp:Literal ID="FlightCount" runat="server" /></strong><span class="metric-name">Flight records</span><span class="metric-mark">&#8644;</span></div>
                </div>
            </section>

            <section class="bottom-strip">
                <div class="bottom-photo"><img src="https://images.unsplash.com/photo-1569154941061-e231b4725ef1?auto=format&fit=crop&w=900&q=80" alt="Airport terminal" /><span>THE SKYPORT NETWORK</span></div>
                <div class="bottom-copy"><span class="section-index">RESOURCE DIRECTORY <span>—</span> 03</span><h2>Everything in its place.</h2><p>Choose a section to view, add, edit or remove records stored in your airport database.</p>
                    <div class="quick-links">
                        <asp:LinkButton ID="QuickAirportLink" runat="server" CssClass="quick-link" CommandArgument="Airport" OnCommand="TableLink_Command">Airports <span>&#8599;</span></asp:LinkButton>
                        <asp:LinkButton ID="QuickAircraftLink" runat="server" CssClass="quick-link" CommandArgument="Aircraft" OnCommand="TableLink_Command">Aircraft <span>&#8599;</span></asp:LinkButton>
                        <asp:LinkButton ID="QuickTerminalLink" runat="server" CssClass="quick-link" CommandArgument="Terminal" OnCommand="TableLink_Command">Terminals <span>&#8599;</span></asp:LinkButton>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <asp:Panel ID="TablePanel" runat="server" Visible="false">
            <section class="resource-heading">
                <div><span class="section-index">RESOURCE DIRECTORY <span>—</span> DATABASE ENTRY</span><h1><asp:Literal ID="TableHeading" runat="server" /><span class="title-period">.</span></h1><p class="intro-description">Manage the information stored in your SkyPort database.</p></div>
                <div class="resource-number">SP / DATA<br /><strong>01—05</strong></div>
            </section>
            <section class="records-section">
                <div class="records-top">
                    <div><span class="board-kicker">DATABASE TABLE</span><h2>All records</h2><p>View, add, edit and remove entries in this section.</p></div>
                    <asp:Button ID="RefreshButton" runat="server" Text="&#8635; Refresh" CssClass="refresh-button" OnClick="RefreshButton_Click" />
                </div>
                <asp:Label ID="Message" runat="server" CssClass="message" />
                <div class="records-table-wrap"><asp:GridView ID="RecordsGrid" runat="server" CssClass="data-grid records-grid" GridLines="None" AutoGenerateColumns="false" DataKeyNames="__PK" OnRowEditing="RecordsGrid_RowEditing" OnRowCancelingEdit="RecordsGrid_RowCancelingEdit" OnRowUpdating="RecordsGrid_RowUpdating" OnRowDeleting="RecordsGrid_RowDeleting" /></div>
            </section>
            <section class="create-section">
                <div class="create-heading"><div><span class="section-index">DATABASE ENTRY <span>—</span> NEW</span><h2>Add a record</h2><p>Enter the details below to add a new row to this table.</p></div><span class="create-symbol">+</span></div>
                <div class="entry-grid"><asp:PlaceHolder ID="InsertFields" runat="server" /></div>
                <asp:Button ID="InsertButton" runat="server" Text="Save record  &#8594;" CssClass="save-button" OnClick="InsertButton_Click" />
            </section>
        </asp:Panel>

        <asp:Panel ID="ErrorPanel" runat="server" Visible="false" CssClass="error-panel"><h3>Database connection issue</h3><asp:Literal ID="ErrorText" runat="server" /></asp:Panel>
        <footer class="app-footer"><span>© SKYPORT AIRPORT OPERATIONS</span><span>INFORMATION SYSTEM <b> / </b> VERSION 1.0</span></footer>
    </main>
</div>
</form>
</body>
</html>