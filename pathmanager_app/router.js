import { createMemoryHistory, createRouter } from 'vue-router';
import Bestiary from './src/presentation/views/Bestiary.vue';
import Entity from './src/presentation/views/Entity.vue';
import EntityCreate from './src/presentation/views/EntityCreate.vue';
import Spells from './src/presentation/views/Spells.vue';
import Items from './src/presentation/views/Items.vue';
import CharacterCreate from './src/presentation/views/CharacterCreate.vue';
import CharacterManager from './src/presentation/views/CharacterManager.vue';

const routes = [
  { path: '/', component: Bestiary },
  { path: '/enemigo/:id', component: Entity, props: true },
  { path: '/enemigoCrear', component: EntityCreate },
  { path: '/hechizos', component: Spells },
  { path: '/items', component: Items },
  { path: '/personajes', component: CharacterManager },
  { path: '/personajeCrear', component: CharacterCreate },
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
})