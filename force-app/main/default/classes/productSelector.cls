public with sharing class productSelector extends fflib_SObjectSelector {
    @TestVisible  
    private static productSelector instance;

    public static productSelector getInstance(){
        if(instance == null){
            instance = new productSelector();
        }
        return instance;
    }
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Product2.Id,
            Product2.Name,
            Product2.AvailableUnits__c,
            Product2.Price__c,
            Product2.ProductCode
        };
    }
    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }
    public static List<Product2> getAllRecords(){
        String qry  = 'SELECT Id, Name , AvailableUnits__c , Price__c, ProductCode FROM Product2 ';
        //System.debug(Database.query(qry));
        return (List<Product2>)Database.query(qry);
    }
    public static Map<Id, Product2> getAllRecordsMap(){
        String qry  = 'SELECT Id, Name , AvailableUnits__c , Price__c, ProductCode FROM Product2 ';
        return new Map<Id, Product2>((List<Product2>)Database.query(qry));
    }
    public  List<Product2> getRecords(){
        return getAllRecords();
    }
}

