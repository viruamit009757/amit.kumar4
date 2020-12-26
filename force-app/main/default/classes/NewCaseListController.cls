public class NewCaseListController {
     private String sortOrder = 'CaseNumber';    
    public List<Case> getNewCases() {
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber, Account.name ' +
            'FROM Case ' +
            'ORDER BY ' + sortOrder + ' ASC '
        );
        return results;
    } 
}