import { LightningElement, api } from 'lwc';
import placeOrder from '@salesforce/apex/myCartController.placeOrder';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Price', fieldName: 'Price__c' },
    { label: 'Product Code', fieldName: 'ProductCode' },
    { label: 'Units', fieldName: 'Units__c' }
];

export default class Invoice extends LightningElement {
    columns = columns
    @api finalProducts = []

    handlePlacedOrder(){
        let dataToSend = this.finalProducts.map((record) =>{
            return {Product__c : record["Product__c"], Units__c : record["Units__c"]}
        });
        placeOrder({purchaseOrderLineItems :  dataToSend}).then( () =>{
            alert("New Purchase Order Created");
        }).catch((e) => {
            alert("Error Received as following : " + JSON.stringify(e))
        });

    }
}


