import { createMemoryHistory, createRouter } from 'vue-router';
import Bestiary from './src/presentation/views/Bestiary.vue';
import Entity from './src/presentation/views/Entity.vue';
import EntityCreate from './src/presentation/views/EntityCreate.vue';

const routes = [
  { path: '/', component: Bestiary },
  { path: '/enemigo/:id', component: Entity, props: true },
  { path: '/enemigoCrear', component: EntityCreate },
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
})