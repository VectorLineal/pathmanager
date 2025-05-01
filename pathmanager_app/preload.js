import { contextBridge, ipcRenderer } from "electron";

contextBridge.exposeInMainWorld("electronAPI", {
  dbQuery: (query, params) => ipcRenderer.invoke("db-query", query, params),
  dbConnect: (path) => ipcRenderer.invoke("db-connect", path),
});