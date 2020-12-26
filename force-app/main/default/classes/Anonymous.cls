public class Anonymous {
   public class patientstatuswrapper{
        @AuraEnabled public String statusName {get; set;}
       	@AuraEnabled public  String apiName {get; set;}
        @AuraEnabled public List<statusFields> statusFields {get; set;}
    }
    
    public class statusFields{
        @AuraEnabled public String label {get; set;}
        @AuraEnabled public String type {get; set;}
        @AuraEnabled public  List<options> options {get; set;}
        @AuraEnabled public  String value {get; set;}
    }
    
    public class options{
        @AuraEnabled public String label {get; set;}
        @AuraEnabled public String value {get; set;}
    }
   /* public static String Anonymous(){
        String json2String ;
        json2String=
            '{'+
	             'statusName'+ ':'+ 'Consented'+','+
	             'apiName'+ ':' +'Consented'+','+
	             'statusFields'+ ':'+ '['+'{'+
			                                         'label'+':'+'The patient has completed the Consented status'+','+
			                                         'type'+':'+ 'Date of Consent'+','+
													'options'+':' +'['+
																			'{ label'+':'+ 'Completed in Study Hub'+','+ 'value'+':'+ 'option1'+ '},'+
																			'{ label'+':'+ 'Completed outside of Study Hub'+', value:'+ 'option2' +'},'+
																		'],'+
											    	'value:' +''+
											'}'+']'+
			'}';
        System.debug('json2String'+json2String);
        return json2String;
    } */

}