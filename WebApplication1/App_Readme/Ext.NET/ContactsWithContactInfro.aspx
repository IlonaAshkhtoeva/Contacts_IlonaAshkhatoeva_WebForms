<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        ContactStore.Data = this.Contacts;
    }

    public List<Contact> Contacts
    {
        get
        {
            return new List<Contact>
                 {
                    new Contact(1, "1", new ContactInfo(1, "Cross Street 11/1", "Big City", 564564654 )),
                    new Contact(1, "Ilona", new ContactInfo(1, "Ashkhatoeva", "Tbilisi", 557777745)),
                    new Contact(2, "Aleksandre", new ContactInfo(2, "Ashkhatoevi", "Tbilisi", 557777777)),
                    new Contact(3, "Ilona",  new ContactInfo(3,  "Ashkhatoeva", "Tbilisi", 571646564)),
                    new Contact(4, "Kote",  new ContactInfo(4,  "Kotiko", "Tbilisi", 557777777)),
                    new Contact(5, "Vaso", new ContactInfo(5,  "Vasiko", "Tbilisi", 571644764)),
                    new Contact(6, "Beqa", new ContactInfo(6,  "Bequli", "Tbilisi", 557777777)),
                    new Contact(7, "Nata",  new ContactInfo(7,  "Natuli", "Tbilisi", 571555555))
                 };
        }
    }

    public class ContactInfo
    {

        public ContactInfo(int id, string surname, string address, int phoneNumber)
        {
            this.Id = id;
            this.surname = surname;
            this.address = address;
            this.phoneNumber = phoneNumber;
        }
        public int Id
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

    public class Contact
    {
        public Contact(int id, string name, ContactInfo contactInfo)
        {
            this.Id = id;
            this.Name = name;
            this.contactInfo = contactInfo;
        }
        public int Id
        {
            get;
            private set;
        }
        public string Name
        {
            get;
            private set;
        }
        public ContactInfo contactInfo
        {
            get;
            private set;
        }
    }


    protected void Add_Click(object sender, DirectEventArgs e)
    {
        X.Redirect("http://localhost:61364/App_Readme/ContactInfo.aspx");
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            // Html  = this.TextArea1.Text
        }).Show();
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

</script>


<!DOCTYPE html>

<html>

<head runat="server">
    <title>Ilona Ashkhatoeva - Task Contacts</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>

<body>

    <ext:ResourceManager runat="server" Theme="Triton" />
 

     <%-- Additional form --%>
    <ext:Model runat="server" Name="ContactsInfo" IDProperty="Id">
            <Fields>
                <ext:ModelField Name="Id " Type="Int" />
                <ext:ModelField Name="name" />
                <ext:ModelField Name="surname" />
                <ext:ModelField Name="address" />
                <ext:ModelField Name="phoneNumber" />
            </Fields>
    </ext:Model>
    <%-- Additional form --%>


   <%-- Main grid panel with contact --%>
   <ext:Store ID="ContactStore" runat="server">
        <Model>
            <ext:Model runat="server" Name="Contact" IDProperty="Id">
               <Fields>
                    <ext:ModelField Name="Id" Type="Int" />
                    <ext:ModelField Name="Name" />
                </Fields>
                <Associations>
                    <ext:HasOneAssociation Model="contactInfo" AssociationKey="contactInfo" />
                </Associations>               
            </ext:Model>
        </Model>
   </ext:Store>
   <%-- Main grid panel with contact --%>
   

   <ext:Panel  ID="contacts" runat="server" Border="false" Width="1500" Height="600" DefaultAnchor="100%">  
    
        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Defaults>
            <ext:Parameter Name="margin" Value="5" Mode="Raw" />
        </Defaults>
          

        <%-- Main grid panel with contact --%>
        <Items>
        <ext:GridPanel runat="server" StoreID="ContactStore" Title="Contacts" Flex="1">           
        

              <ColumnModel>
                    <Columns>
                        <ext:Column runat="server" Text="Name" DataIndex="Name" Flex="1" />
                    </Columns>
                </ColumnModel>
               
            <Listeners>
                <SelectionChange Handler="selected.length && selected[0].contactInfo(function(contactInfo){#{ContactsInfo}.loadRecord(contactInfo);});" />
            </Listeners>
          </ext:GridPanel>  
          <%-- Main grid panel with contact --%>

              <%-- Additional form --%>
          <ext:FormPanel ID="ContactsInfo" runat="server" Title="Contact infomation" BodyPadding="5" Flex="1">
                <Items>
                    <ext:DisplayField runat="server" FieldLabel="Id" Name="id" />
                    <ext:DisplayField runat="server" FieldLabel="Surname" Name="surname" />
                    <ext:DisplayField runat="server" FieldLabel="Address" Name="address" />
                    <ext:DisplayField runat="server" FieldLabel="Phone number" Name="phoneNumber" />
               </Items>
            </ext:FormPanel>
        </Items>
    </ext:Panel>

   
</body>
</html>
