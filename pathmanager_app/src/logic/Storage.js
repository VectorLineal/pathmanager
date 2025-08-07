import { reactive } from "vue";
import PersistentFilterData from "../data/models/PersistentFilterData";

export const loginStorage = reactive({
    userId: 4,
    profileId: 1,
    username: 'Nobza',
    setData(data){
        this.userId = data.id;
        this.profileId = data.nombre;
        this.username = data.permiso;
    },
    reset(){
        this.userId = -1;
        this.profileId = -1;
        this.username = '';
    },
    isLogged(){
        return this.userId > 0 && this.profileId > 0;
    }
});
export const alignmentsStorage = reactive( new PersistentFilterData());
export const sizesStorage = reactive( new PersistentFilterData());
export const racesStorage = reactive( new PersistentFilterData());
export const classesStorage = reactive( new PersistentFilterData());
export const languagesStorage = reactive( new PersistentFilterData());
export const statusChangesStorage = reactive( new PersistentFilterData());
export const movementsStorage = reactive( new PersistentFilterData());
export const traitsStorage = reactive( new PersistentFilterData());
export const damageTypesStorage = reactive( new PersistentFilterData());
export const sensesStorage = reactive( new PersistentFilterData());
export const weaponTypesStorage = reactive( new PersistentFilterData());
export const weaponGroupsStorage = reactive( new PersistentFilterData());
export const weaponCategoriesStorage = reactive( new PersistentFilterData());
export const spellTraditionsStorage = reactive( new PersistentFilterData());
export const spellTargetsStorage = reactive( new PersistentFilterData());
export const spellSchoolsStorage = reactive( new PersistentFilterData());
export const attributesStorage = reactive( new PersistentFilterData());
export const itemTypesStorage = reactive( new PersistentFilterData());
export const deitiesStorage = reactive( new PersistentFilterData());