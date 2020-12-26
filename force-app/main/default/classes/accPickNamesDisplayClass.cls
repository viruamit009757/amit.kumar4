public with sharing class accPickNamesDisplayClass {
    List<selectOption> options = new List<selectOption>();
    public List<selectOption> getAccNames() {
        for(Account acc : [select Id,name from Account limit 5]) {
            options.add(new selectOption(acc.name,acc.name) );
        }
        return options;
    }
}