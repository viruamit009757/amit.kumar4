public class accountrecordsclass
{
public String rid{get;set;}
public list<account> acclist{get;set;}
public String accname{get;set;}
public String getAccountfromVF{get;set;}
Account delacc = new Account();
public accountrecordsclass()
{
acclist = [select id,name,accountnumber,type,phone from account];
}
 
public PageReference doDelete() {
delacc=[select Id from account where id =:rId];
delete delacc;
pagereference ref = new pagereference('/apex/thankyou');
return ref;
}
public Pagereference addAccount(){
Account acc = new Account(Name = getAccountfromVF);
insert acc;
pagereference refresh = apexpages.currentpage();
return refresh;
}
}