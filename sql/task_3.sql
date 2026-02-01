-- Task 3: Gifter Countries Supporting Indian Creators

select uc.country as gifter_country,
       sum(fg.diamonds_earned) as total_diamonds
from fact_gifts fg
join dim_user_country uc
on uc.account_id = fg.sender_account_id
where fg.receipt_account_id in (
            select account_id
            from dim_user_country
            where country = 'India'
)
group by uc.country
order by total_diamonds desc
limit 10;