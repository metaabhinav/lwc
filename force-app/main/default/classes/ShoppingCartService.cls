global with sharing class ShoppingCartService {
	global static List<Product2> getAllProducts() {
		return service().getAllProducts();
	}
	global static List<PurchaseOrder__c> getPurchaseOrders() {
		return service().getPurchaseOrders();
	}
	global static void placeOrder(List<PurchaseOrderLineItem__c> purchaseOrderLineItems) {
		service().placeOrder(purchaseOrderLineItems);
	}
    private static IShoppingCartService service(){
        return (IShoppingCartService) Application.Service.newInstance(IShoppingCartService.class);
    }
}



