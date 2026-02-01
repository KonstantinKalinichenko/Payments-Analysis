--Task 4: Fraud / Abuse Investigation

drop function if exists public.get_redeem_fraud_breakdown;

create function public.get_redeem_fraud_breakdown(
    p_redeem_ts timestamptz,
    p_creator_id bigint
)
returns table (
	    sender_id bigint,
	    diamonds_earned bigint,
	    coins_spent_on_creator bigint,
	    total_purchased_coins bigint,
	    streamer bigint,
	    share numeric,
	    suspicious_flag int,
	    suspicious_diamonds bigint
)
language sql
as $$
with
    bought_coins as (
        select account_id, sum(coins_purchased) as coins_purchased
        from public.fact_purchases
        where "timestamp" <= p_redeem_ts
        group by account_id --sum of cooins purchases by viewer
    ),
    spend_coins as (
        select
            sender_account_id,
            receipt_account_id,
            sum(coins_spent) as coins_spent,
            sum(diamonds_earned) as diamonds_earned
        from public.fact_gifts
        where "timestamp" <= p_redeem_ts
        group by sender_account_id, receipt_account_id --all the gifts from specific gifter to specific creator
    )
select
    spend_coins.sender_account_id as sender_id, --donator
    spend_coins.diamonds_earned, --donation in diamonds
    spend_coins.coins_spent as coins_spent_on_creator,-- donation in coins
    bought_coins.coins_purchased as total_purchased_coins,
    spend_coins.receipt_account_id as streamer, --creator
    spend_coins.coins_spent::numeric / bought_coins.coins_purchased as share, --percent of donations
    case
        when spend_coins.coins_spent::numeric / bought_coins.coins_purchased >= 0.8 then 1
        else 0
    	end as suspicious_flag,
    case
        when spend_coins.coins_spent::numeric / bought_coins.coins_purchased >= 0.8
            then spend_coins.diamonds_earned
        else 0
    end as suspicious_diamonds 
from spend_coins
join bought_coins
  on bought_coins.account_id = spend_coins.sender_account_id
where bought_coins.coins_purchased > 0
  and spend_coins.receipt_account_id = p_creator_id;
$$;

with
redeems_analysis as (
    select
        r.redeem_id as "Redeem id",
        r.creator_id as "Creator id",
        breakdown.sender_id as "Sender id",
        breakdown.diamonds_earned as "Diamonds earned from this gifter (so far)",
        breakdown.coins_spent_on_creator as "Gifter spend coins on this creator (so far)",
        breakdown.total_purchased_coins as "Gifter total purchased coins (so far)",
        breakdown.share as "Share",
        breakdown.suspicious_flag as "Flag",
        breakdown.suspicious_diamonds as "Suspicious diamonds"
    from public.fact_redeems r
    join lateral public.get_redeem_fraud_breakdown(
        r."timestamp",
        r.creator_id
    ) as breakdown
      on breakdown.streamer = r.creator_id
),
fraud_analysis as (
    select
        redeems_analysis."Redeem id",
        sum(redeems_analysis."Suspicious diamonds") as "Sum of suspicious diamonds",
        sum(redeems_analysis."Diamonds earned from this gifter (so far)")
            as "Sum of diamonds earned from this gifter (so far)"
    from redeems_analysis
    group by redeems_analysis."Redeem id"
)
select
    redeems_analysis.*,
    fraud_analysis."Sum of suspicious diamonds",
    fraud_analysis."Sum of diamonds earned from this gifter (so far)",
    fraud_analysis."Sum of suspicious diamonds"
        / fraud_analysis."Sum of diamonds earned from this gifter (so far)"
        as "Fraud ratio",
    (fraud_analysis."Sum of suspicious diamonds"
        / fraud_analysis."Sum of diamonds earned from this gifter (so far)") > 0.7
        as "Is fraudulent"
from redeems_analysis join fraud_analysis on redeems_analysis."Redeem id" = fraud_analysis."Redeem id";
