export default class SkillAttributeManager {
    constructor(anySkill, anyAttribute, baseAttributes = [], baseSkills = []){ //arreglos Array<Number>
        this.skillCodes = baseSkills;//nivel 7: a experto, 15: a legendario
        this.attributeCodes = baseAttributes;
        this.spentSkills = []; //{spent, chosen}
        this.spentAttributes = []; //{spent, chosen}
        this.anyAttribute = anyAttribute;
        this.anySkill = anySkill;
    }
    getLeftSkillPoints(){
        return this.skillCodes.length + this.anySkill;
    }
    getLeftAttributePoints(){
        return this.attributeCodes.length + this.anyAttribute;
    }
    searchValue(element, isAttribute){
        const curArray = isAttribute? this.attributeCodes: this.skillCodes;
        for(let i = 0; i < curArray.length; i++){
            //el arreglo se compone de arreglos de números de opciones de atributos escogibles
            for(let j = 0; j < curArray[i].length; j++){
                if(curArray[i][j] == element) return i;
            }
        }
        return -1;
    }
    searchRemovedValue(element, isAttribute){
        const curArray = isAttribute? this.spentAttributes: this.spentSkills;
        for(let i = 0; i < curArray.length; i++){
            const spentOptions = curArray[i].spent;
            const chosenOption = curArray[i].chosen;
            if(spentOptions.length == 0 && chosenOption == element) return i;
            else if(spentOptions.length > 0){
                for(let j = 0; j < spentOptions.length; j++){
                    if(spentOptions[j] == element && chosenOption == element) return i;
                }
            }
        }
        return -1;
    }
    usePoint(attribute, isAttribute){ //(pendiente) en un solo incrmeento no se peuden incrementar 2 atributos iguales usando puntos que suben cualquier habilidad
        if(isAttribute && this.getLeftAttributePoints() <= 0) return false;
        else if(!isAttribute && this.getLeftSkillPoints() <= 0) return false;

        const sIndex = this.searchValue(attribute, isAttribute);
        if(sIndex >= 0){
            if(isAttribute){  
                const removed = this.attributeCodes.splice(sIndex, 1);
                this.spentAttributes.push({spent: removed[0], chosen: attribute});
            }else{
                const removed = this.skillCodes.splice(sIndex, 1);
                this.spentSkills.push({spent: removed[0], chosen: attribute});
            }
            return true;
        }else {
            if(isAttribute && this.anyAttribute > 0){
                this.spentAttributes.push({spent: [], chosen: attribute});
                this.anyAttribute--;
                return true;
            }else if(!isAttribute && this.anySkill > 0){
                this.spentSkills.push({spent: [], chosen: attribute});
                this.anySkill--;
                return true;
            }
        }
        return false;
    }
    recoverPoint(attribute, isAttribute){
        if(isAttribute && this.spentAttributes.length <= 0) return false;
        else if(!isAttribute && this.spentSkills.length <= 0) return false;

        const sIndex = this.searchRemovedValue(attribute, isAttribute);
        if(sIndex >= 0){
            if(isAttribute){  
                const removed = this.spentAttributes.splice(sIndex, 1);
                const removedOption = removed[0];
                if(removedOption.spent.length <= 0) this.anyAttribute++;
                else this.attributeCodes.push(removedOption);
            }else{
                const removed = this.spentSkills.splice(sIndex, 1);
                const removedOption = removed[0];
                if(removedOption.spent.length <= 0) this.anySkill++;
                else this.skillCodes.push(removedOption);
            }
            return true;
        }else return false;
    }
}