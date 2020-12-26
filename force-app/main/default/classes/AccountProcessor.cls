global class AccountProcessor {
@future 
    public static void countContacts(set<Id> recordIds){
        List<Account> AccList = [select id , number_of_contacts__c ,(Select id from Contacts) From Account where id In :recordIds];
         List<Account> updtLst = new List<Account>();
         for(Account a :AccList){
            a.Number_of_Contacts__c = a.contacts.size();
             UpdtLst.add(a);
        }
        Update updtLst;
    }
}