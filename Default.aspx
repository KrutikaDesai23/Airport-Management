<%@ Page Language="C#" ResponseEncoding="utf-8" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AirportManagement.DefaultPage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>SkyPort | Airport Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@500;600;700;800&display=swap" rel="stylesheet" />
    <link href="Content/Site.css?v=3" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
<input type="hidden" name="activeTable" value="<%= ViewState["CurrentTable"] %>" />
<div class="shell">
    <aside class="sidebar">
        <a class="brand" href="Default.aspx"><span class="brand-mark">&#9992;</span><span>SKYPORT<small>AVIATION MANAGEMENT</small></span></a>
        <div class="nav-caption">YOUR WORKSPACE</div>
        <asp:LinkButton ID="DashboardLink" runat="server" CssClass="nav-link active" OnClick="DashboardLink_Click"><span class="nav-icon">&#9638;</span> Overview <span class="nav-arrow">&#8594;</span></asp:LinkButton>
        <div class="nav-caption nav-caption-spaced">MANAGE RESOURCES</div>
        <asp:LinkButton ID="AirportLink" runat="server" CssClass="nav-link" CommandArgument="Airport" OnCommand="TableLink_Command"><span class="nav-icon">&#8962;</span> Airports</asp:LinkButton>
        <asp:LinkButton ID="AircraftLink" runat="server" CssClass="nav-link" CommandArgument="Aircraft" OnCommand="TableLink_Command"><span class="nav-icon">&#9992;</span> Aircraft</asp:LinkButton>
        <asp:LinkButton ID="TerminalLink" runat="server" CssClass="nav-link" CommandArgument="Terminal" OnCommand="TableLink_Command"><span class="nav-icon">&#9636;</span> Terminals</asp:LinkButton>
        <asp:LinkButton ID="GateLink" runat="server" CssClass="nav-link" CommandArgument="Gate" OnCommand="TableLink_Command"><span class="nav-icon">&#8677;</span> Boarding gates</asp:LinkButton>
        <asp:LinkButton ID="FlightLink" runat="server" CssClass="nav-link" CommandArgument="Flight" OnCommand="TableLink_Command"><span class="nav-icon">&#8644;</span> Flights</asp:LinkButton>
        <div class="sidebar-card">
            <div class="sidebar-card-icon">&#10003;</div>
            <strong>System connected</strong>
            <span>Your database is online and ready.</span>
            <small><i></i> SQL SERVER · ADO.NET</small>
        </div>
        <div class="sidebar-foot">SKYPORT <span>VERSION 1.0 · STUDENT EDITION</span></div>
    </aside>
    <main class="main">
        <header class="topbar">
            <div><span class="eyebrow">AIRPORT OPERATIONS / COMMAND CENTRE</span><h1><asp:Literal ID="PageHeading" runat="server" Text="Good morning, operator." /></h1><p class="top-subtitle">A clearer view of your airport ecosystem.</p></div>
            <div class="topbar-right"><span class="system-status"><i></i> All systems operational</span><span class="profile-chip">SP</span></div>
        </header>
        <asp:Panel ID="DashboardPanel" runat="server">
            <section class="welcome">
                <div class="welcome-copy">
                    <span class="hero-kicker"><span></span> YOUR AIRPORT, AT A GLANCE</span>
                    <h2>Every journey<br />starts <em>here.</em></h2>
                    <p>One place to organise airports, aircraft, terminals, gates and flight schedules.</p>
                    <asp:LinkButton ID="HeroFlightsLink" runat="server" CssClass="hero-button" CommandArgument="Flight" OnCommand="TableLink_Command">Explore flight records <span>&#8594;</span></asp:LinkButton>
                </div>
                <div class="welcome-photo">
                    <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&w=1200&q=85" alt="Airplane wing above the clouds" />
                    <div class="photo-caption"><span>SKYPORT / 001</span><strong>Built for smooth operations.</strong></div>
                </div>
                <div class="hero-orbit"></div>
            </section>
            <div class="section-heading"><div><span class="eyebrow">LIVE OVERVIEW</span><h3>Operations snapshot</h3></div><span class="updated-note"><i></i> Connected to live database</span></div>
            <div class="stats">
                <div class="stat stat-airports"><div class="stat-top"><span class="stat-icon">&#8962;</span><span class="stat-label">AIRPORTS</span></div><strong><asp:Literal ID="AirportCount" runat="server" /></strong><small>Registered locations</small></div>
                <div class="stat stat-aircraft"><div class="stat-top"><span class="stat-icon">&#9992;</span><span class="stat-label">AIRCRAFT</span></div><strong><asp:Literal ID="AircraftCount" runat="server" /></strong><small>Fleet records</small></div>
                <div class="stat stat-terminals"><div class="stat-top"><span class="stat-icon">&#9636;</span><span class="stat-label">TERMINALS</span></div><strong><asp:Literal ID="TerminalCount" runat="server" /></strong><small>Active terminals</small></div>
                <div class="stat stat-gates"><div class="stat-top"><span class="stat-icon">&#8677;</span><span class="stat-label">GATES</span></div><strong><asp:Literal ID="GateCount" runat="server" /></strong><small>Boarding locations</small></div>
                <div class="stat stat-flights"><div class="stat-top"><span class="stat-icon">&#8644;</span><span class="stat-label">FLIGHTS</span></div><strong><asp:Literal ID="FlightCount" runat="server" /></strong><small>Flight records</small></div>
            </div>
            <div class="dashboard-grid">
                <section class="panel schedule-panel"><div class="panel-head"><div><span class="eyebrow">UP-TO-DATE RECORDS</span><h3>Recent flight activity</h3><p class="muted">The latest flight entries saved in your database.</p></div><span class="live-tag"><i></i> LIVE DATA</span></div>
                    <asp:GridView ID="RecentFlights" runat="server" CssClass="data-grid" GridLines="None" AutoGenerateColumns="true" EmptyDataText="No flight records found." />
                </section>
                <aside class="side-feature">
                    <div class="feature-image"><img src="https://images.unsplash.com/photo-1569154941061-e231b4725ef1?auto=format&fit=crop&w=700&q=80" alt="Modern airport terminal interior" /><span>THE SKYPORT EXPERIENCE</span></div>
                    <div class="feature-copy"><span class="eyebrow">QUICK ACCESS</span><h3>Manage your<br />airport resources.</h3><p>Jump straight into a section and keep your records organised.</p>
                        <asp:LinkButton ID="QuickAirportLink" runat="server" CssClass="quick-link" CommandArgument="Airport" OnCommand="TableLink_Command">Manage airports <span>&#8599;</span></asp:LinkButton>
                        <asp:LinkButton ID="QuickAircraftLink" runat="server" CssClass="quick-link" CommandArgument="Aircraft" OnCommand="TableLink_Command">Manage aircraft <span>&#8599;</span></asp:LinkButton>
                        <asp:LinkButton ID="QuickTerminalLink" runat="server" CssClass="quick-link" CommandArgument="Terminal" OnCommand="TableLink_Command">Manage terminals <span>&#8599;</span></asp:LinkButton>
                    </div>
                </aside>
            </div>
        </asp:Panel>
        <asp:Panel ID="TablePanel" runat="server" Visible="false">
            <div class="table-intro"><div><span class="eyebrow">RESOURCE MANAGEMENT / SKYPORT DATABASE</span><h2><asp:Literal ID="TableHeading" runat="server" /></h2><p>Keep your airport information accurate, organised and up to date.</p></div><div class="table-intro-mark">&#9638;</div></div>
            <section class="panel records-panel">
                <div class="panel-head"><div><span class="eyebrow">DATABASE TABLE</span><h3>All records</h3><p class="muted">View, add, edit and remove records in your SQL Server database.</p></div><span class="table-tag">SQL SERVER</span></div>
                <asp:Label ID="Message" runat="server" CssClass="message" />
                <div class="toolbar"><asp:Button ID="RefreshButton" runat="server" Text="&#8635; Refresh records" CssClass="btn btn-ghost" OnClick="RefreshButton_Click" /></div>
                <asp:GridView ID="RecordsGrid" runat="server" CssClass="data-grid" GridLines="None" AutoGenerateColumns="false" DataKeyNames="__PK" OnRowEditing="RecordsGrid_RowEditing" OnRowCancelingEdit="RecordsGrid_RowCancelingEdit" OnRowUpdating="RecordsGrid_RowUpdating" OnRowDeleting="RecordsGrid_RowDeleting" />
            </section>
            <section class="panel form-panel"><div class="panel-head"><div><span class="eyebrow">ADD TO YOUR DATABASE</span><h3>Create a new record</h3><p class="muted">Fill in the details below. IDs are entered manually in this database.</p></div><span class="form-number">NEW ENTRY / 01</span></div>
                <div class="entry-grid"><asp:PlaceHolder ID="InsertFields" runat="server" /></div>
                <asp:Button ID="InsertButton" runat="server" Text="&#65291; Save record" CssClass="btn btn-primary" OnClick="InsertButton_Click" />
            </section>
        </asp:Panel>
        <asp:Panel ID="ErrorPanel" runat="server" Visible="false" CssClass="error-panel"><h3>Database connection issue</h3><asp:Literal ID="ErrorText" runat="server" /></asp:Panel>
        <footer><span>© SKYPORT AIRPORT MANAGEMENT</span><span>DESIGNED FOR BETTER OPERATIONS <b>✦</b></span></footer>
    </main>
</div>
</form>
</body>
</html>