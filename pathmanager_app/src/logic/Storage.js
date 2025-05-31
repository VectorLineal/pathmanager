import { reactive } from "vue";
import PersistentFilterData from "../data/models/PersistentFilterData";

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