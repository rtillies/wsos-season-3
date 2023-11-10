# World Series of Spades Statistics
## wsos_spades_stats
App to track statistics for World Series of Spades Season 3, 2023-2024

* Ruby version 2.7.4
* Current through Week 01: November 09, 2023

### Stats only
* Run: `ruby ./lib/runner.rb XY`
* `XY` represents two-digit week number; e.g. `08`
* Output: `outputDiv08CSV.csv` (matches week number)

### Search function
* Run: `ruby ./lib/search.rb XY`
* `XY` represents two-digit week number; e.g. `08`
* Output: `outputDiv08CSV.csv` (matches week number)
* Enter partial team name
    * Returns Full team name, record, conference, division
* Choose to search by:
    * (C)onference: games scheduled against teams within same conference
    * (D)ivision: games scheduled against teams within same division
    * (H)ome: games scheduled with home rules
    * (A)way: games scheduled with opponent's home rules
    * (W)ins: games won
    * (L)osses: games lost
    * (T)eam: search games against specific team
    * (P)layed: games that have been actually played, no forfeits
    * (X): return all games played, no filter 