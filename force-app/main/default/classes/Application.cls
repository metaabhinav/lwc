public class Application {
	public static final fflib_Application.ServiceFactory Service = new fflib_Application.ServiceFactory(
		new Map<Type, Type>{ IShoppingCartService.class => ShoppingCartServiceImpl.class }
	);

	public static final fflib_Application.SelectorFactory Selector = new fflib_Application.SelectorFactory(
		new Map<SObjectType, Type>{
			Product2.SObjectType => productSelector.class,
			PurchaseOrder__c.SObjectType => purchaseOrderSelector.class
		}
	);
}



