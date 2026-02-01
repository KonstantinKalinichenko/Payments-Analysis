-- Task 2: Top Creator Countries

select uc.country,
       sum(fg.diamonds_earned) as total_diamonds,
       round(sum(fg.diamonds_earned) * 0.005,2) as total_dollars
from fact_gifts fg
join dim_user_country uc on uc.account_id = fg.receipt_account_id
group by uc.country
order by total_diamonds desc
limit 10;