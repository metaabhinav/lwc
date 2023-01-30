@isTest
public with sharing class Test_ShoppingCartService {
	@isTest
	private static void testGetAllProducts_shouldReturnAllProducts() {
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IproductSelector selectorMock = new Mocks.productSelector(mocks);

		//Given
		mocks.startStubbing();
		Product2 p1 = new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test');
		Product2 p2 = new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test');
		List<Product2> productList = new List<Product2>{ p1, p2 };
		mocks.when(selectorMock.sObjectType()).thenReturn(Product2.SObjectType);
		mocks.when(selectorMock.getAllRecords()).thenReturn(productList);
		mocks.stopStubbing();
		Application.Selector.setMock(selectorMock);

		//When
		Test.startTest();
		List<Product2> receivedProductList = ShoppingCartService.getAllProducts();
		Test.stopTest();

		//Then
		((IproductSelector) mocks.verify(selectorMock)).getAllRecords();
		System.assertEquals(productList, receivedProductList);
	}

	@isTest
	private static void testGetPurchaseOrders_shouldReturnAllPurchaseOrders() {
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IpurchaseOrderSelector selectorMock = new Mocks.purchaseOrderSelector(mocks);

		//Given
		mocks.startStubbing();
		PurchaseOrder__c p1 = new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.SObjectType));
		List<PurchaseOrder__c> purchaseOrdersList = new List<PurchaseOrder__c>{ p1 };
		mocks.when(selectorMock.sObjectType()).thenReturn(PurchaseOrder__c.SObjectType);
		mocks.when(selectorMock.getAllRecords()).thenReturn(purchaseOrdersList);
		mocks.stopStubbing();
		Application.Selector.setMock(selectorMock);

		//When
		Test.startTest();
		List<PurchaseOrder__c> receivedPurchaseOrders = ShoppingCartService.getPurchaseOrders();
		Test.stopTest();

		//Then
		((IpurchaseOrderSelector) mocks.verify(selectorMock)).getAllRecords();
		System.assertEquals(purchaseOrdersList, receivedPurchaseOrders);
	}

	@isTest
	private static void testPlaceOrder_givenListOfPurchaseOrderListItems_shouldGenerateANewPurchaseOrder() {
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IproductSelector selectorMock = new Mocks.productSelector(mocks);

		//Given
		mocks.startStubbing();
		Product2 p1 = new Product2(
			Name = 'Test 1',
			AvailableUnits__c = 5,
			Price__c = 50
		);
		Product2 p2 = new Product2(
			Name = 'Test 2',
			AvailableUnits__c = 10,
			Price__c = 100
		);
		List<Product2> products = new List<Product2>{p1, p2};
		insert products;
        Map<Id, Product2> productMap = new Map<Id, Product2>(products);
        mocks.when(selectorMock.sObjectType()).thenReturn(Product2.SObjectType);
		mocks.when(selectorMock.getAllRecordsMap()).thenReturn(productMap);
        mocks.stopStubbing();
        Application.Selector.setMock(selectorMock);

        //When
        test.startTest();
        List<PurchaseOrderLineItem__c> polis = new List<PurchaseOrderLineItem__c>{
            new PurchaseOrderLineItem__c(Product__c = p1.Id, Units__c = 4),
            new PurchaseOrderLineItem__c(Product__c = p2.Id, Units__c = 10)
        };
        ShoppingCartService.placeOrder(polis);
        test.stopTest();

        //Then
        ((IproductSelector) mocks.verify(selectorMock)).getAllRecordsMap();
        System.assertEquals(2, [SELECT Id FROM PurchaseOrderLineItem__c].size());
        System.assertEquals(1, [SELECT Id FROM PurchaseOrder__c].size());		
    }
}



