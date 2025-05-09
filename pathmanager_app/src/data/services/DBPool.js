import GlosaryDatabase from "./GlosaryDatabase";

const glosaryDatabase = new GlosaryDatabase();
await glosaryDatabase.connect(import.meta.env.VITE_DB_PATH);

export default glosaryDatabase;