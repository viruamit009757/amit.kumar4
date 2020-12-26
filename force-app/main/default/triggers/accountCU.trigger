trigger accountCU on Account (after insert, after update) {
account obj2=new account();
string name;
string phone;
string industry;
id id1;
account obj=trigger.new[0];
    
if ((obj.Name!='' || obj.Name!=null))
{
name=obj.Name;
phone =obj.phone;
industry =obj.industry;
id1=obj.id;
sendAcountToExternalSystem obj1 = new sendAcountToExternalSystem();
obj1.sendAccount(name,phone,industry,id1); // Calling helper method...
}
}