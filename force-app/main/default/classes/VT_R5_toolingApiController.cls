public class VT_R5_toolingApiController {
    public class ValidationData{
    @AuraEnabled
    public Integer size;
    @AuraEnabled
    public Integer totalSize;
    @AuraEnabled
    public List<Record> records {get;set;}
    }
    public class Record {
    @AuraEnabled
    public String Id {get;set;}
    @AuraEnabled
    public String FullName {get;set;}
    @AuraEnabled
    public String CreatedDate {get;set;}
    @AuraEnabled
    public String ValidationName {get;set;}
    }
@AuraEnabled 
public static ValidationData getValidationRule() {
    HttpRequest req = new HttpRequest();
    req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); //Get user Session ID
    req.setHeader('Content-Type', 'application/json');
    String SFdomainUrl=URL.getSalesforceBaseUrl().toExternalForm();
    String query='Select+id,FullName,createdDate,TableEnumOrId,ValidationName,Metadata+from+ValidationRule';
       // 'Select+id,ExternalStringId,Language,Value+from+ExternalStringLocalization+where+ExternalStringId=\'1012w00000E8sxb\'';
    //string query='Select+id,Name+from+WorkflowRule'; //use this query to get Workflow Rule
    req.setEndpoint(SFdomainUrl+'/services/data/v33.0/tooling/query/?q='+query);
    req.setMethod('GET');
    Http h = new Http();
    HttpResponse response = h.send(req);
    ValidationData validationObj = (ValidationData)System.JSON.deserialize(String.valueOf(response.getBody()), ValidationData.class);
    system.debug(response.getBody());
    system.debug('validationObj'+validationObj);
    return validationObj;
}   
}

/* tooling api query
 * /services/data/v49.0/tooling/query/?q=select+id,ValidationName,Active,Description,CreatedById,CreatedDate,LastModifiedById,LastModifiedDate,ErrorDisplayField,ErrorMessage+from+ValidationRule
 * json response
 {
  "size" : 2,
  "totalSize" : 2,
  "done" : true,
  "queryLocator" : null,
  "entityTypeName" : "ValidationRule",
  "records" : [ {
    "attributes" : {
      "type" : "ValidationRule",
      "url" : "/services/data/v49.0/tooling/sobjects/ValidationRule/03d2w000000hG30AAE"
    },
    "Id" : "03d2w000000hG30AAE",
    "ValidationName" : "AccountValidation",
    "Active" : true,
    "Description" : null,
    "CreatedById" : "0052w000001dwfrAAA",
    "CreatedDate" : "2020-11-04T04:11:09.000+0000",
    "LastModifiedById" : "0052w000001dwfrAAA",
    "LastModifiedDate" : "2020-11-04T04:11:09.000+0000",
    "ErrorDisplayField" : "Top of Page",
    "ErrorMessage" : "Please filled BillingPostalCode"
  }, {
    "attributes" : {
      "type" : "ValidationRule",
      "url" : "/services/data/v49.0/tooling/sobjects/ValidationRule/03d2w000000hG3AAAU"
    },
    "Id" : "03d2w000000hG3AAAU",
    "ValidationName" : "AccountValidation_2",
    "Active" : true,
    "Description" : null,
    "CreatedById" : "0052w000001dwfrAAA",
    "CreatedDate" : "2020-11-04T04:12:21.000+0000",
    "LastModifiedById" : "0052w000001dwfrAAA",
    "LastModifiedDate" : "2020-11-04T04:12:21.000+0000",
    "ErrorDisplayField" : "Top of Page",
    "ErrorMessage" : "Please filled Account Name"
  } ]
} */