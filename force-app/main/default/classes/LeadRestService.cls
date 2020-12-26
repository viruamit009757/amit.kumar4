@RestResource(urlMapping='/LeadService/*')

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

    @httpDelete

    global static string deleteMatchingLead(){

        string responseMessage;

        integer leadCount =0;

        try{

            RestRequest req = RestContext.request;

            RestResponse res = RestContext.response;

            system.debug('req.requestURI'+req.requestURI);

            string requestURI = req.requestURI;       

            string leadName ='%'+requestURI.substring(requestURI.lastIndexOf('=')+1)+'%';

            system.debug('leadName'+leadName);

            list<lead> leadlist = [SELECT Id,Name,Email,Phone,Company,MobilePhone from lead where Name like :leadName];

            if(leadlist!=NULL && leadlist.size()>0){

                leadCount = leadlist.size();

            }

            delete leadlist;

        }

        catch(Exception ex){

            responseMessage =  'Exception occured during delete =>'+ex.getMessage();   

        }

        responseMessage =  'Lead deleted sucesfully => lead deleted count : '+leadCount;

        return responseMessage;

       

    }

    @HttpPost

    global static string createNewLead(string fname,string lname,string cname,string leademail,string leadphoneNumber){

        string respMessage;

        try{

            lead l = new lead();

            l.FirstName = fname;

            l.LastName = lname;

            l.Company = cname;

            l.Email = leademail;

            l.Phone = leadphoneNumber;

            insert l;

            respMessage = 'Lead created succesfully with id as: '+l.id;

        }

        catch(Exception ex){

            respMessage = 'Error occured during new lead creation=>'+ex.getMessage();     

        }

        return respMessage;

    }

    @httpPatch

    global static string updateLeadEmail(string newEmail){

        string respMessage;

        try{

            RestRequest req = RestContext.request;

            string requestURI = req.requestURI;

            string leadid = requestURI.substring(requestURI.lastIndexOf('=')+1);

            lead mylead = [Select id,email from lead where id=:leadid];

            if(mylead!=NULL && mylead.Email !=newEmail){

                string oldemail = mylead.Email;

                mylead.email = newEmail;

                update mylead;

                respMessage = 'Lead updated from old email '+oldemail +' with new email as '+newEmail;

            }

            else{

                respMessage = 'Currently this lead is having same email address '+newEmail;

            }

        }

        catch(Exception ex){

           respMessage ='Exception occured during lead update '+ex.getMessage();

        }

       

        return respMessage;

    }

   

}