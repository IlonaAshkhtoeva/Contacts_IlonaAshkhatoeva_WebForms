<%@ Page Language="C#" %>

<script runat="server">

     protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store store = this.ContactStore.GetStore();

            store.DataSource = new List<object>
            {
                new { 
                    Name = "Ilona", 
                    Surname = "Ashkhatoeva", 
                    Address = "Tbilisi", 
                    PhoneNumber = 557353566,        
                },
                new { 
                    Name = "Ilona", 
                    Surname = "Ashkhatoeva", 
                    Address = "Tbilisi", 
                    PhoneNumber = 557353566,                 
                },
                new { 
                    Name = "Ilona", 
                    Surname = "Ashkhatoeva", 
                    Address = "Tbilisi", 
                    PhoneNumber = 557353566,                
                },
                new { 
                    Name = "Ilona", 
                    Surname = "Ashkhatoeva", 
                    Address = "Tbilisi", 
                    PhoneNumber = 557353566,               
                },
                new { 
                    Name = "Ilona", 
                    Surname = "Ashkhatoeva", 
                    Address = "Tbilisi", 
                    PhoneNumber = 557353566,                  
                }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>

<head runat="server">
    <title>Ilona Ashkhatoeva - Task Contacts</title>
   
    <script>
        var addContact = function () {

            var grid = App.ContactStore, store = grid.getStore(), fn = function () { console.log("fn"); this.allowEditAll = false; };

            grid.editingPlugin.cancelEdit();
     
            store.getSorters().removeAll(); 
            grid.getView().headerCt.setSortState();

            store.insert(0, { Name: 'Default name', Surname: 'Default Surname', Address: 'Default address' , PhoneNumber: 0});

            grid.editingPlugin.startEdit(0, 0);
        };

        var removeContact = function () {
            var grid = App.ContactStore,
                sm = grid.getSelectionModel(),
                store = grid.getStore();

            grid.editingPlugin.cancelEdit();
            store.remove(sm.getSelection());

            if (store.getCount() > 0) {
                sm.select(0);
            }
        };

        // შემოწმება რომ დავაკორექტიროთ მარტო ჩვენი დამატებულები // phantom რაც ახალი დამატებულია
        var onBeforeEdit = function (rowEditingPlugin, e) {
            var rowEditor = this.getEditor();

            rowEditor.items.each(function (field) {
                if (e.record.phantom) {
                    field.enable();
                } else {
                    field.disable();
                }
            });
        };
    </script>
</head>
<body>

   <form runat="server">
   <ext:ResourceManager runat="server" />

        <%-- Main grid panel with contact --%>
            
        <ext:GridPanel ID="ContactStore" runat="server" Width="1000" Height="600" Frame="true" Title="Cantacts">
     
        <Store>
          <ext:Store ID="Store1" runat="server"> 
            <Sorters>
                <ext:DataSorter Property="name" Direction="DESC" />
                <ext:DataSorter Property="surname" />
            </Sorters>
              <Model>
                <ext:Model runat="server">
                    <Fields>                     
                        <ext:ModelField Name="Name" ServerMapping="Name" Type="String" />
                        <ext:ModelField Name="Surname" ServerMapping="Surname" Type="String" />
                        <ext:ModelField Name="Address" ServerMapping="Address" Type="String" />
                        <ext:ModelField Name="PhoneNumber" ServerMapping="PhoneNumber" Type="Int" />                 
                    </Fields>                                 
                </ext:Model>
            </Model>         
            </ext:Store>

       </Store>
            <Plugins>
                <ext:RowEditing ID="RowEditing1" runat="server" ClicksToMoveEditor="1" AutoCancel="false">
                    <Listeners>
                        <BeforeEdit Fn="onBeforeEdit" />
                    </Listeners>
                </ext:RowEditing>
            </Plugins>

           <%-- Buttons --%>  
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
                          <Items>                                         
                                <ext:Button ID="Add" runat="server" Text="Add" Icon="Add">                     
                                    <Listeners>
                                        <Click Fn="addContact" />
                                     </Listeners>
                                </ext:Button>                         
                              <%--  <ext:Button ID="Edit" runat="server" Text="Edit" Icon="ApplicationEdit"/>
                                <ext:Button ID="Update" runat="server" Text="Update" Icon="ApplicationForm"/>      --%>                                                                     
                                <ext:Button ID="btnDeleteContact" runat="server" Text="Delete" Icon="Delete" Disabled="true" >
                                    <Listeners>
                                        <Click Fn="removeContact" />
                                    </Listeners>
                               </ext:Button> 
                            </Items>
                        </ext:ButtonGroup>                  
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <%-- Buttons --%>

            <%-- Main grid panel with contact --%>
            <ColumnModel runat="server">
                <Columns>               
                    <ext:Column runat="server" Text="Name" Flex="1" DataIndex="Name"> 
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" />
                        </Editor>
                    </ext:Column>    
                    <ext:Column runat="server" Text="Surname" Flex="1" DataIndex="Surname" >
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" />
                        </Editor>
                    </ext:Column>  
                    <ext:Column runat="server" Text="Address" Flex="1" DataIndex="Address" >
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" />
                        </Editor>
                    </ext:Column>  
                    <ext:Column runat="server" Text="Phone Number" Flex="1" DataIndex="PhoneNumber">
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" />
                        </Editor>
                    </ext:Column>  
                </Columns>
            </ColumnModel>
            <Listeners>
                <SelectionChange Handler="App.btnDeleteContact.setDisabled(!selected.length);" />
            </Listeners> 
            <%--თუ ვდგავართ გრიდზე მაშინ რომ იყოს აქტიური დელეტეს ღილარი--%>
          <%-- Main grid panel with contact --%>
        </ext:GridPanel>     
       </form> 
   </body>
</html>