public class Contact_Pagination {
    
@auraEnabled
public static list<Contact> getAllContacts()
    {
       list<Contact> con =[select id,Lastname,FirstName,Email,langaue__c from Contact];
     return con;
    }
}