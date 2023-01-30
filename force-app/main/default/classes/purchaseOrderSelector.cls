public with sharing class purchaseOrderSelector extends fflib_SObjectSelector implements IpurchaseOrderSelector {
	public List<Schema.SObjectField> getSObjectFieldList() {
		return new List<Schema.SObjectField>{
			PurchaseOrder__c.Id,
			PurchaseOrder__c.PO_Id__c,
			PurchaseOrder__c.Status__c,
			PurchaseOrder__c.Order_Total__c
		};
	}
	public Schema.SObjectType getSObjectType() {
		return PurchaseOrder__c.sObjectType;
	}
	public List<PurchaseOrder__c> getAllRecords() {
		String qry = 'SELECT Id, PO_Id__c , Status__c , OrderTotal__c FROM PurchaseOrder__c ';
		return (List<PurchaseOrder__c>) Database.query(qry);
	}
	public static IpurchaseOrderSelector newInstance(){
		return (IpurchaseOrderSelector) Application.Selector.newInstance(PurchaseOrder__c.SObjectType);
	}
}



