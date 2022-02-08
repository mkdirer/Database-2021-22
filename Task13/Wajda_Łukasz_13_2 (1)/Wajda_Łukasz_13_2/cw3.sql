create temp table temp1 as
select Province as p, concat (Product_category ,'-', Product_sub_category) as c, sum(Sales) as s
from sample group by cube ( p,c ) 
order by 2, 1 ;

select * from crosstab ( 'select c::text, p::text, s from temp1' )
as fr ( category text, "Alberta" numeric, "BritishColumbia" numeric,
"Manitoba" numeric, "NewBrunswick" numeric, "Newfoundland" numeric, "NorthwestTerritories" numeric,
"NovaScotia" numeric, "Nunavut" numeric, "Ontario" numeric, "PrinceEdwardIsland"
numeric,"Quebec" numeric, "Saskachewan" numeric,"Yukon" numeric, "All" numeric);