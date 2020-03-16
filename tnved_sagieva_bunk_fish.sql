--difference
select a.country,summa,total,summa/total*100 diff from 
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll::numeric)/1000 summa
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name <> 'Итого'
group by country) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll::numeric)/1000 total
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name = 'Итого'
group by country) b
on a.country=b.country
order by diff desc
--
--difference im 2018
select a.country,summa,total,summa/total*100 diff from 
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
from import_bunk_18
where --st_rub <> '-' or 
	code_name <> 'Итого'
group by country) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from import_bunk_18
where 
	code_name = 'Итого'
group by country) b
on a.country=b.country
order by diff desc
--

--difference ex 2017
select a.﻿year,a.country,summa,total,summa/total*100 diff from 
(select 
	﻿year,
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
from export_bunk_17_18
where --st_rub <> '-' or 
	code_name <> 'Итого' and ﻿year = '2017'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_bunk_17_18
where 
	code_name = 'Итого' and ﻿year = '2017'
group by ﻿year,country) b
on a.country=b.country
order by ﻿year,diff desc
--
--difference ex 2018
select a.﻿year,a.country,summa,total,summa/total*100 diff from 
(select 
	﻿year,
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
from export_bunk_17_18
where --st_rub <> '-' or 
	code_name <> 'Итого' and ﻿year = '2018'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_bunk_17_18
where 
	code_name = 'Итого' and ﻿year = '2018'
group by ﻿year,country) b
on a.country=b.country
order by ﻿year,diff desc

--select sum(st_doll_mln::numeric)
--from export_bunk_17_18
--where code_name <> 'Итого' and ﻿year = '2018' and country not in ('Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')	
select sum(added_sum)
from _1_export18_bunc_added_sum
where year = '2018' and country not in ('Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')

select sum(summa),sum(total),sum(minus)
from export18_bunc_minus
where country not in ('Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')
--

--difference fish ex 2017
select a.﻿year,a.country,summa,total,summa/total*100 diff from 
(select 
	﻿year,
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
from export_fish_17
where --st_rub <> '-' or 
	code_name <> 'Итого'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_fish_17
where 
	code_name = 'Итого' 
group by ﻿year,country) b
on a.country=b.country
order by ﻿year,diff desc
--

--difference fish ex 2018
select a.﻿year,a.country,summa,total,summa/total*100 diff from 
(select 
	﻿year,
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
from export_fish_18
where --st_rub <> '-' or 
	code_name <> 'Итого'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_fish_18
where 
	code_name = 'Итого' 
group by ﻿year,country) b
on a.country=b.country
order by ﻿year,diff desc
--

--
--import bunk 17
create materialized view stat_customs.import17_bunc_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll::numeric)/1000 summa
	, max(st_doll::numeric/1000) max_gr
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name <> 'Итого'
group by country) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll::numeric)/1000 total
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name = 'Итого'
group by country) b
on a.country=b.country
order by minus desc


--select * from import17_bunc_minus
--drop materialized view import17_bunc_minus
--

--im bunk 18
--drop materialized view stat_customs.import18_bunc_minus
create materialized view stat_customs.import18_bunc_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_gr
from import_bunk_18
where 
	code_name <> 'Итого'
group by country) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from import_bunk_18
where 
	code_name = 'Итого'
group by country) b
on a.country=b.country
order by minus desc
--

--ex bunk 17
create materialized view stat_customs.export17_bunc_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_gr
from export_bunk_17_18
where 
	code_name <> 'Итого' and ﻿year = '2017'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_bunk_17_18
where 
	code_name = 'Итого' and ﻿year = '2017'
group by ﻿year,country) b
on a.country=b.country
order by minus desc
--

--ex bunk 18
create materialized view stat_customs.export18_bunc_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_gr
from export_bunk_17_18
where 
	code_name <> 'Итого' and ﻿year = '2018'
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_bunk_17_18
where 
	code_name = 'Итого' and ﻿year = '2018'
group by ﻿year,country) b
on a.country=b.country
order by minus desc
--


--ex fish 17
create materialized view stat_customs.export17_fish_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_gr
from export_fish_17
where 
	code_name <> 'Итого' 
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_fish_17
where 
	code_name = 'Итого' 
group by ﻿year,country) b
on a.country=b.country
order by minus desc
--


--ex fish 18
create materialized view stat_customs.export18_fish_minus as
select a.country,summa,total,total-summa minus,max_gr from 
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_gr
from export_fish_18
where 
	code_name <> 'Итого' 
group by ﻿year,country) a
join
(select 
	﻿year,country
	--, sum(st_rub::numeric)
	, sum(st_doll_mln::numeric) total
from export_fish_18
where 
	code_name = 'Итого' 
group by ﻿year,country) b
on a.country=b.country
order by minus desc
--



