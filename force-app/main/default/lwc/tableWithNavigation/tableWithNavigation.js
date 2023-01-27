import NAME_FIELD from '@salesforce/schema/Product2.Name'
import { getFieldValue } from 'lightning/uiRecordApi';
import { LightningElement, track, api } from 'lwc';


export default class TableWithNavigation extends LightningElement {
    @api 
    set totalData(data){
        this.totalDataLocal = data;
        this.navUpdateHandler({detail:{
            start : this.start,
            end : this.end
        }});
    }
    get totalData(){
        return this.totalDataLocal
    }
    @api columns
    @api hideCheckboxes = false
    @api rows = 10
    @api showSearch = false
    @api showRowNumberColumn = false
    @api hidePagination = false;
    
    @track totalDataLocal = []
    @track sortBy
    @track sortDirection

    draftValues = []
    start = 0
    end = this.rows
    visibleData = []

    handleRowAction(event){
        this.dispatchEvent(new CustomEvent('rowaction', {
            detail : event.detail
        }))
    }

    handleSave(event){
        this.dispatchEvent(new CustomEvent('save', {
            detail : {
                draftValues : event.detail.draftValues
            }
        }))
        this.draftValues = []
    }

    navUpdateHandler(event) {
        this.start = event.detail.start;
        this.end = event.detail.end;
        this.visibleData = this.totalData.slice(this.start, this.end);
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.visibleData));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1 : -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.visibleData = parseData;
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
        if (searchKey) {
            this.hidePagination = true;
            this.visibleData = this.totalData
            if (this.totalData) {
                let searchRecords = [];
                for (let record of this.totalData) {
                    let strVal = getFieldValue(record, NAME_FIELD).Name;
                    console.log(JSON.stringify(record.Name));
                    if (strVal) {
                        if (strVal.toLowerCase().includes(searchKey)) {
                            searchRecords.push(record);
                        }
                    }
                }
                this.visibleData = searchRecords;
            }
        } else {
            this.hidePagination = false;
            this.visibleData = this.totalData.slice(0,10);
        }
    }
    rowsSelected(event){
        this.dispatchEvent(new CustomEvent('rowselected',{
            detail:{
                selectedRows : event.detail.selectedRows
            }
        }));
    }

    get dataLength() {
        return this.totalData.length;
    }
}


