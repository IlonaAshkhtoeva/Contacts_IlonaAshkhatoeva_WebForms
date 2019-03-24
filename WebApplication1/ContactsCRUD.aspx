<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
  
    <title>Contacts CRUD - IA</title>
   
    <script runat="server">
    
        public class MyContacts
        {
            public static object Model = new
            {
                stores = new
                {contacts = new{model = "Contact", autoLoad = true, session = true}}
            };
        }
    </script>

    <script>

        function createDialog(record) {
            var view = App.View;

            var dialog = view.add(App.getChildSessionForm({
                viewModel: {
                    data: {
                        title: record ? 'Edit: ' + record.get('name') : 'Add Contact'
                    },
                    // If we are passed a record, a copy of it will be created in the newly spawned session.
                    // Otherwise, create a new phantom Contact in the child.
                    links: {
                        theContact: record || {type: 'Contact', create: true }
                    }
                },

                // Creates a child session that will spawn from the current session
                // of this view.
                session: true
            }));

            dialog.isEdit = !!record;
            dialog.show();
        }

        function onRemoveContactClick(button) {
            var ContactGrid = App.View.lookupReference("contactGrid"),
                selection = ContactGrid.getSelectionModel().getSelection()[0];

            selection.drop();
        }

        function onSaveClick() {
            // Save the changes pending in the dialog's child session back to the
            // parent session.
            var dialog = this.up("window"),
                form = App.View.lookupReference("form"),
                isEdit = dialog.isEdit,
                id;

            if (form.isValid()) {
                if (!isEdit) {
                    // Since we're not editing, we have a newly inserted record. Grab the id of
                    // that record that exists in the child session
                    id = dialog.getViewModel().get('theContact').id;
                }
                dialog.getSession().save();
                if (!isEdit) {
                    // Use the id of that child record to find the phantom in the parent session,
                    // we can then use it to insert the record into our store
                    App.View.getViewModel().getStore('contacts').add(App.View.getSession().getRecord('Contact', id));
                }
                Ext.destroy(dialog);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <ext:Model runat="server" Name="Contact">        
            <Fields>
                    <ext:ModelField Name="Id" />
                    <ext:ModelField Name="name" />
                    <ext:ModelField Name="surname" />
                    <ext:ModelField Name="address" />
                    <ext:ModelField Name="phone" Type="Int" />
                </Fields>
            <Proxy>
                <ext:AjaxProxy Url="contacts.json" />
            </Proxy>
        </ext:Model>  
        <ext:Window runat="server" LazyMode="Config" Layout="FitLayout" Modal="true" Width="1000" Height="600" Closable="true" CloseAction="Destroy" TemplateWidget="true" TemplateWidgetFnName="getChildSessionForm">   
            <Bind>
                <ext:Parameter Name="title" Value="{title}" />
            </Bind>   
            <Items>
                <ext:FormPanel runat="server" Frame="true" Reference="form" BodyPadding="10" Border="false" ModelValidation="true">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Name" Reference="name" MsgTarget="Side" BindString="{theContact.name}" />
                        <ext:TextField runat="server" FieldLabel="Surname" Reference="name" MsgTarget="Side" BindString="{theContact.surName}" />
                        <ext:TextField runat="server" FieldLabel="Phone" Reference="phone" MsgTarget="Side" BindString="{theContact.phone}" />  
                        <ext:TextField runat="server" FieldLabel="Address" Reference="address" MsgTarget="Side" BindString="{theContact.address}" />  
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" Handler="onSaveClick" />
                <ext:Button runat="server" Text="Cancel" Handler="Ext.destroy(this.up('window'))" />
            </Buttons>
        </ext:Window>

        <ext:Panel ID="View" runat="server" Title="Contacts" ReferenceHolder="true" Frame="true" Width="1000" Height="600" Session="true" ViewModel="<%# MyContacts.Model %>" AutoDataBind="true">
           <LayoutConfig>
               <ext:VBoxLayoutConfig Align="Stretch" />
           </LayoutConfig>
           <Items>
               <ext:GridPanel runat="server" Frame="true" BindString="{contacts}" Reference="contactGrid" Flex="1">
                   <ColumnModel>
                       <Columns>
                           <ext:Column runat="server" Text="Name" DataIndex="name" Flex="1" />
                           <ext:Column runat="server" Text="Surname" DataIndex="surName" Flex="1" />
                           <ext:Column runat="server" Text="Phone" DataIndex="phone" Width="115" />      
                           <ext:Column runat="server" Text="Address" DataIndex="address" Width="115" />

                            <ext:CommandColumn runat="server" Width="50">
                                <Commands>
                                    <ext:GridCommand CommandName="edit" Text="Edit" />
                                </Commands>
                                <Listeners>
                                    <Command Handler="createDialog(record);" />
                                </Listeners>
                            </ext:CommandColumn>
                       </Columns>
                   </ColumnModel>
               </ext:GridPanel>
           </Items>
           <%-- Buttons --%>  
           <TopBar>
               <ext:Toolbar runat="server">
                   <Items>
                       <ext:ButtonGroup runat="server">
                         <Items>                                
                           <ext:Button runat="server" Text="Add" Icon="Add" Handler="createDialog(null);" />
                           <ext:Button runat="server" Text="Remove" Icon="Delete" Handler="onRemoveContactClick">                        
                               <Bind>
                                   <ext:Parameter Name="disabled" Value="{!contactGrid.selection}" />
                               </Bind>
                           </ext:Button>                                  
                           </Items>
                       </ext:ButtonGroup>                  
                   </Items>
               </ext:Toolbar>
           </TopBar>
           <%-- Buttons --%>
        </ext:Panel>
    </form>
</body>
</html>