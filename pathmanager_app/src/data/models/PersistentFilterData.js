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
    getEntryById(id){
        for(let i = 0; i < this.data.length; i++){
            const entry = this.data[i];
            if(entry.id == id) return entry;
        }
        return null;
    }
}