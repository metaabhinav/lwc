import { LightningElement, api } from 'lwc';

export default class pagination extends LightningElement {
    totalPage = 0
    currentPage = 1
    
    @api pageSize
    @api
    set recordsLength(data) {
        if (data) {
            this.totalPage = Math.ceil(data / this.pageSize)
            this.updateRecords()
        }
    }
    get recordsLength(){
        return this.recordsLength
    }

    firstHandler() {
        this.currentPage = 1
        this.updateRecords()
    }
    previousHandler() {
        if (this.currentPage > 1) {
            this.currentPage = this.currentPage - 1
            this.updateRecords()
        }
    }
    nextHandler() {
        if (this.currentPage < this.totalPage) {
            this.currentPage = this.currentPage + 1
            this.updateRecords()
        }
    }
    lastHandler(){
        this.currentPage = this.totalPage;
        this.updateRecords();
    }
    updateRecords() {
        const start = (this.currentPage - 1) * this.pageSize
        const end = this.pageSize * this.currentPage
        this.dispatchEvent(new CustomEvent('update', {
            detail: {
                start,
                end
            }
        }))
    }

    get disablePrevious() {
        return this.currentPage <= 1
    }
    get disableNext() {
        return this.currentPage >= this.totalPage
    }
}
