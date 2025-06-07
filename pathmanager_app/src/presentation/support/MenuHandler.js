import { h } from "vue";
import { UserOutlined, BookOutlined, CrownOutlined } from "@ant-design/icons-vue";

const enemiesKey = "enemies";
const spellsKey = "spells";
const itemsKey = "items";

const enemiesOption = {
  key: enemiesKey,
  icon: () => h(UserOutlined),
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
  enemiesOption.onclick = () => router.push('/');
  spellsOption.onclick = () => router.push('/hechizos');
  itemsOption.onclick = () => router.push('/items');
  if(rank == 1) return {
    menu:[enemiesOption, spellsOption, itemsOption],
    selection: enemiesKey
  };
  else return {
    menu:[spellsOption, itemsOption],
    selection: spellsKey
  };
}