@isTest
private class AnimalLocatorTest {
    
    @isTest static void testgetAnimalNameById() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());     
        String result = '';
        result = AnimalLocator.getAnimalNameById(2);
         
        System.assertEquals('scary bear',result, 'The animals are same.');
    }
}