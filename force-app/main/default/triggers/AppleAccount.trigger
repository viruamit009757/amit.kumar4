trigger AppleAccount on Account (after insert, after update) {
     for(integer i=1; i<5; i++){
 List<Opportunity> oppList = new List<Opportunity>();
    Map<Id,Account> acctwithOpport = new map<Id,Account>(
        [Select Id,(Select Id from Opportunities) from Account WHERE Id IN : Trigger.new]
    );
   
       for(Account acc : Trigger.new){
        oppList.add(new Opportunity(Name=acc.Name + ' Opportunity' + i,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acc.Id));
        insert oppList;
    }  
    }  
}