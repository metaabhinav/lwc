public with sharing class myCartController {
    @AuraEnabled(cacheable=true)
    public static List<PurchaseOrder__c> getPurchaseOrders(){
        return ShoppingCartService.getPurchaseOrders();
    }
    @AuraEnabled(cacheable=true)
    public static List<Product2> getAllProducts(){
        return ShoppingCartService.getAllProducts();
    }
    @AuraEnabled
    public static void placeOrder(List<PurchaseOrderLineItem__c> purchaseOrderLineItems){
        ShoppingCartService.placeOrder(purchaseOrderLineItems);
    } 
}


