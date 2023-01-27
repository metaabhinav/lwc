@isTest
public with sharing class Test_ShoppingCartService{
    @isTest
    static void getAllProductsTest(){
        fflib_ApexMocks mocks = new fflib_ApexMocks();

        productSelector mockProductSelector = (productSelector) mocks.mock(productSelector.class);
        productSelector.instance = mockProductSelector;

        PurchaseOrderSelector mockPurchaseOrderSelector = (PurchaseOrderSelector) mocks.mock(PurchaseOrderSelector.class);
        PurchaseOrderSelector.instance = mockPurchaseOrderSelector;

        Product2 p1 = new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test');
        Product2 p2 = new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test');
        List<Product2> productList = new List<Product2>{ p1, p2 };
        
        PurchaseOrder__c p3 = new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.SObjectType), Status__c = 'Processing');
        PurchaseOrder__c p4 = new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.SObjectType), Status__c = 'Processing');
        List<PurchaseOrder__c> purchaseOrderList = new List<PurchaseOrder__c>{
            p3,p4
       };
       mocks.startStubbing();

       mocks.when(mockProductSelector.getRecords()).thenReturn(productList);
       mocks.when(mockPurchaseOrderSelector.getRecords()).thenReturn(purchaseOrderList);
       
       mocks.stopStubbing();
    
       Test.startTest();
       ShoppingCartService.getAllProducts();
       ShoppingCartService.getPurchaseOrders();
       Test.stopTest(); 
     
       ((productSelector) mocks.verify(mockProductSelector,1)).getRecords();
       ((PurchaseOrderSelector) mocks.verify(mockPurchaseOrderSelector,1)).getRecords();
       }
    }


