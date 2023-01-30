public with sharing class productSelector extends fflib_SObjectSelector implements IproductSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Product2.Id,
            Product2.Name,
            Product2.AvailableUnits__c,
            Product2.Price__c,
            Product2.ProductCode
        };
    }
    public Schema.SObjectType getsObjectType() {
        return Product2.sObjectType;
    }
    public List<Product2> getAllRecords(){
        String qry  = 'SELECT Id, Name , AvailableUnits__c , Price__c, ProductCode FROM Product2 ';
        return (List<Product2>)Database.query(qry);
    }
    public Map<Id, Product2> getAllRecordsMap(){
        String qry  = 'SELECT Id, Name , AvailableUnits__c , Price__c, ProductCode FROM Product2 ';
        return new Map<Id, Product2>((List<Product2>)Database.query(qry));
    }
    public static IproductSelector newInstance(){
        return (IproductSelector) Application.Selector.newInstance(Product2.SObjectType);
    }

}