--select * from import18_bunc_minus
--drop materialized view import18_bunc_minus

--im bunk 17
create materialized view stat_customs._1_import17_bunc_added_sum as
select '2017' as year,a.country, "﻿code_6"--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	--, sum(st_rub::numeric)
	, ﻿code_6
	, sum(st_doll::numeric)/1000 summa
	, max(st_doll::numeric/1000) max_sum
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name <> 'Итого'
group by country,﻿code_6) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, minus
	, max_gr
from import17_bunc_minus
) b
on a.country=b.country
--group by a.country, "﻿code_6",minus
order by country
--

--im bunk 18
create materialized view stat_customs._1_import18_bunc_added_sum as
select '2018' as year,a.country, "﻿code_6"--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	--, sum(st_rub::numeric)
	, ﻿code_6
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_sum
from import_bunk_18
where 
	code_name <> 'Итого'
group by country,﻿code_6) a
join
(select 
	country
	, minus
	, max_gr
from import18_bunc_minus
) b
on a.country=b.country
--group by a.country, "﻿code_6",minus
order by country
--
--drop materialized view stat_customs._1_import18_bunc_added_sum


--ex bunk 17
create materialized view stat_customs._1_export17_bunc_added_sum as
select '2017' as year,a.country, code_6--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	--, sum(st_rub::numeric)
	, code_6
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_sum
from export_bunk_17_18
where 	
	code_name <> 'Итого' and ﻿year = '2017'
group by ﻿year,country,code_6) a
join
(select 
	country
	--, sum(st_rub::numeric)
	, minus
	, max_gr
from export17_bunc_minus
) b
on a.country=b.country
--group by a.country, "﻿code_6",minus
order by country
--
--ex bunk 18
create materialized view stat_customs._1_export18_bunc_added_sum as
select '2018' as year,a.country, code_6--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	, code_6
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_sum
from export_bunk_17_18
where 	
	code_name <> 'Итого' and ﻿year = '2018'
group by ﻿year,country,code_6) a
join
(select 
	country
	, minus
	, max_gr
from export18_bunc_minus
) b
on a.country=b.country
order by country
--
drop materialized view stat_customs._1_export18_bunc_added_sum
--

--ex fish 17
create materialized view stat_customs._1_export17_fish_added_sum as
select '2017' as year,a.country, code_6--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	, code_6
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_sum
from export_fish_17
where 	
	code_name <> 'Итого' 
group by ﻿year,country,code_6) a
join
(select 
	country
	, minus
	, max_gr
from export17_fish_minus
) b
on a.country=b.country
order by country
--

--ex fish 18
create materialized view stat_customs._1_export18_fish_added_sum as
select '2018' as year,a.country, code_6--,summa,minus,max_sum,max_gr
	,case when max_sum=max_gr then summa+minus else summa end as added_sum
from 
(select 
	country
	, code_6
	, sum(st_doll_mln::numeric) summa
	, max(st_doll_mln::numeric) max_sum
from export_fish_18
where 	
	code_name <> 'Итого' 
group by ﻿year,country,code_6) a
join
(select 
	country
	, minus
	, max_gr
from export18_fish_minus
) b
on a.country=b.country
order by country
--



select * from _1_import17_bunc_added_sum 
where country in (select country from _1_import17_bunc_added_sum) 
drop materialized view stat_customs._1_import17_bunc_added_sum

select country,max(st_doll::numeric/1000)
from import_bunk_17
where --st_rub <> '-' or 
	st_doll <> '-' and 
	code_name <> 'Итого'
group by country--, "﻿code_6"

--update import_bunk_17
--select st_rub, replace(st_rub,'-','')
--from import_bunk_17
--set st_rub = replace(st_rub,'-',null)


--export bunk+fish
create materialized view _2_export_bunk_fish_17_18 as
select --distinct country 
	year,country, code_6 as tnved, added_sum as stoim
from (
	select 'bunk' kind,* 
	from _1_export17_bunc_added_sum
	union all
	select 'bunk' kind,* 
	from _1_export18_bunc_added_sum
	union all
	select 'fish' kind,* 
	from _1_export17_fish_added_sum
	union all
	select 'fish' kind,* 
	from _1_export18_fish_added_sum	
	) x
where country not in ('Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')	
--group by year,country, code_6
select count(*) 
from _2_export_bunk_fish_17_18
where length(tnved) = 6
--order by country	

--import bunk (no fish)
select --distinct country 
	kind,year,x.﻿code_6 as tnved
	--*
from (
	select 'bunk' kind,* 
	from _1_import17_bunc_added_sum
	union all
	select 'bunk' kind,* 
	from _1_import18_bunc_added_sum
	) x
