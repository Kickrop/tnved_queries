--list 1-------------------------------------------------------------------------	
--лист 1 im
drop materialized view list_1_import cascade 
create materialized view list_1_import as 
select * from (
	select 
	case 
		when cntr in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
		when cntr in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ','ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
		else 'Другие'
	end "Группа стран",
		cntr,
		--tnved,
		sum(case when year='2016' then value_sum end) "2016"
		,sum(case when year='2017' then value_sum end) "2017"
		,sum(case when year='2018' then value_sum end) "2018"
		,sum(case when year='2019' then value_sum end) "2019"
	from (
		select right(period,4) as year, name cntr, tnved, stoim/1000000 value_sum--"Сумма"--round(sum(stoim)/1000000,1) "Сумма"
		from tcbt left join spr_cntr on tcbt.strana = spr_cntr.kod
		where napr = 'ИМ' --and tnved <> 'SSSSSS'
		--and round(stoim/1000000,1) > 0
		) x
	group by 
		"Группа стран",
		cntr
) t	
--лист 1 ex
drop materialized view list_1_export cascade
create materialized view list_1_export as 
select * from (
	select 
	case 
		when cntr in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
		when cntr in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ','ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
		else 'Другие'
	end "Группа стран",
		cntr,
		--tnved,
		sum(case when year='2016' then value_sum end) "2016"
		,sum(case when year='2017' then value_sum end) "2017"
		,sum(case when year='2018' then value_sum end) "2018"
		,sum(case when year='2019' then value_sum end) "2019"
	from (
		select right(period,4) as year, name cntr, tnved, stoim/1000000 value_sum--"Сумма"--round(sum(stoim)/1000000,1) "Сумма"
		from tcbt left join spr_cntr on tcbt.strana = spr_cntr.kod
		where napr = 'ЭК' --and tnved <> 'SSSSSS'
		--and round(stoim/1000000,1) > 0
		) x
	group by 
		"Группа стран",
		cntr
) t	
--im bunc summa
--drop materialized view _2_list_1_import_bunc19 cascade
create materialized view _2_list_1_import_bunc19 as 
select 
	"Группа стран"
	,cntr
	--,"2016"
	--,"2017"
	,"2018"
	,bunc18
	,COALESCE("2018", 0)+COALESCE(bunc18, 0) bunc_summa18
	,"2019"
	,bunc19
	,COALESCE("2019", 0)+COALESCE(bunc19, 0) bunc_summa19
from list_1_import
left join 
(select year,country,sum(added_sum) bunc19 from _1_import19_bunc_added_sum
group by year,country) b
on list_1_import.cntr=b.country
left join 
(select year,country,sum(added_sum) bunc18 from _1_import18_bunc_added_sum
group by year,country) c18
on list_1_import.cntr=c18.country
--
-- ex fish
drop materialized view _2_list_1_export_fts_fish19 cascade
create materialized view _2_list_1_export_fts_fish19 as 
select 
	"Группа стран"
	,cntr
	--,"2016"
	--,"2017"
	,"2018"
	,fish18
	,COALESCE("2018", 0)+COALESCE(fish18, 0) fts_fish18
	,"2019"
	--,bunc19
	,fish19
	,COALESCE("2019", 0)+COALESCE(fish19, 0) fts_fish19 --COALESCE(bunc19, 0)
from list_1_export
--left join 
--(select year,country,sum(added_sum) bunc19 from _1_export19_bunc_added_sum
--group by year,country) b
--on list_1_export.cntr=b.country
left join 
(select year,country,sum(added_sum) fish19 from _1_export19_fish_added_sum group by year,country) f 
on list_1_export.cntr = f.country 
left join 
(select year,country,sum(added_sum) fish18 from _1_export18_fish_added_sum group by year,country) f18 
on list_1_export.cntr = f18.country 
--
--im
--drop materialized view _2_list_1_import_bunc19_gr_c
create materialized view _2_list_1_import_bunc19_gr_c as 
select * from _2_list_1_import_bunc19
union
select 
	'Всего' "Группа стран"
	,'Всего' cntr
	--,"2016"
	--,"2017"
	,sum("2018")
	,sum(bunc18)
	,sum(bunc_summa18)
	,sum("2019")
	,sum(bunc19)
	--,COALESCE("2019", 0)+COALESCE(bunc19, 0) bunc_summa19
	,sum(bunc_summa19)
