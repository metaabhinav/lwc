/* Generated by apex-mocks-generator version 4.0.1 */
@isTest
public class Mocks
{
	public class purchaseOrderSelector extends fflib_SObjectMocks.SObjectSelector implements IpurchaseOrderSelector
	{
		private fflib_ApexMocks mocks;

		public purchaseOrderSelector(fflib_ApexMocks mocks)
		{
			super(mocks);
			this.mocks = mocks;
		}

		public List<PurchaseOrder__c> getAllRecords()
		{
			return (List<PurchaseOrder__c>) mocks.mockNonVoidMethod(this, 'getAllRecords', new List<Type> {}, new List<Object> {});
		}
	}

	public class productSelector extends fflib_SObjectMocks.SObjectSelector implements IproductSelector
	{
		private fflib_ApexMocks mocks;

		public productSelector(fflib_ApexMocks mocks)
		{
			super(mocks);
			this.mocks = mocks;
		}

		public List<Product2> getAllRecords()
		{
			return (List<Product2>) mocks.mockNonVoidMethod(this, 'getAllRecords', new List<Type> {}, new List<Object> {});
		}

		public Map<Id, Product2> getAllRecordsMap()
		{
			return (Map<Id, Product2>) mocks.mockNonVoidMethod(this, 'getAllRecordsMap', new List<Type> {}, new List<Object> {});
		}
	}

	public class ShoppingCartService implements IShoppingCartService
	{
		private fflib_ApexMocks mocks;

		public ShoppingCartService(fflib_ApexMocks mocks)
		{
			this.mocks = mocks;
		}

		public List<Product2> getAllProducts()
		{
			return (List<Product2>) mocks.mockNonVoidMethod(this, 'getAllProducts', new List<Type> {}, new List<Object> {});
		}

		public List<PurchaseOrder__c> getPurchaseOrders()
		{
			return (List<PurchaseOrder__c>) mocks.mockNonVoidMethod(this, 'getPurchaseOrders', new List<Type> {}, new List<Object> {});
		}

		public void placeOrder(List<PurchaseOrderLineItem__c> purchaseOrderLineItems)
		{
			mocks.mockVoidMethod(this, 'placeOrder', new List<Type> {System.Type.forName('List<PurchaseOrderLineItem__c>')}, new List<Object> {purchaseOrderLineItems});
		}
	}

}