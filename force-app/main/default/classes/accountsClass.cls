public class accountsClass {

@auraEnabled
public static list<account> getAllAccounts()
    {
       list<account> accs =[select id,name,phone,industry from account];
     return accs;
    }
}