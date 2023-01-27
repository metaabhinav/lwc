import { LightningElement, wire, track, api } from 'lwc';
import getAllProducts from '@salesforce/apex/myCartController.getAllProducts';

const productColumns = [
    { label: 'Name', fieldName: 'Name', sortable: "true" },
    { label: 'Price', fieldName: 'Price__c', sortable: "true" },
    { label: 'Product Code', fieldName: 'ProductCode', sortable: "true" },
    { label: 'Available Units', fieldName: 'AvailableUnits__c', sortable: "true" }
];

export default class ProductsList extends LightningElement {
    productColumns = productColumns;
    selectedProducts = {};
    productQuantMap = {};

    @track allProducts = []

    @wire(getAllProducts)
    wireCallback({ data, error }) {
        if (data) {
            this.allProducts = JSON.parse(JSON.stringify(data))
            this.allProducts.forEach((prod) => {
                const prodId = prod["Id"]
                this.productQuantMap[prodId] = prod["AvailableUnits__c"]
            })
        }
    }

    @api
    updateProductQuantity(detail) {
        console.log("came in updateProductQuantity")
        console.log("detial is " + JSON.stringify(detail))
        for (let prod of this.allProducts) {
            if (detail.id == prod["Id"]) {
                prod["AvailableUnits__c"] += Number(detail.quantity);
                this.productQuantMap[detail.id] += Number(detail.quantity);
                delete this.selectedProducts[detail.id]
            }
        }
        this.allProducts = [...this.allProducts]
    }
    @api
    handleProductQuantityUpdate(records) {
        for (let record of records) {
            this.productQuantMap[record["Product__c"]] -= record["Difference"]
        }
        this.updateStaticData();
    }

    updateStaticData() {
        for (let prod of this.allProducts) {
            prod["AvailableUnits__c"] = this.productQuantMap[prod["Id"]];
        }
        this.allProducts = [...this.allProducts]
    }
    addSelectedProducts(event) {
        let rowsComingIn = event.detail.selectedRows;
        this.selectedProducts = {}
        for (let record of rowsComingIn) {
            const Id = record.Id;
            this.selectedProducts[Id] = { quantity: 1, product: record };
        }
    }
    checkForProductQuant() {
        const prodIdsToCheckArray = Object.keys(this.selectedProducts)
        for (const prodId of prodIdsToCheckArray) {
            const newQuan = this.productQuantMap[prodId] - 1;
            if (newQuan < 0) {
                return false;
            }
        }
        return true;
    }
    updateAllProducts() {
        if (this.checkForProductQuant()) {
            for (const prod of this.allProducts) {
                if (this.selectedProducts[prod.Id]) {
                    this.productQuantMap[prod.Id] -= 1
                    prod["AvailableUnits__c"] -= 1
                }
            }
            this.allProducts = [...this.allProducts]
            return true;
        } else {
            return false
        }
    }
    addInCart() {
        if (JSON.stringify(this.selectedProducts) != "{}") {
            if (!this.updateAllProducts()) {
                alert("Selected Units exceeds Available Units");
                return;
            }
            this.dispatchEvent(new CustomEvent('add', {
                detail: {
                    selectedRows: this.selectedProducts
                }
            }));
        } else {
            alert("Please select atleast one product");
        }
    }
}




