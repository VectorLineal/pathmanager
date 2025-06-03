import { createMemoryHistory, createRouter } from 'vue-router';
import Bestiary from './src/presentation/views/Bestiary.vue';
import Entity from './src/presentation/views/Entity.vue';
import EntityCreate from './src/presentation/views/EntityCreate.vue';
import Spells from './src/presentation/views/Spells.vue';

const routes = [
  { path: '/', component: Bestiary },
  { path: '/enemigo/:id', component: Entity, props: true },
  { path: '/enemigoCrear', component: EntityCreate },
  { path: '/hechizos', component: Spells },
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
})