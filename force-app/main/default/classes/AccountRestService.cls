@RestResource(urlMapping='/AccountService/*')
global class AccountRestService {  
 @httpget
    global static List<Account> GetAccount(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('req.requestURI'+req.requestURI);
        string requestURI = req.requestURI;   
        String accName='%'+requestURI.substring(requestURI.lastIndexOf('=')+1)+'%';
        List<Account> AccountList =  [select id,Name from Account where name like :accName];
        if(!AccountList.isEmpty() && AccountList.size()>0){
            return AccountList;
        }    
        return [select id,name from Account];    
    }
    @httpdelete
    global Static String deleteAccount(){
        String Responsemessage;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('req.requestURI'+req.requestURI);
        string requestURI = req.requestURI;   
        String accName='%'+requestURI.substring(requestURI.lastIndexOf('=')+1)+'%';
        List<Account> acclist = [select id,name from Account where name like :accName limit 1]; 
        if(acclist.size()>0 && !acclist.isEmpty()){
            String accountid = acclist[0].id +' '+acclist[0].name;
            try{
                delete acclist;
            }catch(exception ex){
                Responsemessage = 'Exception occured during delete =>'+ex.getMessage();
            }
            Responsemessage =  'Account deleted sucesfully => one account is deleted : ' +accountid;
        }
        
        return Responsemessage;
    }
}

/* @RestResource(urlMapping='/LeadService/*')
global class LeadRestService {
   @httpget
    global static list<lead> getleadInformation(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('req.requestURI'+req.requestURI);
        string requestURI = req.requestURI;       
        string leadName ='%'+requestURI.substring(requestURI.lastIndexOf('=')+1)+'%';
        system.debug('leadName'+leadName);
        list<lead> leadlist = [SELECT Id,Name,Email,Phone,Company,MobilePhone from lead where Name like :leadName];
        return leadlist;
    }
} */