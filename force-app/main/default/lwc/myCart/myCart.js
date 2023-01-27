import { LightningElement, api, track } from 'lwc';

const productColumns = [
    { label: 'Name', fieldName: 'Name', sortable: "true" },
    { label: 'Price', fieldName: 'Price__c', sortable: "true" },
    { label: 'Product Code', fieldName: 'ProductCode', sortable: "true" },
    { label: 'Available Units', fieldName: 'AvailableUnits__c', sortable: "true" }
];

const actions = [
    { label: 'Delete', name: 'delete' }
];

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Price', fieldName: 'Price__c' },
    { label: 'Product Code', fieldName: 'ProductCode' },
    { label: 'Units', fieldName: 'Units__c', editable: true },
    { type: 'action', typeAttributes: { rowActions: actions} }
];

export default class MyCart extends LightningElement {
    columns = columns;
    updatedProductOrderLineItems = []

    @track productOrderLineItems = []
    
    @api
    set addedProducts(data) {
        let tempPurchaseOrderLineItems = []
        for (let record of Object.values(data)) {
            let purchaseOrderLineItem = {};
            purchaseOrderLineItem["Product__c"] = record["product"]["Id"];
            purchaseOrderLineItem["Name"] = record["product"]["Name"];
            purchaseOrderLineItem["Price__c"] = record["product"]["Price__c"];
            purchaseOrderLineItem["ProductCode"] = record["product"]["ProductCode"];
            purchaseOrderLineItem["AvailableUnits__c"] = record["product"]["AvailableUnits__c"];
            purchaseOrderLineItem["Units__c"] = record["quantity"];
            tempPurchaseOrderLineItems.push(purchaseOrderLineItem);
        }
        this.productOrderLineItems = tempPurchaseOrderLineItems
    }
    get addedProducts() {
        return this.addedProducts;
    }

    handleDeleteRow(event){
        const row = event.detail.row;
        const id = row["Product__c"];
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.productOrderLineItems = this.productOrderLineItems
                .slice(0, index)
                .concat(this.productOrderLineItems.slice(index + 1));
            this.dispatchEvent(new CustomEvent('deleteitem',{
                detail : {
                    id : row["Product__c"], 
                    quantity : row["Units__c"]}
            }))
        }
    }
    findRowIndexById(id) {
        let ret = -1;
        this.productOrderLineItems.some((row, index) => {
            if (row["Product__c"] === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }
    handleSave(event){
        this.updatedProductOrderLineItems = []
        for(let draftValue of event.detail.draftValues){
            const index = Number(draftValue["Id"].substring(4));
            if(draftValue["Units__c"] <= this.productOrderLineItems[index]["AvailableUnits__c"] && draftValue["Units__c"] > 0){
                let difference = draftValue["Units__c"] - this.productOrderLineItems[index]["Units__c"] 
                this.productOrderLineItems[index]["Units__c"] = Number(draftValue["Units__c"]);
                let dataWithDifference = this.productOrderLineItems[index]
                dataWithDifference["Difference"] = difference 
                this.updatedProductOrderLineItems.push(dataWithDifference)
            }else{
                alert("Selected Quantity is not valid");
            }
        }
        this.productOrderLineItems = [...this.productOrderLineItems];
        console.log("Dispatched the quantity change event with val " + JSON.stringify(this.updatedProductOrderLineItems))
        this.dispatchEvent(new CustomEvent('edititemquantity', {
            detail:{
                recordsInCart : this.updatedProductOrderLineItems 
            }
        }))
    }
    generateInvoice(){
        this.dispatchEvent(new CustomEvent('generateinvoice', {
            detail:{
                showProducts : false,
                showCart : false,
                showInvoice : true,
                finalData : this.productOrderLineItems
            }
        }))
    }   
}