from _2_list_1_import_bunc19

--ex f
drop materialized view _2_list_1_export_fts_fish19_gr_c
create materialized view _2_list_1_export_fts_fish19_gr_c as 
select * from _2_list_1_export_fts_fish19
union
select 
	'Всего' "Группа стран"
	,'Всего' cntr
	--,"2016"
	--,"2017"
	,sum("2018")
	,sum(fish18)
	,sum(fts_fish18)
	,sum("2019")
	--,bunc19
	,sum(fish19)
	--,COALESCE("2019", 0)+COALESCE(bunc19, 0)+COALESCE(fish19, 0) bunc_summa19
	--,COALESCE("2019", 0)+COALESCE(fish19, 0) fts_fish_19
	,sum(fts_fish19)
from _2_list_1_export_fts_fish19
-----
--im list 1 final
select 
	"Группа стран"
	,cntr
	--,"2016"::numeric
	--,"2017"::numeric
	,"2018"::numeric
	,bunc18::numeric
	,bunc_summa18::numeric
	,"2019"::numeric
	,bunc19::numeric
	,bunc_summa19::numeric
from _2_list_1_import_bunc19_gr_c le 		
union
select 
	"Группа стран",
		'Всего'
		--tnved,
		--sum("2016")::numeric "2016"
		--,sum("2017")::numeric "2017"
		,sum("2018")::numeric "2018"
		,sum(bunc18)::numeric bunc18
		,sum(bunc_summa18)::numeric bunc_summa18
		,sum("2019")::numeric "2019"
		,sum("bunc19")::numeric bunc19
		,sum(bunc_summa19)::numeric fts_fish19
	from 
		_2_list_1_import_bunc19_gr_c
	group by 
		"Группа стран"	
--
--ex list1 final	
select 
	"Группа стран"
	,cntr
	--,"2016"::numeric
	--,"2017"::numeric
	,"2018"::numeric
	,fish18::numeric
	,fts_fish18::numeric
	,"2019"::numeric
	,fish19::numeric
	,fts_fish19::numeric
from _2_list_1_export_fts_fish19_gr_c le 		
union
select 
	"Группа стран",
		'Всего',
		--tnved,
		--sum("2016")::numeric "2016"
		--,sum("2017")::numeric "2017"
		sum("2018")::numeric "2018"
		,sum(fish18)::numeric
		,sum(fts_fish18)::numeric
		,sum("2019")::numeric "2019"
		--,sum("bunc19") bunc19
		,sum(fish19)::numeric
		,sum(fts_fish19)::numeric fts_fish19
	from 
		_2_list_1_export_fts_fish19_gr_c
	group by 
		"Группа стран"


--list 1-------------------------------------------------------------------------end	
--
--fish total by gr
select 
	case 
		when country in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
		when country in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ','ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
		else 'Другие'
	end "Группа стран"
	,gr
	,sum(sum2019) fish19
from (	
select * from _2_export19_fish_gr
where country not in ('Другие страны Европы','Cтраны Африки','Страны вне СНГ','Cтраны ЕС','Cтраны Европы','Всего по странам мира','Cтраны Азии')
) t
group by "Группа стран", gr

--------------------
--check for 6 symbols
--select count(*) from tcbt
--where length(tnved) < 6 and right(period,4) = '2018'
----
--select *
--update tcbt
--set tnved = '0' || tnved
--where length(tnved) < 6 and right(period,4) = '2019'
--------------------
--

