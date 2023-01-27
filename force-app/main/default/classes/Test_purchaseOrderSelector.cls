@isTest
private with sharing class Test_purchaseOrderSelector {
    @isTest
    private static void checkTest_purchaseOrderSelector() {

        	//given
            List<PurchaseOrder__c> insertList = new List<PurchaseOrder__c>();
            for(Integer iterator=0;iterator<5;iterator++){
               PurchaseOrder__c purOrder = new PurchaseOrder__c(Status__C='Processing',	Order_Total__c=50);
               insertList.add(purOrder);
            }
            insert insertList;
            
            //when
            Test.startTest();
            List<PurchaseOrder__c> listPurchaseOrder = purchaseOrderSelector.getAllRecords();
            Test.stopTest();
            
            //then
            //System.debug(listPurchaseOrder[0].Name);
            System.assertEquals(listPurchaseOrder.size(),5,'This test case does not run');
     

    }
}
