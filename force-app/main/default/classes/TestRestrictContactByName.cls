@isTest
private class TestRestrictContactByName{
    static testMethod void contactInsertSuccess(){
        Boolean insertFailed;
        Contact con=new Contact(FirstName='Arjun', LastName='Mahi');
        try{
            Test.startTest();
            insert con;
            Test.stopTest();
        }
        catch(Exception e){
            insertFailed = false;
        }
        System.assertEquals(false,insertFailed);
    }
    static testMethod void contactInsertFail(){
        Boolean insertFailed;
        Contact con=new Contact(FirstName='Arjun', LastName='INVALIDNAME');
        try{
            Test.startTest();
            insert con;
            Test.stopTest();
        }
        catch(Exception e){
            insertFailed = true;
        }
        System.assertEquals(true,insertFailed);
    }
}