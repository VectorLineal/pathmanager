import { createMemoryHistory, createRouter } from 'vue-router';
import Bestiary from './src/presentation/views/Bestiary.vue';
import Entity from './src/presentation/views/Entity.vue';

const routes = [
  { path: '/', component: Bestiary },
  { path: '/enemigo/:id', component: Entity },
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
})