-- SELECT t_name 
-- FROM trainers
-- WHERE t_region = 'Kanto';

SELECT pa_ability1, pa_ability2, pa_hidden_ability 
FROM pokemon_to_abilities
WHERE pa_pokemon == 'Charmander';