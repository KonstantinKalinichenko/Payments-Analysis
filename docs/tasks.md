**Task 1 - Top Creators Leaderboard**

Build a top-10 leaderboard of creators ranked by total diamonds earned (lifetime).
The leaderboard should include:
- Creator ID  
- Total diamonds earned  
- Total value of earned diamonds in USD  

**Task 2 - Top Creator Countries**

Identify the top-10 countries based on total diamonds earned by creators registered in those countries (lifetime).

**Task 3 - Gifter Countries Supporting Indian Creators**

Analyze gifter behavior for creators registered in India and build a top-10 list of gifter countries,
ranked by total diamonds contributed to Indian creators (lifetime).

**Task 4 - Fraud / Abuse Investigation**

In Streamora, normal user behavior assumes that a single gifter sends gifts to multiple creators.
If a gifter directs the majority of their spending to a single creator, this behavior may indicate
potential fraud or abuse.

A gifter is considered suspicious if **80% or more of their total purchased coins (lifetime)**
were spent on gifts sent to a single creator.

Your task is to evaluate **each redeem request at the moment it is submitted** and determine
whether it should be flagged as suspicious.

#### Requirements

1. For each redeem request, determine whether it is suspicious (flag = 1) or not suspicious (flag = 0).

2. At the time of each redeem request, analyze the following:
   - All gifters who sent gifts to the creator submitting the redeem request.
   - All gifts received by the creator.
   - All coin purchases made by each involved gifter (lifetime, up to the redeem timestamp).

3. For each gifter:
   - Assign a suspicious flag:
     - `0` — less than 80% of purchased coins were spent on this creator.
     - `1` — 80% or more of purchased coins were spent on this creator.
   - Diamonds earned from suspicious gifters must be classified as **suspicious diamonds**.

4. For each redeem request:
   - Calculate:
     - (a) Total diamonds earned by the creator (lifetime, up to the redeem timestamp).
     - (b) Total suspicious diamonds earned by the creator.
   - If the ratio **(b / a) > 70%**, mark the redeem request as suspicious (flag = 1).
   - Otherwise, mark it as not suspicious (flag = 0).