where country not in ('ВСЕГО','ДРУГИЕ СТРАНЫ ЕВРОПЫ','В ТОМ ЧИСЛЕ СТРАНЫ ЕС:','АМЕРИКА,КАРИБСКИЙ БАССЕЙН','АВСТРАЛИЯ И ОКЕАНИЯ','CТРАНЫ ЕВРОПЫ','CТРАНЫ АФРИКИ','CТРАНЫ АЗИИ','Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')
group by kind,year
--order by country

create materialized view _2_import_bunk_17_18 as
select --distinct country 
	kind,year,country,x.﻿code_6 as tnved,added_sum as stoim
	--*
from (
	select 'bunk' kind,* 
	from _1_import17_bunc_added_sum
	union all
	select 'bunk' kind,* 
	from _1_import18_bunc_added_sum
	) x
where country not in ('ВСЕГО','ДРУГИЕ СТРАНЫ ЕВРОПЫ','В ТОМ ЧИСЛЕ СТРАНЫ ЕС:','АМЕРИКА,КАРИБСКИЙ БАССЕЙН','АВСТРАЛИЯ И ОКЕАНИЯ','CТРАНЫ ЕВРОПЫ','CТРАНЫ АФРИКИ','CТРАНЫ АЗИИ','Cтраны Азии','Cтраны Америки','Cтраны Африки','Cтраны Европы','Cтраны ЕС','Австралия и Океания','Америка,Карибский бассейн','в том числе страны ЕС:','Другие страны Европы','Страны вне СНГ','СТРАНЫ ВНЕ СНГ','Всего по странам мира','СНГ')
--group by kind,year
	
select count(*) from _2_import_bunk_17_18
where length(tnved) <> 6

---------------------------
--Сырьевые группы (sheet 3)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, "Группа",  
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, 'nn' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
--nn
(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399'))
group by year, country--, tnved
union all
--s
select year, country, 's' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
(left(tnved,2) in ('14', '26')
or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
group by year, country--, tnved
union all
--ne
select year, country, 'ne' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))
group by year, country
) x
group by country, "Группа"
order by country, "Группа"
--
--лист 2
with pam as (
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, "Группа",  
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, 'nn' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
--nn
(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399'))
group by year, country--, tnved
union all
--s
select year, country, 's' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
(left(tnved,2) in ('14', '26')
or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
group by year, country--, tnved
union all
--ne
select year, country, 'ne' "Группа", round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
where 
(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))
group by year, country
) x
group by country, "Группа"
order by country, "Группа"
)
select 
	"Группа стран","Группа",sum("2017") as "2017", sum("2018") as "2018"
from pam 
group by "Группа стран","Группа"
union 
select 'Всего', "Группа", sum("2017"), sum("2018")
from pam 
group by "Группа"
order by "Группа стран","Группа"
---

--(sheet 4)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, tnved,
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, tnved,round(sum(stoim),5) as "Сумма"
from _2_import_bunk_17_18
group by year, country,tnved
) x
group by "Группа стран",
country,tnved
--

--(sheet 1)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, 
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, round(sum(stoim),1) as "Сумма"
from _2_import_bunk_17_18
group by year, country
) x
group by "Группа стран",
country
-------------------------------------------
-------------------------------------------
-------------------------------------------
_2_export_bunk_fish_17_18
--Сырьевые группы (sheet 3)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, "Группа",  
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, 'nn' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
--nn
(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399'))
group by year, country--, tnved
union all
--s
select year, country, 's' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
(left(tnved,2) in ('14', '26')
or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
group by year, country--, tnved
union all
--ne
select year, country, 'ne' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))
group by year, country
) x
group by country, "Группа"
order by country, "Группа"
--
--лист 2
with pam as (
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, "Группа",  
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, 'nn' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
--nn
(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399'))
group by year, country--, tnved
union all
--s
select year, country, 's' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
(left(tnved,2) in ('14', '26')
or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
group by year, country--, tnved
union all
--ne
select year, country, 'ne' "Группа", round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
where 
(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))
group by year, country
) x
group by country, "Группа"
order by country, "Группа"
)
select 
	"Группа стран","Группа",sum("2017") as "2017", sum("2018") as "2018"
from pam 
group by "Группа стран","Группа"
union 
select 'Всего', "Группа", sum("2017"), sum("2018")
from pam 
group by "Группа"
order by "Группа стран","Группа"
---

--(sheet 4)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, tnved,
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, tnved,round(sum(stoim),5) as "Сумма"
from _2_export_bunk_fish_17_18
group by year, country,tnved
) x
group by "Группа стран",
country,tnved
--

--(sheet 1)
select case 
			when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
			when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ',	'ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
	   else 'Другие'
	   end "Группа стран",
country, 
sum(case when year='2017' then "Сумма" end) "2017", sum(case when year='2018' then "Сумма" end) "2018"
from (
select year, country, round(sum(stoim),1) as "Сумма"
from _2_export_bunk_fish_17_18
group by year, country
) x
group by "Группа стран",
country
