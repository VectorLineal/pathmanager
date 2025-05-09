export default class PersistentFilterData{
    constructor(){
        this.data = [];
        this.dataFilter = [];
        this.dataSelector = [];
    }
    isEmpty(){
        return this.data.length <= 0;
    }
    fillData(input){
        this.data = input;
        input.forEach(element => {
            this.dataFilter.push({text: element.nombre, value: element.nombre});
            this.dataSelector.push({label: element.nombre, value: element.id});
        });
    }
}