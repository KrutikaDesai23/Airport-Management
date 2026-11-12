<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AirportManagement.DefaultPage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>SkyPort | Airport Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">\n<input type="hidden" name="activeTable" value="<%= ViewState["CurrentTable"] %>" />
<div class="shell">
    <aside class="sidebar">
        <div class="brand"><span class="brand-mark">✈</span><div>SKYPORT<small>AIRPORT OPERATIONS</small></div></div>
        <div class="nav-caption">WORKSPACE</div>
        <asp:LinkButton ID="DashboardLink" runat="server" CssClass="nav-link active" OnClick="DashboardLink_Click">▦ &nbsp; Overview</asp:LinkButton>
        <div class="nav-caption">DATABASE MANAGEMENT</div>
        <asp:LinkButton ID="AirportLink" runat="server" CssClass="nav-link" CommandArgument="Airport" OnCommand="TableLink_Command">⌂ &nbsp; Airports</asp:LinkButton>
        <asp:LinkButton ID="AircraftLink" runat="server" CssClass="nav-link" CommandArgument="Aircraft" OnCommand="TableLink_Command">✈ &nbsp; Aircraft</asp:LinkButton>
        <asp:LinkButton ID="TerminalLink" runat="server" CssClass="nav-link" CommandArgument="Terminal" OnCommand="TableLink_Command">▤ &nbsp; Terminals</asp:LinkButton>
        <asp:LinkButton ID="GateLink" runat="server" CssClass="nav-link" CommandArgument="Gate" OnCommand="TableLink_Command">⇥ &nbsp; Gates</asp:LinkButton>
        <asp:LinkButton ID="FlightLink" runat="server" CssClass="nav-link" CommandArgument="Flight" OnCommand="TableLink_Command">⇄ &nbsp; Flights</asp:LinkButton>
        <div class="sidebar-foot">DATABASE CONNECTED<br/><span>SQL SERVER · ADO.NET</span></div>
    </aside>
    <main class="main">
        <header class="topbar"><div><span class="eyebrow">AIRPORT MANAGEMENT SYSTEM</span><h1><asp:Literal ID="PageHeading" runat="server" Text="Operations overview" /></h1></div><div class="top-pill">● &nbsp; CONTROL PANEL</div></header>
        <asp:Panel ID="DashboardPanel" runat="server">
            <div class="welcome"><div><div class="eyebrow light">FLIGHT OPERATIONS AT A GLANCE</div><h2>Welcome to SkyPort</h2><p>Manage airport resources and monitor flight records from one place.</p></div><div class="plane-art">✈</div></div>
            <div class="stats">
                <div class="stat"><span>REGISTERED AIRPORTS</span><strong><asp:Literal ID="AirportCount" runat="server" /></strong><small>Airport locations</small></div>
                <div class="stat"><span>AIRCRAFT FLEET</span><strong><asp:Literal ID="AircraftCount" runat="server" /></strong><small>Aircraft records</small></div>
                <div class="stat"><span>TERMINALS</span><strong><asp:Literal ID="TerminalCount" runat="server" /></strong><small>Airport terminals</small></div>
                <div class="stat"><span>BOARDING GATES</span><strong><asp:Literal ID="GateCount" runat="server" /></strong><small>Registered gates</small></div>
                <div class="stat"><span>FLIGHT RECORDS</span><strong><asp:Literal ID="FlightCount" runat="server" /></strong><small>Scheduled flights</small></div>
            </div>
            <section class="panel"><div class="panel-head"><div><span class="eyebrow">LATEST RECORDS</span><h3>Flight schedule</h3></div><span class="tag">LIVE DATABASE VIEW</span></div>
                <asp:GridView ID="RecentFlights" runat="server" CssClass="data-grid" GridLines="None" AutoGenerateColumns="true" EmptyDataText="No flight records found." />
            </section>
        </asp:Panel>
        <asp:Panel ID="TablePanel" runat="server" Visible="false">
            <section class="panel">
                <div class="panel-head"><div><span class="eyebrow">DATABASE MANAGEMENT</span><h3><asp:Literal ID="TableHeading" runat="server" /></h3><p class="muted">View, add, edit and remove records in your SQL Server database.</p></div><span class="tag">TABLE RECORDS</span></div>
                <asp:Label ID="Message" runat="server" CssClass="message" />
                <div class="toolbar"><asp:Button ID="RefreshButton" runat="server" Text="↻ Refresh" CssClass="btn btn-ghost" OnClick="RefreshButton_Click" /></div>
                <asp:GridView ID="RecordsGrid" runat="server" CssClass="data-grid" GridLines="None" AutoGenerateColumns="false" DataKeyNames="__PK" OnRowEditing="RecordsGrid_RowEditing" OnRowCancelingEdit="RecordsGrid_RowCancelingEdit" OnRowUpdating="RecordsGrid_RowUpdating" OnRowDeleting="RecordsGrid_RowDeleting" />
            </section>
            <section class="panel form-panel"><div class="panel-head"><div><span class="eyebrow">NEW ENTRY</span><h3>Add record</h3><p class="muted">Enter the record values. IDs are entered manually in this database.</p></div></div>
                <div class="entry-grid"><asp:PlaceHolder ID="InsertFields" runat="server" /></div>
                <asp:Button ID="InsertButton" runat="server" Text="＋ Add record" CssClass="btn btn-primary" OnClick="InsertButton_Click" />
            </section>
        </asp:Panel>
        <asp:Panel ID="ErrorPanel" runat="server" Visible="false" CssClass="error-panel"><h3>Database connection issue</h3><asp:Literal ID="ErrorText" runat="server" /></asp:Panel>
        <footer>SKYPORT AIRPORT MANAGEMENT <span>ACADEMIC PROJECT · SQL SERVER</span></footer>
    </main>
</div>
</form>
</body>
</html>