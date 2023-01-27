import { LightningElement, track } from 'lwc';

export default class ShoppingSystem extends LightningElement {
    @track showOrders = true;
    @track showProducts = false;
    @track showCart = false;
    @track showInvoice = false;
    @track selectedProducts
    @track allCartProducts = {}
    @track finalCartProducts = []

    handleNewOrder(event){
        this.showOrders = event.detail.showOrders;
        this.showProducts = event.detail.showProducts;
    }

    handleAddingProducts(event){
        this.showCart = true;
        this.addSelectedToAllCartProducts(event.detail.selectedRows);
    }

    addSelectedToAllCartProducts(productToAddInCart){
        for(const prodId of Object.keys(productToAddInCart)){
            if(this.allCartProducts[prodId]){
                this.allCartProducts[prodId]["quantity"]+= Number(1);
            }else{
                this.allCartProducts[prodId] = productToAddInCart[prodId];
                this.allCartProducts[prodId]["quantity"] = Number(this.allCartProducts[prodId]["quantity"]);
            }
        }
        this.allCartProducts = {...this.allCartProducts}
        // console.log()
    }

    handleDeletedItemFromCart(event){
        console.log("Event Data before deletion " + JSON.stringify(event.detail));

        console.log("Data before deletion " + JSON.stringify(this.allCartProducts));
        delete this.allCartProducts[event.detail.id]
        console.log("Data before deletion " + JSON.stringify(this.allCartProducts));

        this.template.querySelector('c-products-list').updateProductQuantity(event.detail);
    }

    handleQuantityChange(event){
        console.log("came in shopping system for quantity change");
        for(let record of event.detail.recordsInCart){
            this.allCartProducts[record["Product__c"]]["quantity"] = record["Units__c"];
        }
        this.template.querySelector('c-products-list').handleProductQuantityUpdate(event.detail.recordsInCart);
    }

    handleGenerateInvoice(event){
        this.showProducts = event.detail.showProducts;
        this.showCart = event.detail.showCart;
        this.showInvoice = event.detail.showInvoice;
        this.finalCartProducts = event.detail.finalData
    }
}




