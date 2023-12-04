--- Given a certain type (ie. 'fire'), list all of the pokemon that have a weakness to that type. 
--- Takes into consideration the dual typing of pokemon. (ie. ice is weak to fire, and dragon is not. So a dragon/ice pokemon is neutral against fire)

SELECT p.p_name
FROM pokemon p
JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against AND tc1.tc_type = 'fire'
LEFT JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against AND tc2.tc_type = 'fire'
WHERE (tc1.tc_effectiveness > 1 AND (p.p_type2 IS NULL OR tc2.tc_effectiveness >= 1))
   OR (p.p_type2 IS NOT NULL AND tc1.tc_effectiveness >= 1 AND tc2.tc_effectiveness > 1)
GROUP BY p.p_name;

/*
-- MODIFIED VERSION: Gets the name of a given pokemon and finds the same result. 
SELECT p.p_name
FROM pokemon p
JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against
LEFT JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against
WHERE (tc1.tc_type = (SELECT p_type1 FROM pokemon WHERE p_name = 'Charmander') AND tc1.tc_effectiveness > 1)
  AND (p.p_type2 IS NULL OR tc2.tc_type = (SELECT p_type1 FROM pokemon WHERE p_name = 'Charmander') AND tc2.tc_effectiveness >= 1)
GROUP BY p.p_name;
*/

