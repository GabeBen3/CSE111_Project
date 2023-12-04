/*
-- Selecting types strong against Grass
SELECT DISTINCT tc1.tc_type
FROM pokemon p
JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against
WHERE p.p_name = 'Bulbasaur' AND tc1.tc_effectiveness = 2

UNION

-- Selecting types strong against Poison
SELECT DISTINCT tc2.tc_type
FROM pokemon p
JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against
WHERE p.p_name = 'Bulbasaur' AND tc2.tc_effectiveness = 2;
*/

/*
GOOD!
SELECT tc_type
FROM (
    SELECT tc_type, MAX(tc_effectiveness) as max_effectiveness, MIN(tc_effectiveness) as min_effectiveness
    FROM (
        SELECT tc1.tc_type, tc1.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against
        WHERE p.p_name = 'Charmander'

        UNION ALL

        SELECT tc2.tc_type, tc2.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against
        WHERE p.p_name = 'Charmander'
    ) AS combined
    GROUP BY tc_type
) AS effectiveness
WHERE max_effectiveness > 1 AND min_effectiveness >= 1;
*/

/*
SELECT tc_type, max_effectiveness * min_effectiveness AS effectiveness_multiplier
FROM (
    SELECT tc_type, MAX(tc_effectiveness) as max_effectiveness, MIN(tc_effectiveness) as min_effectiveness
    FROM (
        SELECT tc1.tc_type, tc1.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against
        WHERE p.p_name = 'Bulbasaur' -- Replace 'Bulbasaur' with the desired Pokemon name

        UNION ALL

        SELECT tc2.tc_type, tc2.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against
        WHERE p.p_name = 'Bulbasaur' -- Replace 'Bulbasaur' with the desired Pokemon name
    ) AS combined
    GROUP BY tc_type
) AS effectiveness
WHERE max_effectiveness > 1 AND min_effectiveness >= 1;
*/


/*
SELECT p.p_name
FROM pokemon p
JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against AND tc1.tc_type = 'fire'
WHERE tc1.tc_effectiveness > 1;
*/


SELECT p.p_name
FROM pokemon p
JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against AND tc1.tc_type = (SELECT p_type2 FROM pokemon WHERE p_name = 'Charmander')
LEFT JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against AND tc2.tc_type = (SELECT p_type2 FROM pokemon WHERE p_name = 'Charmander')
WHERE (tc1.tc_effectiveness > 1 AND (p.p_type2 IS NULL OR (tc2.tc_effectiveness IS NULL OR tc2.tc_effectiveness >= 1)))
   OR (p.p_type2 IS NOT NULL AND tc2.tc_effectiveness > 1 AND tc1.tc_effectiveness >= 1)
GROUP BY p.p_name;




















