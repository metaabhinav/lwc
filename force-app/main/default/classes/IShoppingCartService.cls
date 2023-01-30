public interface IShoppingCartService {
    
    List<Product2> getAllProducts();
    List<PurchaseOrder__c> getPurchaseOrders();
    void placeOrder(List<PurchaseOrderLineItem__c> purchaseOrderLineItems);
}