--list 4 ex-------------------------------------------------------------------------------
drop materialized view list4_export
create materialized view list4_export as 
select * from (
	select 
	case 
		when cntr in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
		when cntr in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ','ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
		else 'Другие'
	end "Группа стран",
		cntr,
		tnved,
		sum(case when year='2016' then value_sum end) "2016"
		,sum(case when year='2017' then value_sum end) "2017"
		,sum(case when year='2018' then value_sum end) "2018"
		,sum(case when year='2019' then value_sum end) "2019"
	from (
		select right(period,4) as year, name cntr, tnved, stoim/1000000 value_sum--"Сумма"--round(sum(stoim)/1000000,1) "Сумма"
		from tcbt left join spr_cntr on tcbt.strana = spr_cntr.kod
		where napr = 'ЭК' --and tnved <> 'SSSSSS'
		--and round(stoim/1000000,1) > 0
		) x
	group by 
		"Группа стран",
		cntr
		,tnved
) t
--list 4 im
drop materialized view list4_import
create materialized view list4_import as 
select * from (
	select 
	case 
		when cntr in ('АЗЕРБАЙДЖАН', 'АРМЕНИЯ', 'БЕЛАРУСЬ', 'КАЗАХСТАН', 'КИРГИЗИЯ', 'МОЛДОВА, РЕСПУБЛИКА', 'ТАДЖИКИСТАН', 'ТУРКМЕНИЯ', 'УЗБЕКИСТАН', 'УКРАИНА') then 'СНГ'
		when cntr in ('АВСТРАЛИЯ','АВСТРИЯ','БЕЛЬГИЯ',	'СОЕДИНЕННОЕ КОРОЛЕВСТВО','ВЕНГРИЯ','ГЕРМАНИЯ',	'ГРЕЦИЯ','ДАНИЯ',	'ИЗРАИЛЬ',	'ИРЛАНДИЯ',	'ИСЛАНДИЯ',	'ИСПАНИЯ','ИТАЛИЯ','КАНАДА','ЛАТВИЯ','ЛЮКСЕМБУРГ','МЕКСИКА','НИДЕРЛАНДЫ','НОВАЯ ЗЕЛАНДИЯ',	'НОРВЕГИЯ',	'ПОЛЬША','ПОРТУГАЛИЯ','КОРЕЯ, РЕСПУБЛИКА','СЛОВАКИЯ',	'СЛОВЕНИЯ',	'СОЕДИНЕННЫЕ ШТАТЫ','ТУРЦИЯ','ФИНЛЯНДИЯ','ФРАНЦИЯ','ЧЕХИЯ','ЧИЛИ','ШВЕЙЦАРИЯ','ШВЕЦИЯ','ЭСТОНИЯ','ЯПОНИЯ') then 'ОЭСР'
		else 'Другие'
	end "Группа стран",
		cntr,
		tnved,
		sum(case when year='2016' then value_sum end) "2016"
		,sum(case when year='2017' then value_sum end) "2017"
		,sum(case when year='2018' then value_sum end) "2018"
		,sum(case when year='2019' then value_sum end) "2019"
	from (
		select right(period,4) as year, name cntr, tnved, stoim/1000000 value_sum--"Сумма"--round(sum(stoim)/1000000,1) "Сумма"
		from tcbt left join spr_cntr on tcbt.strana = spr_cntr.kod
		where napr = 'ИМ' --and tnved <> 'SSSSSS'
		--and round(stoim/1000000,1) > 0
		) x
	group by 
		"Группа стран",
		cntr
		,tnved
) t
--
-----------------------------------------------------------------
select * --gr,count(*)
from tnved_groups
group by gr
-----------------------------------------------------------------
create materialized view tnved_groups as 
select distinct tnved,'nn' as gr
from tcbt t2 
where 
(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399', 'SSSSSS'))
union all
--s
select distinct tnved,'s'
from tcbt
where 
(left(tnved,2) in ('14', '26')
or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
union all
--ne
select distinct tnved, 'ne'
from tcbt
where
(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))	
	
	
	

--list 6 export fish -------------------------------------------------------------------------------------
create materialized view _1_list6_export as 
with fish as (
select
	country
	,code_6
	,gr
	,sum(case when year = '2018' then added_sum::numeric end) "2018"
	,sum(case when year = '2019' then added_sum::numeric end) "2019"
--select *
from (	
select --* 
	year,country,code_6,gr,added_sum
from _1_export19_fish_added_sum efas  
left join tnved_groups on efas.code_6=tnved_groups.tnved
where country not in ('Cтраны Азии','Cтраны Африки','Cтраны ЕС','Cтраны Европы','Другие страны Европы','Страны вне СНГ')
and code_6 not in ('0')
--) a
union --all
--full join 
--(
select --* 
	year,country,code_6,gr,added_sum
from "_1_export18_fish_added_sum" efas  
left join tnved_groups on efas.code_6=tnved_groups.tnved
where country not in ('Cтраны Азии','Cтраны Африки','Cтраны ЕС','Cтраны Европы','Другие страны Европы','Страны вне СНГ','Cтраны Америки')
and code_6 <> '0'
) b --on a.country=b.country and a.code_6=b.code_6 and a.gr=b.gr
group by 	
	country
	,code_6
	,gr
)
select 
	country 
	,fish.code_6
	,gr
	,simple_nam 
	,"2018"
	,"2019"
from fish
left join spr_tnvd spr on spr.kod = fish.code_6
--list 6 export fish -------------------------------------------------------------------------------------

	
--list 6 import bunk
create materialized view _1_list6_import as 
with im_b18_19 as (
select
	country
	,tnved
	,code_name
	--,gr
	,sum(case when year = '2018' then added_sum::numeric end) "2018"
	,sum(case when year = '2019' then added_sum::numeric end) "2019"
--select *
from (	
select --* 
	year,efas.country,efas.tnved
	,code_name
	--,gr
	,added_sum
from _1_import19_bunc_added_sum efas  
--left join tnved_groups on efas.tnved=tnved_groups.tnved
left join (select distinct code_6,code_name from import_bunk_2019) import_bunk_2019 on efas.tnved = import_bunk_2019.code_6 
where efas.country not in ('Cтраны Азии','Cтраны Африки','Cтраны ЕС','Cтраны Европы','Другие страны Европы','Страны вне СНГ')
and efas.tnved not in ('0')
--) a
union --all
--full join 
--(
select --* 
	year,country
	,efas."﻿code_6"
	,code_name
	--,gr
	,added_sum
from _1_import18_bunc_added_sum efas  
left join (select distinct ﻿code_6,code_name from import_bunk_18) import_bunk_18 on efas."﻿code_6" = import_bunk_18.﻿code_6 
--left join tnved_groups on efas.﻿code_6=tnved_groups.tnved
where country not in ('СНГ','СТРАНЫ ВНЕ СНГ','в том числе страны ЕС:','Cтраны Азии','Cтраны Африки','Cтраны ЕС','Cтраны Европы','Другие страны Европы','Страны вне СНГ','Cтраны Америки','Австралия и Океания','Америка,Карибский бассейн')
and efas."﻿code_6" <> '0'
) b --on a.country=b.country and a.code_6=b.code_6 and a.gr=b.gr
group by 	
	country
	,tnved
	,code_name
	--,gr	
) 
select 
	country,tnved,'nn' gr,code_name,"2018","2019"
from im_b18_19
where 
	(left(tnved,2) in ('01',	'02',	'03',	'04',	'06',	'07',	'08',	'09',	'10',	'11',	'16',	'17',	'19',	'20',	'21',	'22',	'24',	'28',	'29',	'30',	'31',	'32',	'33',	'34',	'35',	'36',	'37',	'42',	'46',	'48',	'49',	'53',	'54',	'56',	'57',	'58',	'59',	'60',	'61',	'62',	'64',	'65',	'66',	'67',	'68',	'69',	'73',	'81',	'82',	'83',	'84',	'85',	'86',	'87',	'88',	'89',	'90',	'91',	'92',	'93',	'94',	'95',	'96',	'97')
	or left(tnved,4) in ('0504',	'1201',	'1202',	'1203',	'1204',	'1205',	'1206',	'1207',	'1208',	'1209',	'1210',	'1212',	'1214',	'1302',	'1501',	'1502',	'1503',	'1504',	'1505',	'1506',	'1507',	'1508',	'1509',	'1510',	'1511',	'1512',	'1513',	'1514',	'1515',	'1516',	'1517',	'1518',	'1519',	'1520',	'1521',	'1801',	'1803',	'1804',	'1805',	'1806',	'2301',	'2304',	'2305',	'2306',	'2309',	'2523',	'3801',	'3802',	'3803',	'3805',	'3806',	'3807',	'3808',	'3809',	'3810',	'3811',	'3812',	'3813',	'3814',	'3815',	'3816',	'3817',	'3818',	'3819',	'3820',	'3821',	'3822',	'3823',	'3824',	'3826',	'3901',	'3902',	'3903',	'3904',	'3905',	'3906',	'3907',	'3908',	'3909',	'3910',	'3911',	'3912',	'3913',	'3914',	'3916',	'3917',	'3918',	'3919',	'3920',	'3921',	'3922',	'3923',	'3924',	'3925',	'3926',	'4002',	'4005',	'4006',	'4007',	'4008',	'4009',	'4010',	'4011',	'4012',	'4013',	'4014',	'4015',	'4016',	'4017',	'4104',	'4105',	'4106',	'4107',	'4108',	'4109',	'4110',	'4111',	'4112',	'4113',	'4114',	'4302',	'4303',	'4304',	'4402',	'4404',	'4405',	'4406',	'4407',	'4408',	'4409',	'4410',	'4411',	'4412',	'4413',	'4414',	'4415',	'4416',	'4417',	'4418',	'4419',	'4420',	'4421',	'4502',	'4503',	'4504',	'4701',	'4702',	'4703',	'4704',	'4705',	'4706',	'5004',	'5005',	'5006',	'5007',	'5105',	'5106',	'5107',	'5108',	'5109',	'5110',	'5111',	'5112',	'5113',	'5201',	'5203',	'5204',	'5205',	'5206',	'5207',	'5208',	'5209',	'5210',	'5211',	'5212',	'5501',	'5502',	'5503',	'5504',	'5506',	'5507',	'5508',	'5509',	'5510',	'5511',	'5512',	'5513',	'5514',	'5515',	'5516',	'6301',	'6302',	'6303',	'6304',	'6305',	'6306',	'6307',	'6308',	'6309',	'7002',	'7003',	'7004',	'7005',	'7006',	'7007',	'7008',	'7009',	'7010',	'7011',	'7012',	'7013',	'7014',	'7015',	'7016',	'7017',	'7018',	'7019',	'7020',	'7104',	'7105',	'7106',	'7107',	'7108',	'7109',	'7110',	'7111',	'7113',	'7114',	'7115',	'7116',	'7117',	'7118',	'7201',	'7202',	'7203',	'7205',	'7206',	'7207',	'7208',	'7209',	'7210',	'7211',	'7212',	'7213',	'7214',	'7215',	'7216',	'7217',	'7218',	'7219',	'7220',	'7221',	'7222',	'7223',	'7224',	'7225',	'7226',	'7227',	'7228',	'7229',	'7401',	'7402',	'7403',	'7405',	'7406',	'7407',	'7408',	'7409',	'7410',	'7411',	'7412',	'7413',	'7414',	'7415',	'7416',	'7417',	'7418',	'7419',	'7501',	'7502',	'7504',	'7505',	'7506',	'7507',	'7508',	'7601',	'7603',	'7604',	'7605',	'7606',	'7607',	'7608',	'7609',	'7610',	'7611',	'7612',	'7613',	'7614',	'7615',	'7616',	'7801',	'7804',	'7806',	'7901',	'7903',	'7904',	'7905',	'7906',	'7907',	'8001',	'8003',	'8007')
	or left(tnved,6) in ('411510',	'710122',	'710229',	'710239',	'710391',	'710399', 'SSSSSS'))
union
select 
	country,tnved,'s' gr,code_name,"2018","2019"
from im_b18_19
where 
	(left(tnved,2) in ('14', '26')
	or left(tnved,4) in ('0501',	'0502',	'0505',	'0506',	'0507',	'0508',	'0509',	'0510',	'0511',	'1211',	'1213',	'1301',	'1522',	'1802',	'2302',	'2303',	'2307',	'2308',	'2501',	'2502',	'2503',	'2504',	'2505',	'2506',	'2507',	'2508',	'2509',	'2510',	'2511',	'2512',	'2513',	'2514',	'2515',	'2516',	'2517',	'2518',	'2519',	'2520',	'2521',	'2522',	'2524',	'2525',	'2526',	'2527',	'2528',	'2529',	'2530',	'2701',	'2702',	'2703',	'2709',	'2714',	'3804',	'3825',	'3915',	'4001',	'4003',	'4004',	'4101',	'4102',	'4103',	'4301',	'4401',	'4403',	'4501',	'4707',	'5001',	'5002',	'5003',	'5101',	'5102',	'5103',	'5104',	'5202',	'5505',	'6310',	'7001',	'7112',	'7204',	'7404',	'7503',	'7602',	'7802',	'7902',	'8002')
	or left(tnved,6) in ('271111',	'271121',	'411520',	'710110',	'710121',	'710210',	'710221',	'710231',	'710310'))
union
select 
	country,tnved,'ne' gr,code_name,"2018","2019"
from im_b18_19	
where
	(left(tnved,4) in ('2704',	'2705',	'2706',	'2707',	'2708',	'2710',	'2712',	'2713',	'2715',	'2716')
	or left(tnved,6) in ('271112',	'271113',	'271114',	'271115',	'271116',	'271117',	'271118',	'271119',	'271129'))
---import bunc -------------------------------------




	
select country,code_6,sum(added_sum) from _1_export18_fish_added_sum
group by country,code_6
left join 
select country,code_6,sum(added_sum) 
from _1_export19_fish_added_sum
where code_6 <> '0'
group by country,code_6
	

--export list 4 total calc
create materialized view _1_list4_export as 
with list4total as (
select 
	"Группа стран" 
	,cntr 
	,tnved
	,spr_tnvd.simple_nam 
	--,"2016"
	--,"2017" 
	,"2018" 
	,"2019" 
from list4_export
left join spr_tnvd on list4_export.tnved = spr_tnvd.kod
union 
select 
	"Группа стран" 
	,cntr 
	--,list4.tnved
	,'Всего по ТНВЭД' as tnved_sum
	--,spr_tnvd.simple_nam 
	,'Всего'
	--,sum("2016")
	--,sum("2017")
	,sum("2018") 
	,sum("2019") 
from list4_export
left join spr_tnvd on list4_export.tnved = spr_tnvd.kod
group by "Группа стран", cntr
union 
select 
	"Группа стран" 
	--,cntr
	,'Всего по странам' as cntr_sum
	,list4_export.tnved
	,spr_tnvd.simple_nam 
	--,sum("2016")
	--,sum("2017")
	,sum("2018") 
	,sum("2019") 
from list4_export
left join spr_tnvd on list4_export.tnved = spr_tnvd.kod
group by "Группа стран", list4_export.tnved,simple_nam
)
select 
	"Группа стран"
	,cntr
	,list4total.tnved
	,simple_nam
	,gr
	,"2018"
	,"2019"
from list4total
left join tnved_groups on list4total.tnved=tnved_groups.tnved

--import list 4 total
drop materialized view _1_list4_import
create materialized view _1_list4_import as 
with list4total as (
select 
	"Группа стран" 
	,cntr 
	,tnved
	,spr_tnvd.simple_nam 
	--,"2016"
	--,"2017" 
	,"2018" 
	,"2019" 
from list4_import
left join spr_tnvd on list4_import.tnved = spr_tnvd.kod 
union 
select 
	"Группа стран" 
	,cntr 
	,'Всего по ТНВЭД' as tnved_sum
	,'Всего'
	--,sum("2016")
	--,sum("2017")
	,sum("2018") 
	,sum("2019") 
from list4_import
left join spr_tnvd on list4_import.tnved = spr_tnvd.kod
group by "Группа стран", cntr
union 
select 
	"Группа стран" 
	,'Всего по странам' as cntr_sum
	,list4_import.tnved
	,spr_tnvd.simple_nam 
	--,sum("2016")
	--,sum("2017")
	,sum("2018") 
	,sum("2019") 
from list4_import
join spr_tnvd on list4_import.tnved = spr_tnvd.kod
group by "Группа стран", list4_import.tnved,simple_nam
)
select 
	"Группа стран"
	,cntr
	,list4total.tnved
	,simple_nam
	,gr
	,"2018"
	,"2019"
from list4total
left join tnved_groups on list4total.tnved=tnved_groups.tnved
---list 4-------------------------------------------------------------------------------end

--list 4 + list 6 ----------------------------------

select 
	case when "Группа стран" is not null then "Группа стран" else cntr_groups.cntr_gr end cntr_groups
	,case when cntr is not null then cntr else l6.country end cntr
	,case when l4.tnved is not null then l4.tnved else l6.tnved end tnved
	,case when l4.gr is not null then l4.gr else l6.gr end gr
	,case when l4.simple_nam is not null then l4.simple_nam else l6.code_name end code_name
	,l4."2018" fts18
	,l6."2018" bunc18
	,coalesce(l4."2018",0)+coalesce(l6."2018",0) fts_bunc18
	,l4."2019" fts19
	,l6."2019" bunc19
	,coalesce(l4."2019",0)+coalesce(l6."2019",0) fts_bunc19
--select *	
from _1_list4_import l4
full join _1_list6_import l6
on l4.cntr=l6.country and l4.tnved=l6.tnved and l4.gr=l6.gr
left join cntr_groups on l6.country=cntr_groups."name" 



select sum(stoim) y19
from tcbt t 
where (left(tnved,2) = '27') -- or tnved='SSSSSS')
and right(period,4) = '2019'
and napr = 'ЭК'


