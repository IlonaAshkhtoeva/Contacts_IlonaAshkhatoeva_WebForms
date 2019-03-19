<%@ Page Language="C#" %>

<script runat="server">

    protected void Add_Click(object sender, DirectEventArgs e)
    {
        ContactStore.Add(new {Id = 1, name = "Nam", surname =  "Ashkhatoeva", address = "Tbilisi", phoneNumber = 557777745});
        //ContactStore.Insert(1, new { id = 1, name = "Nam", surname = "Ashkhatoeva", address = "Tbilisi", phoneNumber = 557777745 });
    }

 
    protected void Edit_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            // Html  = this.TextArea1.Text
        }).Show();
    }

    protected void Update_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            //   Html  = this.TextArea1.Text
        }).Show();
    }

    protected void Delete_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            //   Html  = this.TextArea1.Text
        }).Show();

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ContactStore.Data = this.Contacts;

        if (!X.IsAjaxRequest)
        {
            ContactStore.DataSource = this.Contacts;
            ContactStore.DataBind();
        }

    }


    [DirectMethod(ShowMask = true, CustomTarget = "#{ContactsInfo}")]
    public object GetContact(string action, Dictionary<string, object> extraParams)
    {
        int id = Convert.ToInt32(extraParams["id"]);
        return this.Contacts.Where(a => a.Id  == id);
    }

    public class Contact
    {

        public Contact(int id, string name, string surname, string address, int phoneNumber)
        {
            this.Id = id;
            this.name = name;
            this.surname = surname;
            this.address = address;
            this.phoneNumber = phoneNumber;
        }

        public int Id
        {
            get;
            private set;
        }

        public string name
        {
            get;
            private set;
        }

        public string surname
        {
            get;
            private set;
        }

        public string address
        {
            get;
            private set;
        }

        public int phoneNumber
        {
            get;
            private set;
        }
    }

    public List<Contact> Contacts
    {
        get
        {
            return new List<Contact>
                 {

                    new Contact(1, "Ilona", "Ashkhatoeva", "Tbilisi", 557777745),
                    new Contact(2, "Aleksandre", "Ashkhatoevi", "Tbilisi", 557777777),
                    new Contact(3, "Ilona", "Ashkhatoeva", "Tbilisi", 571646564),
                    new Contact(4, "Kote", "Kotiko", "Tbilisi", 557777777),
                    new Contact(5, "Vaso", "Vasiko", "Tbilisi", 571644764),
                    new Contact(6, "Beqa", "Bequli", "Tbilisi", 557777777),
                    new Contact(7, "Nata", "Natuli", "Tbilisi", 571555555)
                 };
        }

    }

</script>


<!DOCTYPE html>

<html>

<head runat="server">
    <title>Ilona Ashkhatoeva - Task Contacts</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>

