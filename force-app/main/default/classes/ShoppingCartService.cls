public with sharing class ShoppingCartService {
   
    public static List<Product2> getAllProducts(){
        return productSelector.getInstance().getRecords();
    }
    public static List<PurchaseOrder__c> getPurchaseOrders(){
        return purchaseOrderSelector.getInstance().getRecords();
    }
    
}