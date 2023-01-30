public class ShoppingCartServiceImpl implements IShoppingCartService {
    public List<Product2> getAllProducts(){
        return productSelector.newInstance().getAllRecords();
    }
    public List<PurchaseOrder__c> getPurchaseOrders(){
        return PurchaseOrderSelector.newInstance().getAllRecords();
    }
    public void placeOrder(List<PurchaseOrderLineItem__c> purchaseOrderLineItems){
        Map<Id, Product2> prods = productSelector.newInstance().getAllRecordsMap();
        Decimal total = 0;
        for(PurchaseOrderLineItem__c poli : purchaseOrderLineItems){
            total += prods.get(poli.Product__c).Price__c * poli.Units__c;
        }
        PurchaseOrder__c po = new PurchaseOrder__c(Status__c = 'Processing', Order_Total__c = total);
        insert po;
        List<PurchaseOrderLineItem__c> polis = new List<PurchaseOrderLineItem__c>();
        for(PurchaseOrderLineItem__c poli : purchaseOrderLineItems){
            polis.add(new PurchaseOrderLineItem__c(Product__c = poli.Product__c, Units__c = poli.Units__c, PurchaseOrder__c = po.Id));
        }
        insert polis;
    }
}


