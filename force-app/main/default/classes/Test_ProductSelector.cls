@isTest
private with sharing class Test_ProductSelector {
    @isTest
    private static void checkTest_ProductSelector(){
        
		//given
        List<Product2> insertList = new List<Product2>();
        for(Integer iterator=0;iterator<5;iterator++){
           Product2 newProd = new Product2(Name='Mouse',Price__c=50,AvailableUnits__c=5);
           insertList.add(newProd);
        }
        insert insertList;
        
        //when
        Test.startTest();
        List<Product2> listProd = productSelector.getAllRecords();
        Test.stopTest();
        
        //then
        //System.debug(listProd[0].Name);
        System.assertEquals(listProd.size(),5,'This test case does not run');
 
    }
}