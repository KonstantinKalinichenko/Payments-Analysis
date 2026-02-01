DROP TABLE IF EXISTS public.dim_user_country CASCADE;

CREATE TABLE public.dim_user_country (
  account_id BIGINT PRIMARY KEY,
  country TEXT
);

DROP TABLE IF EXISTS public.fact_purchases CASCADE;

CREATE TABLE public.fact_purchases (
    purchase_id BIGINT PRIMARY KEY,
    account_id  BIGINT NOT NULL,
    "timestamp" TIMESTAMPTZ,
    price_usd   NUMERIC(12,2),
    coins_purchased BIGINT,
    CONSTRAINT fk_fact_purchases_account
        FOREIGN KEY (account_id)
        REFERENCES public.dim_user_country(account_id)
);

DROP TABLE IF EXISTS public.fact_gifts CASCADE;

CREATE TABLE public.fact_gifts (
    sender_account_id   BIGINT NOT NULL,
    receipt_account_id  BIGINT NOT NULL,
    "timestamp"         TIMESTAMPTZ,
    coins_spent         BIGINT,
    diamonds_earned     BIGINT,
    CONSTRAINT fk_fact_gifts_sender
        FOREIGN KEY (sender_account_id)
        REFERENCES public.dim_user_country(account_id),
    CONSTRAINT fk_fact_gifts_receipt
        FOREIGN KEY (receipt_account_id)
        REFERENCES public.dim_user_country(account_id)
);

DROP TABLE IF EXISTS public.fact_redeems CASCADE;

CREATE TABLE public.fact_redeems (
    redeem_id           BIGINT PRIMARY KEY,
    "timestamp"         TIMESTAMPTZ,
    creator_id          BIGINT NOT NULL,
    registration_date   DATE,
    amount_in_diamonds  BIGINT,
    amount_in_dollar    NUMERIC(12,2),
    CONSTRAINT fk_fact_redeems_creator
        FOREIGN KEY (creator_id)
        REFERENCES public.dim_user_country(account_id)
);
