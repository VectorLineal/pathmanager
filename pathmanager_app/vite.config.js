import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import Components from 'unplugin-vue-components/vite';
import { AntDesignVueResolver } from 'unplugin-vue-components/resolvers';
import electron from 'vite-plugin-electron';
import renderer from 'vite-plugin-electron-renderer';

export default defineConfig({
  build: {
    assetsInclude: ['**/*.ico', '**/*.icns', '**/*.png']
  },
  plugins: [
    vue(),
    Components({
      resolvers: [
        AntDesignVueResolver({
          importStyle: false, // css in js
        }),
      ],
    }),
    electron([
      {
        entry: 'electron/main.js',
        onstart(options) {
          options.startup()
        }
      },
    ]),
    renderer({
      nodeIntegration: false,
    }),
  ],
});