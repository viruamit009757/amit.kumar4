public class ContactAndLeadSearch {
    public static list<list<sobject>> searchContactsAndLeads(string LastName){
        List<List<SObject>> searchList = [FIND 'smith' IN ALL FIELDS 
                                      RETURNING Contact(Name), Lead(FirstName,LastName)];
        return searchList;
    }

}