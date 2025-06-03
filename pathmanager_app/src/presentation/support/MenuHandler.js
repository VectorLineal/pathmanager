import { h } from "vue";
import { UserOutlined, BookOutlined } from "@ant-design/icons-vue";

const enemiesKey = "enemies";
const spellsKey = "spells";

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

export const getBaseMenu = (rank, router) => {
  enemiesOption.onclick = () => router.push('/');
  spellsOption.onclick = () => router.push('/hechizos');
  if(rank == 1) return {
    menu:[enemiesOption, spellsOption],
    selection: enemiesKey
  };
  else return {
    menu:[spellsOption],
    selection: spellsKey
  };
}