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
SELECT md.match_no,sc.country_name,md.goal_score
FROM match_details md
JOIN [Soccer Country] sc 
ON
md.team_id = sc.country_id
WHERE decided_by = 'N'
ORDER BY md.match_no

--Hər bir ölkənin aldığı sarı kartların sayını hesablayan SQL sorğusu yazın.
--Ölkənin adını və sarı vərəqələrin sayını qaytarın. Əgər heç bir sarı kart alan yoxdursa null gəlsin.
--İstifadə ediləcək cədvəllər : soccer_country, player_booked
SELECT [Soccer Country].country_name,COUNT(*) as 'Yellow card'
FROM [Soccer Country]
JOIN player_booked
ON [Soccer Country].country_id = player_booked.team_id
GROUP BY [Soccer Country].country_name 

/*
SELECT distinct [Soccer Country].country_name,player_booked.team_id
from player_booked
inner join [Soccer Country] on [Soccer Country].country_id = player_booked.team_id
*/

/* Kubok uğrunda oyunlarda kimin ən çox qol vurduğunu öyrənmək üçün SQL sorğusu yazın.
Oyunçu adını, ölkə adını və ən yüksək fərdi qol vuran oyunçunu qaytarın.
İstifadə ediləcək cədvəllər : goal_details, soccer_country, player_mast*/
SELECT pm.player_name,COUNT(*) as 'Goal',sc.country_name
FROM goal_details a
JOIN player_mast pm ON a.player_id = pm.player_id
JOIN [Soccer Country] sc ON a.team_id = sc.country_id
WHERE goal_schedule = 'NT'
GROUP BY pm.player_name,sc.country_name
ORDER BY count(*) DESC;



--2016-cı il Avrokubokunun finalında kimin qol vurduğunu öyrənmək üçün aşağıdakı cədvəldən SQL sorğusu yazın.
--Oyunçu adını, formanın nömrəsini və ölkə adını qaytarın. İstifadə ediləcək cədvəllər : goal_details, soccer_country, player_mast
SELECT pm.player_name,pm.jersey_no,sc.country_name,
gd.play_stage,gd.goal_schedule,gd.goal_half
FROM player_mast pm
JOIN [Soccer Country] sc ON pm.team_id = sc.country_id
JOIN goal_details gd ON gd.player_id = pm.player_id
WHERE gd.play_stage = 'F'

--Açılış matçını idarə edən hakimi tapmaq üçün SQL sorğusu yazın. Hakim adını, ölkə adını qaytarın
-- İstifadə ediləcək cədvəllər : referee_mast, soccer_country, match_mast
SELECT rm.referee_name,[Soccer Country].country_name,[Soccer Country].country_id
FROM match_mast m
JOIN  referee_mast rm ON m.referee_id = rm.referee_id
JOIN [Soccer Country] ON rm.country_id = [Soccer Country].country_id
WHERE m.match_no = 1


--AVRO kuboku 2016-nın açılış matçının keçirildiyi şəhəri tapmaq üçün SQL sorğusu yazın. 
--Yerin adı, şəhəri qaytarın. İstifadə ediləcək cədvəllər : soccer_venue, soccer_city, match_mast
SELECT sv.venue_name,sc.city
FROM soccer_venue sv
JOIN Soccer_city sc ON sv.city_id = sc.city_id
JOIN match_mast m ON sv.venue_id = m.venue_id
WHERE m.match_no = 1 



