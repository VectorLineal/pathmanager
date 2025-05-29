import glosaryDatabase from "../data/services/DBPool";
import { getAbilitiesByRace } from "./AbilityOperations";
import { getInmunitiesByRace } from "./InmunityOperations";
import { getResWeakByRace } from "./ResistanceOperations";
import { getSensesByRace } from "./SenseOperations";
import { getLanguagesByRace } from "./LanguageOperations";
import { getSpeedsByRace } from "./MovementOperations";

const racesQuery = `
select Raza.id, Raza.nombre, Rareza.nombre AS rareza
from Raza join Rareza on Raza.rarezaId = Rareza.id
ORDER BY Raza.nombre;
`;

const playableRacesQuery = `
select Raza.id, Raza.nombre, Rareza.nombre AS rareza
from Raza join Rareza on Raza.rarezaId = Rareza.id
where Raza.id >= 14;
`;

const singleRaceQuery = `
select tamanoId, fuerza, destreza, constitucion, inteligencia, sabiduria, carisma, salud
from Raza
where id = ?;
`;

export async function getAllRaces() {
  try {
    return await glosaryDatabase.query(racesQuery);
  } catch (err) {
    console.error("error on load all races:", err);
  }
}

export async function getPlayableRaces() {
  try {
    return await glosaryDatabase.query(playableRacesQuery);
  } catch (err) {
    console.error("error on load playable races:", err);
  }
}

export async function getRaceById(id) {
  try {
    const rQuery = await glosaryDatabase.query(singleRaceQuery, [id]);
    const race = rQuery[0];
    const abilities = await getAbilitiesByRace(id);
    race.habilidades = abilities;
    const inmunities = await getInmunitiesByRace(id);
    race.inmunidades = inmunities;
    const resistances = await getResWeakByRace(id);
    race.resistencias = resistances;
    const senses = await getSensesByRace(id);
    race.sentidos = senses;
    const languages = await getLanguagesByRace(id);
    race.lenguages = languages;
    const movements = await getSpeedsByRace(id);
    race.velocidades = movements;

    return race;
  } catch (err) {
    console.error("error on load single race:", err);
    return null;
  }
}