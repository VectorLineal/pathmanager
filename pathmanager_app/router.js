import { createMemoryHistory, createRouter } from 'vue-router';

import Bestiary from './src/presentation/views/Bestiary.vue'

const routes = [
  { path: '/', component: Bestiary },
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
})