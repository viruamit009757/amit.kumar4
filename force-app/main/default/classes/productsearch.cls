public class productsearch {
Public string inputtext{get;set;}
    Public List<product__c> accList2{get;set;}
    Public productsearch(){
     
     acclist2 = [select product_name__c ,mega_offer_price__c from product__c ];
     }
    
    Public void actionSupMethod(){
     system.debug('inputtext-->'+inputtext);
    
      accList2 = database.Query('select product_name__c, mega_offer_price__c  from product__c where name like '+'\''+'%'+inputtext+'%'+'\'');
    }
        

}