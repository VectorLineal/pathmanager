export default class GlosaryDatabase {
  constructor() {
    this.isElectron = window.electronAPI?.isElectron || false
  }

  async connect(dbPath) {
    if (!this.isElectron) {
      console.warn('Not running in Electron environment - using mock data')
      return
    }
    
    try {
      await window.electronAPI.db.connect(dbPath)
    } catch (err) {
      console.error('Database connection failed:', err)
      throw err
    }
  }

  async query(sql, params = []) {
    if (!this.isElectron) {
      console.warn('Not running in Electron environment - returning mock data');
      return null;
    }

    try {
      return await window.electronAPI.db.query(sql, params)
    } catch (err) {
      console.error('Database query failed:', err)
      throw err
    }
  }

  async create(sql, params = []) {
    if (!this.isElectron) {
      console.warn('Not running in Electron environment - returning mock data');
      return null;
    }

    try {
      return await window.electronAPI.db.create(sql, params)
    } catch (err) {
      console.error('Database insertion failed:', err)
      throw err
    }
  }
}