<body>

    <ext:ResourceManager runat="server" Theme="Triton" />
 
 <%--   <script>
        function showContactInfo() {
            Ext.getCmp('contactsInfo').show();
        }
    </script>--%>

   <%-- Main grid panel with contact --%>
   <ext:Store ID="ContactStore" runat="server">
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="Id" />
                    <ext:ModelField Name="name" />
                    <ext:ModelField Name="surname" />
                    <ext:ModelField Name="address" />
                    <ext:ModelField Name="phone number" Type="Int" />
                </Fields>

                    <%-- <Associations>
                        <ext:HasOneAssociation Model="ContactInfo" PrimaryKey="Id" />
                    </Association--%>                      
            </ext:Model>
        </Model>
        <Sorters>
            <ext:DataSorter Property="name" Direction="DESC" />
            <ext:DataSorter Property="surname" />
        </Sorters>
   </ext:Store>
   <%-- Main grid panel with contact --%>
   
   <%-- Additional form --%>
    <%--<ext:Model runat="server" Name="ContactsInfo" IDProperty="Id">


            <Fields>
                <ext:ModelField Name="Id " Type="Int" />
                <ext:ModelField Name="name" />
                <ext:ModelField Name="surname" />
                <ext:ModelField Name="address" />
                <ext:ModelField Name="phoneNumber" />
            </Fields>
            <Proxy>
                <ext:PageProxy DirectFn="App.direct.GetContact" />
            </Proxy>
    </ext:Model>--%>
    <%-- Additional form --%>
     
    
   <%----------------------------------------%>

   <ext:Panel  ID="contacts" runat="server" Border="false" Width="1000" Height="600" DefaultAnchor="100%">  
    


        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Defaults>
            <ext:Parameter Name="margin" Value="5" Mode="Raw" />
        </Defaults>
          
        <%-- Main grid panel with contact --%>
        <Items>
        <ext:GridPanel runat="server"  StoreID="ContactStore" Title="Contacts" Flex="1">           
           <%-- Buttons --%>  
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
                          <Items>   
                              
                             
               
                                <ext:Button ID="Add" runat="server" Text="Add" Icon="Add" OnDirectClick="Add_Click" />
                         
                                  
   
                                <ext:Button ID="Edit" runat="server" Text="Edit" Icon="ApplicationEdit" OnDirectClick="Edit_Click" >
                                
                                </ext:Button>

                                <ext:Button ID="Update" runat="server" Text="Update" Icon="ApplicationForm" >             
                                    <%--<Listeners>
                                        <Click fn="showContactInfo"></Click>                      
                                    </Listeners>--%>
                                </ext:Button>
                                <ext:Button ID="Delete" runat="server" Text="Delete" Icon="Delete" OnDirectClick="Delete_Click" />                                                                
                            </Items>
                        </ext:ButtonGroup>                  
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <%-- Buttons --%>


            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Id" Flex="1" DataIndex="Id" />
   
                    <ext:Column runat="server" Text="Name" Flex="1" DataIndex="name"> 
                        <Editor>
                            <ext:TextField runat="server"/>
                        </Editor>
                    </ext:Column>    
                    <ext:Column runat="server" Text="Surname" Flex="1" DataIndex="surname" >
                         <Editor>
                            <ext:TextField runat="server"/>
                        </Editor>
                    </ext:Column>  
                    <ext:Column runat="server" Text="Address" Flex="1" DataIndex="address" >
                         <Editor>
                            <ext:TextField runat="server"/>
                        </Editor>
                    </ext:Column>  
                    <ext:Column runat="server" Text="Phone Number" Flex="1" DataIndex="phoneNumber" >
                         <Editor>
                            <ext:TextField runat="server"/>
                        </Editor>
                    </ext:Column>  
                </Columns>
            </ColumnModel>

             <Plugins>
                <ext:CellEditing runat="server">
                    <Listeners>
                        <BeforeEdit Handler="return e.record.data.ed;" />
                    </Listeners>
                </ext:CellEditing>
            </Plugins>


            <Listeners>
                <SelectionChange Handler="selected.length && selected[0].getContact(function(contact){#{ContactsInfo}.loadRecord(contact);});" />
            </Listeners>
          </ext:GridPanel>  
          <%-- Main grid panel with contact --%>

          <%-- Additional form --%>
<%--          <ext:FormPanel ID="ContactsInfo" runat="server" Title="Contact infomation" BodyPadding="5" Flex="1">
                <Items>
                    <ext:DisplayField runat="server" FieldLabel="Id" Name="id" />
                    <ext:DisplayField runat="server" FieldLabel="Name" Name="name" />
                    <ext:DisplayField runat="server" FieldLabel="Surname" Name="surname" />
                    <ext:DisplayField runat="server" FieldLabel="Address" Name="address" />
                    <ext:DisplayField runat="server" FieldLabel="Phone number" Name="phoneNumber" />
                </Items>
          </ext:FormPanel>--%>
          <%-- Additional form --%>   

        </Items>
    </ext:Panel>
  
</body>
</html>