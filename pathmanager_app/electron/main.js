import { app, BrowserWindow, ipcMain } from "electron";
import sqlite3 from "sqlite3";
//const sqlite3 = require('sqlite3').verbose()
import { join } from "path";

const dirname = "";
let db;

ipcMain.handle("db-connect", (event, dbPath) => {
  db = new sqlite3.Database(path.resolve(__dirname, dbPath));
  return "Connected";
});

ipcMain.handle("db-query", async (event, query, params) => {
  return new Promise((resolve, reject) => {
    db.all(query, params, (err, rows) => {
      if (err) reject(err);
      else resolve(rows);
    });
  });
});

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: join(dirname, "../preload.js"),
      nodeIntegration: true,
      contextIsolation: false,
    },
  });

  if (process.env.VITE_DEV_SERVER_URL) {
    win.loadURL(process.env.VITE_DEV_SERVER_URL);
    win.webContents.openDevTools();
  } else {
    win.loadFile(join(dirname, "../dist/index.html"));
  }
};

app.whenReady().then(() => {
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
