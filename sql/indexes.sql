-- Create indexes to improve query performance

create index if not exists idx_fact_purchases_account_ts
on fact_purchases (account_id, "timestamp");

create index if not exists idx_fact_gifts_ts_sender_receipt
on fact_gifts ("timestamp", sender_account_id, receipt_account_id);

create index if not exists idx_fact_gifts_receipt_ts
on fact_gifts (receipt_account_id, "timestamp");

create index if not exists idx_fact_redeems_creator_ts
on fact_redeems (creator_id, "timestamp");