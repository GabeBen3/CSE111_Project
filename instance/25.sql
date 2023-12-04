--- List out all of the possible types in alphabetical order and there effectiveness on a given pokemon
--- Takes into account dual types of a pokemon and will list effectiveness accordingly (ie. grass | 4.0 for swampert[ground, water])
SELECT tc_type, MAX(tc_effectiveness) * MIN(tc_effectiveness) AS effectiveness_multiplier
    FROM (
        SELECT tc1.tc_type, tc1.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc1 ON p.p_type1 = tc1.tc_type_against
        WHERE p.p_name = ?
        UNION ALL

        SELECT tc2.tc_type, tc2.tc_effectiveness
        FROM pokemon p
        JOIN typeChart tc2 ON p.p_type2 = tc2.tc_type_against
        WHERE p.p_name = ?
    ) AS combined
    GROUP BY tc_type
    HAVING MAX(tc_effectiveness) * MIN(tc_effectiveness) >= 0;