select --sum(stoim) y19
	case when (left(tnved,2) = '27') then sum(year18) end "kod27"
	,case when left(tnved,2)::int between 1 and 24 then sum(year18) end "kod_01_24"
	,case when left(tnved,2)::int between 25 and 27 then sum(year18) end "kod_25_27"
	,case when left(tnved,2)::int between 28 and 40 then sum(year18) end "kod_28_40"
	,case when left(tnved,2)::int between 41 and 43 then sum(year18) end "kod_41_43"
	,case when left(tnved,2)::int between 44 and 49 then sum(year18) end "kod_44_49"
	,case when left(tnved,2)::int between 50 and 67 then sum(year18) end "kod_50_67"
	,case when (left(tnved,2) = '71') then sum(year18) end "kod71"
	,case when left(tnved,2)::int between 72 and 83 then sum(year18) end "kod_72_83"
	,case when left(tnved,2)::int between 84 and 90 then sum(year18) end "kod_84_90"
from export_by_2_digits t 
group by tnved
--

select '27' "Тов. отрасль",sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) = '27'
union
select '25-27',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) in ('25','27')
union
select '01-24',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 1 and 24
union
select '28-40',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 28 and 40
union
select '41-43',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 41 and 43
union
select '44-49',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 44 and 49
union
select '50-67',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 50 and 67
union
select '71',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) in ('71')
union
select '72-83',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 72 and 83
union
select '84-90',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and left(tnved,2)::int between 84 and 90
union
select '68-70,91-97',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) <> 'SS' and (left(tnved,2)::int between 68 and 70 or left(tnved,2)::int between 91 and 97)
union
select 'SS',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
where left(tnved,2) = 'SS'
union
select '0',sum(year18) y18,sum(year19) y19
from export_by_2_digits t 
--


--

--экспорт по 2 знакам
create materialized view export_by_2_digits as
with export19 as (
select 
	right(period,4) years
	,napr
	,left(tnved,2) tnved
	,sum(stoim) y19
from tcbt t 
where --right(period,4) = '2019' and 
napr = 'ЭК'
group by right(period,4),napr,left(tnved,2)
)
select 
	napr,tnved
	,sum(case when years = '2018' then y19 end) year18
	,sum(case when years = '2019' then y19 end) year19
from (
	select 
	* 
	from export19
	where years in ('2018','2019')
) z
group by napr,tnved


select * from export_by_2_digits
where (left(tnved,2) = '27') -- or tnved='SSSSSS')

