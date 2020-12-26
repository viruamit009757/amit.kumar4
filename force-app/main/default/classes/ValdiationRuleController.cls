public class ValdiationRuleController {

    @AuraEnabled
    public Static List<validationRuleWrapper> getValidationRule(){
        List<validationRuleWrapper> validationRule = new List<validationRuleWrapper> ();
        Http h1 = new Http();
        HttpRequest hreq = new HttpRequest();
        hreq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); //Get user Session ID
   		hreq.setHeader('Content-Type', 'application/json');
        String SFdomainUrl=URL.getSalesforceBaseUrl().toExternalForm();
		String query='select+id,ValidationName,Description,CreatedById,CreatedDate+from+ValidationRule';        
        hreq.setEndpoint(SFdomainUrl+'/services/data/v33.0/tooling/query/?q='+query);
        hreq.setMethod('GET');
        HttpResponse response = h1.send(hreq);
        system.debug('response'+response.getBody());
        JSONParser parser = JSON.createParser(response.getBody());
        System.debug('parser'+parser);
        return validationRule;
    }
    
    public class validationRuleWrapper{
        @AuraEnabled
        public String size;
        @AuraEnabled
        public String totalSize;
        @AuraEnabled
        public boolean done;
        @AuraEnabled
        public String queryLocator;
        @AuraEnabled
        public String entityTypeName;
        @AuraEnabled
        public List<recordListWrapper> records; 
    }
    Public class recordListWrapper{
        @AuraEnabled
       public attributeWrapper attributes;
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String ValidationName;
        @AuraEnabled
        public String Active;
        @AuraEnabled
        public String Description;
        @AuraEnabled
        public String CreatedById;
        @AuraEnabled
        public String CreatedDate;
        @AuraEnabled
        public String LastModifiedById;
        @AuraEnabled
        public String ErrorDisplayField;
        @AuraEnabled
        public String ErrorMessage;
    }
    public class attributeWrapper{
        @AuraEnabled
         public String type;
        @AuraEnabled
        public String  url;
    }
}