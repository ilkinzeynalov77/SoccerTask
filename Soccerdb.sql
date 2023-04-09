use SOCCER_DB

--AVRO kuboku 2016-n?n final matç?n?n harada keçirildiyini öyr?nm?k üçün SQL sor?usu yaz?n.Yerin ad? v? ??h?ri qaytar?n.
--?stifad? edil?c?k c?dv?ll?r : soccer_venue, soccer_city,  match_mast
SELECT sv.venue_name,MAX(match_mast.play_date) as 'Final',sc.city
FROM match_mast
JOIN soccer_venue sv ON match_mast.venue_id = sv.venue_id
JOIN Soccer_city sc ON sv.city_id = sc.city_id
WHERE match_mast.ID = 51
GROUP BY sv.venue_name,sc.city,match_mast.play_date

/*A?a??dak? c?dv?ll?rd?n normal oyun zaman? h?r bir komandan?n 
h?r matçda vurdu?u qollar?n say?n? tapmaq üçün SQL sor?usu yaz?n.
Matç nömr?sini, ölk? ad?n? v? qol hesab?n? qaytar?n. 
?stifad? edil?c?k c?dv?ll?r : match_details, soccer_country*/
SELECT md.match_no,sc.country_name,COUNT(md.goal_score)
FROM match_details md
JOIN [Soccer Country] sc ON md.ID = sc.ID
JOIN match_mast as m ON m.match_no = md.match_no
WHERE m.play_stage  = 'F'



