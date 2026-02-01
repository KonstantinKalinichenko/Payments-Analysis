-- Task 1: Top Creators Leaderboard

select receipt_account_id as creator,
       sum(diamonds_earned) as total_diamonds,
       round(sum(diamonds_earned) * 0.005, 2) as total_dollars
from fact_gifts
group by receipt_account_id
order by total_diamonds desc
limit 10;