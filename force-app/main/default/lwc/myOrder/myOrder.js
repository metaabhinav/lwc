import { LightningElement, wire } from 'lwc';
import getPurchaseOrders from '@salesforce/apex/myCartController.getPurchaseOrders';

const purchaseOrderColumns = [
    { label: 'PO Id', fieldName: 'PO_Id__c', sortable: "true"},
    { label: 'Status', fieldName: 'Status__c', sortable: "true" },
    { label: 'Order Total', fieldName: 'Order_Total__c', sortable: "true" }
];

export default class MyOrders extends LightningElement {
    purchaseOrderColumns = purchaseOrderColumns;
    totalPurchaseOrderData = [];
    
    @wire(getPurchaseOrders)
    wireCallback({data, error}){
        if(data){
            this.totalPurchaseOrderData = data
        }
    }

    newPurchaseOrder(){
        this.dispatchEvent(new CustomEvent('neworder', {
            detail: {
                showOrders:false,
                showProducts:true
            }
        }))
    }
        
}



