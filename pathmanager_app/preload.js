const { contextBridge, ipcRenderer } = require('electron');

// Create a safe, typed bridge to the main process
contextBridge.exposeInMainWorld('electronAPI', {
  db: {
    connect: (path) => ipcRenderer.invoke('db-connect', path),
    query: (sql, params) => ipcRenderer.invoke('db-query', sql, params),
    close: () => ipcRenderer.invoke('db-close')
  },
  isElectron: true
});