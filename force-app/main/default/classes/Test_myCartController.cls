@isTest
public with sharing class Test_myCartController {
	@isTest
	private static void testGetPurchaseOrders_ShouldReturnAllPurchaseOrders() {
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IShoppingCartService serviceMock = (IShoppingCartService) mocks.mock(ShoppingCartServiceImpl.class);

		//Given
		mocks.startStubbing();
		List<PurchaseOrder__c> pos = new List<PurchaseOrder__c>{
			new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.SObjectType)),
			new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.SObjectType))
		};
		mocks.when(serviceMock.getPurchaseOrders()).thenReturn(pos);
		mocks.stopStubbing();
		Application.Service.setMock(IShoppingCartService.class, serviceMock);

		//When
		test.startTest();
		List<PurchaseOrder__c> receivedPOs = myCartController.getPurchaseOrders();
		test.stopTest();

		//Then
		((IShoppingCartService) mocks.verify(serviceMock)).getPurchaseOrders();
		System.assertEquals(pos, receivedPOs);
	}

	@isTest
	private static void testGetAllProducts_ShouldReturnAllProducts() {
		fflib_ApexMocks mocks = new fflib_ApexMocks();
        IShoppingCartService serviceMock = (IShoppingCartService) mocks.mock(ShoppingCartServiceImpl.class);

		//Given
		mocks.startStubbing();
		List<Product2> prods = new List<Product2>{
			new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test 1'),
			new Product2(Id = fflib_IDGenerator.generate(Product2.SObjectType), Name = 'Test 2')
		};
		mocks.when(serviceMock.getAllProducts()).thenReturn(prods);
		mocks.stopStubbing();
		Application.Service.setMock(IShoppingCartService.class, serviceMock);

		//When
		test.startTest();
		List<Product2> receivedProds = myCartController.getAllProducts();
		test.stopTest();

		//Then
		((IShoppingCartService) mocks.verify(serviceMock)).getAllProducts();
		System.assertEquals(prods, receivedProds);
	}

	@isTest
	private static void testPlaceOrder_GivenCorrectPurchaseOrderLineItems_NewPurchaseOrderIsCreated(){
	    fflib_ApexMocks mocks = new fflib_ApexMocks();
	    IShoppingCartService serviceMock = new Mocks.ShoppingCartService(mocks);
        IproductSelector selectorMock = new Mocks.productSelector(mocks);

		//Given
		mocks.startStubbing();
		Product2 p1 = new Product2(
            Id = fflib_IDGenerator.generate(Product2.SObjectType),
			Name = 'Test 1',
			AvailableUnits__c = 5,
			Price__c = 50
		);
		Product2 p2 = new Product2(
            Id = fflib_IDGenerator.generate(Product2.SObjectType),
			Name = 'Test 2',
			AvailableUnits__c = 10,
			Price__c = 100
		);
		List<Product2> products = new List<Product2>{p1, p2};
		Map<Id, Product2> productMap = new Map<Id, Product2>(products);
        mocks.when(selectorMock.sObjectType()).thenReturn(Product2.SObjectType);
		mocks.when(selectorMock.getAllRecordsMap()).thenReturn(productMap);
        mocks.stopStubbing();
        Application.Selector.setMock(selectorMock);
        Application.Service.setMock(IShoppingCartService.class, serviceMock);

        //When
        test.startTest();
        List<PurchaseOrderLineItem__c> polis = new List<PurchaseOrderLineItem__c>{
            new PurchaseOrderLineItem__c(Product__c = p1.Id, Units__c = 4),
            new PurchaseOrderLineItem__c(Product__c = p2.Id, Units__c = 10)
        };
        myCartController.placeOrder(polis);
        test.stopTest();
        
        //Then
        ((IShoppingCartService) mocks.verify(serviceMock)).placeOrder(polis);
	}
}



