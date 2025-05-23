import { app, BrowserWindow, ipcMain } from "electron";
import sqlite3 from "sqlite3";
import { join, resolve, dirname } from "path";
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename);

let db;

ipcMain.handle("db-connect", (event, dbPath) => {
  const absolutePath = resolve(__dirname, dbPath);
  db = new sqlite3.Database(absolutePath);
  console.log("DB path:", absolutePath);
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

const getIconPath = () => {
  if (process.platform === 'win32') {
    return join(__dirname, '../public/icons/icon.ico')
  } else if (process.platform === 'darwin') {
    return join(__dirname, '../public/icons/icon.icns')
  } else {
    return join(__dirname, '../public/icons/icon.png')
  }
}

const createWindow = () => {
  const preload = join(__dirname, "../preload.js");
  console.log("preload path", preload)
  const win = new BrowserWindow({
    icon: getIconPath(),
    width: 800,
    height: 600,
    webPreferences: {
      preload,
      nodeIntegration: true,
      contextIsolation: true,
      nodeIntegration: false
    },
  });

  if (process.env.VITE_DEV_SERVER_URL) {
    win.loadURL(process.env.VITE_DEV_SERVER_URL);
    win.webContents.openDevTools();
  } else {
    const indexPath = join(__dirname, "../dist/index.html");
    console.log("index path", indexPath);
    win.loadFile(indexPath);
  }
};

app.whenReady().then(() => {
  createWindow();
  console.log("created window");
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
