<%@ Page Language="C#" %>

<script runat="server">

    protected void OK_Click(object sender, DirectEventArgs e)
    {
         X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            // Html  = this.TextArea1.Text
        }).Show();
        X.Redirect("http://localhost:61364/Ext.NET.Default.aspx");
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            // Html  = this.TextArea1.Text
        }).Show();
    }

    protected void Cancel_Click(object sender, DirectEventArgs e)
    {
       X.Redirect("http://localhost:61364/Ext.NET.Default.aspx");
    }

</script>

<!DOCTYPE html>
    
<html>

<body>
   <ext:ResourceManager runat="server" Theme="Triton" />
 
    <form runat="server">
        <ext:Panel 
            ID="contactsInfo"
            runat="server" 
            Title="Contact information"
            Height="400"
            Width="800"
            Frame="true"       
            Cls="box"
            BodyPadding="5"  
            Layout="AnchorLayout"
            DefaultAnchor="100%">
           
            <Buttons>
                <ext:Button ID="OK" runat="server" Text="OK" Icon="Accept" OnDirectClick="OK_Click" />
                <ext:Button ID="Cancel" runat="server" Text="Cancel" Icon="Cancel" OnDirectClick="Cancel_Click" />
            </Buttons>

             <Items>
                 <ext:TextField runat="server" FieldLabel="Name" AllowBlank="false"/>
                 <ext:TextField runat="server" FieldLabel="Surname" AllowBlank="false"/>
                 <ext:TextField runat="server" FieldLabel="Address" AllowBlank="false"/>
                 <ext:NumberField runat="server" FieldLabel="Phone Number" AllowBlank="false"/>
             </Items>
            
        </ext:Panel>
    </form>


</body>
</html>