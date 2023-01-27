public with sharing class purchaseOrderSelector extends fflib_SObjectSelector {
    @TestVisible  
    private static purchaseOrderSelector instance;

    public static purchaseOrderSelector getInstance(){
        if(instance == null){
            instance = new purchaseOrderSelector();
        }
        return instance;
    }
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            PurchaseOrder__c.Id,
            PurchaseOrder__c.PO_Id__c,
            PurchaseOrder__c.Status__c,
            PurchaseOrder__c.Order_Total__c};
    }
    public Schema.SObjectType getSObjectType() {
        return PurchaseOrder__c.sObjectType;
    }
    public static List<PurchaseOrder__c> getAllRecords(){
        String qry  = 'SELECT Id, PO_Id__c , Status__c , Order_Total__c FROM PurchaseOrder__c ';
        System.debug(Database.query(qry));
        return (List<PurchaseOrder__c>)Database.query(qry);
    }
    public  List<PurchaseOrder__c> getRecords(){
        return getAllRecords();
    }
}



