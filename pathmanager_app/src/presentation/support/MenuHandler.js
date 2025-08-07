import { h } from "vue";
import { UserOutlined, BookOutlined, CrownOutlined, BugOutlined } from "@ant-design/icons-vue";

const enemiesKey = "enemies";
const spellsKey = "spells";
const itemsKey = "items";
const charactersKey = "characters";

const charactersOption = {
  key: charactersKey,
  icon: () => h(UserOutlined),
  label: "Personajes",
  title: "Personajes",
};

const enemiesOption = {
  key: enemiesKey,
  icon: () => h(BugOutlined),
  label: "Enemigos",
  title: "Enemigos",
};

const spellsOption = {
  key: spellsKey,
  icon: () => h(BookOutlined),
  label: "Hechizos",
  title: "Hechizos",
};
const itemsOption = {
  key: itemsKey,
  icon: () => h(CrownOutlined),
  label: "Items",
  title: "Items",
};

export const getBaseMenu = (rank, router) => {
  charactersOption.onclick = () => router.push('/personajes');
  enemiesOption.onclick = () => router.push('/');
  spellsOption.onclick = () => router.push('/hechizos');
  itemsOption.onclick = () => router.push('/items');
  if(rank == 1) return {
    menu:[enemiesOption, charactersOption, spellsOption, itemsOption],
    selection: enemiesKey
  };
  else return {
    menu:[charactersOption, spellsOption, itemsOption],
    selection: spellsKey
  };
}