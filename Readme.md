## Installation Steps:

* Install Docker with docker-compose

* `docker-compose build`

* `docker-compose run app`

## Description

Task was solved using 2 algorithms: Dijkstra's algorithm and Lee algorithm.

### Dijkstra's algorithm

 * GOOD: It showed better speed (see tests benchmarks).
 * BAD: It is not guaranteed (see `5. Dijkstra failing test`)
 * BAD: It's not optimal sometimes (`2. Mid level test` in 14 steps, `3. Hard level test` in 16 steps)

 ### Lee algorithm

 * GOOD: It finds solution if it exists (`5. Dijkstra failing test` went fine)
 * GOOD: It finds optimal solution (`2. Mid level test` in 10 steps, `3. Hard level test` in 14 steps)
 * BAD: It takes way more time then Dijkstra's algorithm (44 secs on my laptop for `3. Hard level test`)

### Сonclusions

Lee algorithm is needed if we have time, Dijkstra's is good time is critical and it's OK for us to receive mistakes sometimes.