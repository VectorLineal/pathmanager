export default {
  async connect(dbPath) {
    if (window.electronAPI) {
      await window.electronAPI.dbConnect(dbPath);
    } else {
      console.warn("Not running in Electron environment");
    }
  },

  async query(sql, params = []) {
    if (window.electronAPI) {
      return await window.electronAPI.dbQuery(sql, params);
    }
    console.warn("Not running in Electron environment");
    return [];
  },
};
