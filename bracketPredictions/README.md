# Modeling NCAA Tournament Matchups

### Questions
Given a matchup between two teams in the NCAA Tournament, what is the probability that the higher seed wins (and conversely, the lower seed winning, through probit modeling)?

Given a matchup between two teams in the NCAA Tournament, what is the expected margin of victory for the higher seeded team (through linear modeling)?

### Fun Reads
I'm currently living the life of a programmer, and it's nailed into us the importance of not "reinventing the wheel", so I found some cool things that other people had done.

* [Predicting the Outcomes of NCAA Basketball Championship Game](https://www2.gwu.edu/~forcpgm/2011-003.pdf) (probit)
* [Quantifying Intangibles: A New Way to Predict the NCAA Tournament](https://harvardsportsanalysis.wordpress.com/2011/05/18/quantifying-intangibles-a-network-analysis-prediction-model-for-the-ncaa-tournament/)
* [Statistical Predictors of March Madness:
An Examination of the NCAA Men’s’ Basketball Championship](http://economics-files.pomona.edu/GarySmith/Econ190/Wright%20March%20Madness%20Final%20Paper.pdf) (lots of inspiration here)
* [Bracket facts for 2016 NCAA tournament](http://www.espn.com/mens-college-basketball/story/_/id/14943099/upsets-seeds-teams-college-basketball)
* [March Madness brackets: How often we pick NCAA tournament upsets](http://www.ncaa.com/news/basketball-men/bracket-beat/2017-01-18/march-madness-brackets-how-often-we-pick-ncaa-tournament)
* [Building an NCAA men’s basketball predictive model and quantifying its success](https://arxiv.org/pdf/1412.0248.pdf) (cool stuff to look into)

### Data
The data used to build these models is a collection of every NCAA Tournament matchup from 1986 to 2011, with 76 different variables per matchup (found through one of the above papers). Some of these have been slightly renamed from the original dataset to allow for better variable access in R.

Variable Name | Description
--- | ---
year | year matchup was played
team | name of team
seed | seed of team
win margin | outcome of game ( < 0 represents win by opponent)
previous tournament | dummy for if team played in previous tournament
tournament two years back | dummy for if team played in  tournament two years ago
win percent | win percentage of team's regular season record
wins in last 10 | number of wins in last ten games
percent of wins away | percentage of total wins that occurred away from home court
coach tenure | number of years coach has been with school
total seasons coaching | number of years head coaching experience
coach final fours | number of final four appearances by coach
coach championships | number of national championships won by coach
coach NBA draft picks | number of NBA draft picks coached
automatic bid | dummy for if a team is an automatic bid
RPI | ratings percentage index
Sagarin | sagarin sports rating system
SOS | strength of schedule
Total Games | total number of games played during season
ppg | points per game
ppg allowed | points per game allowed
Efficiency | offensive efficiency = (points / posessions) * 100
Efficiency Allowed | efficiency allowed = (points allowed / possesions ) * 100
Rbs Per Game | rebounds per game
Rbs Per Game Allowed | rebounds per game allowed
Steals Per Game | steals per game
Steals Per Game Allowed | steals allowed per game
Blocks Per Game | blocks per game
FG% | field goal shooting percentage
3-pt% | three point field goal shooting percentage
TS% | true shooting percentage (weights for three pointers and free throws)
free throw rate | free throws attempted per game
assists per game | assists per game
freshmen play time | minutes per game
sophomore play time | minutes per game
junior play time | minutes per game
senior play time | minutes per game
opponent | name of opponent
opp_seed | seed of opponent
opp_previous tournament | dummy for if team played in previous tournament
opp_tournament two years back | ummy for if team played in  tournament two years ago
opp_win% | win percentage of team's regular season record
opp_wins in last 10 | number of wins in last ten games
opp_percent of wins away | percentage of total wins that occurred away from home court
opp_coach tenure | number of years coach has been with school
opp_total seasons coaching | number of years head coaching experience
opp_coach final fours | number of final four appearances by coach
opp_coach championships | number of national championships won by coach
opp_coach NBA draft picks | number of NBA draft picks coached
opp_automatic bid | dummy for if a team is an automatic bid
opp_RPI | ratings percentage index
opp_Sagarin | sagarin sports rating system
opp_SOS | strength of schedule
opp_Total Games | total number of games played during season
opp_ppg | points per game
opp_ppg | allowed	points per game allowed
opp_Efficiency | offensive efficiency = (points / posessions) ● 100
opp_Efficiency Allowed | efficiency allowed = (points allowed / possesions ) ● 100
opp_Rbs Per Game | rebounds per game
opp_Rbs Per Game Allowed | rebounds per game allowed
opp_Steals Per Game | steals per game
opp_Steals Per Game Allowed | steals allowed per game
opp_Blocks Per Game | blocks per game
opp_FG% | field goal shooting percentage
opp_3-pt% | three point field goal shooting percentage
opp_TS% | true shooting percentage (weights for three pointers and free throws)
opp_free throw rate | free throws attempted per game
opp_assists per game | assists per game
opp_freshmen play time | minutes per game
opp_sophomore play time | minutes per game
opp_junior play time | minutes per game
opp_senior play time | minutes per game
Round | round of NCAA Tournament

I followed a model built in one of the above articles (for first pass, things I want to add / change), and it looks like so:

Higher Seed Variable | Lower Seed Variable
--- | ---
seed | opp seed
win percent | opp win percent
wins in last 10 | opp wins in last 10
percent of wins away | opp percent of wins away
Sagarin rank | opp Sagarin rank
points per game | opponent points per game
points per game allows | opponent points per game allowed

### Results
##### Probit Model
```
Call:
glm(formula = win ~ seed + opp_seed + win.percent + opp_win_percent +
    wins_in_last_10 + opp_wins_in_last_10 + percent_of_wins_away +
    opp_percent_of_wins_away + Sagarin + opp_Sagarin + ppg +
    opp_Points_Scored_Per_Game + ppg_allowed + opp_Points_Allowed_Per_Game,
    family = binomial(link = "probit"), data = bracketData)

Deviance Residuals:
    Min       1Q   Median       3Q      Max  
-3.2204  -0.8170   0.4224   0.7802   4.0923  

Coefficients:
                             Estimate Std. Error z value Pr(>|z|)    
(Intercept)                 -1.537869   1.040258  -1.478 0.139313    
seed                         0.066677   0.030062   2.218 0.026555 *  
opp_seed                    -0.019838   0.018314  -1.083 0.278690    
win.percent                  7.386739   0.968570   7.626 2.41e-14 ***
opp_win_percent             -3.928100   0.910458  -4.314 1.60e-05 ***
wins_in_last_10             -0.045936   0.036315  -1.265 0.205893    
opp_wins_in_last_10         -0.018815   0.033763  -0.557 0.577350    
percent_of_wins_away        -3.827859   0.567479  -6.745 1.53e-11 ***
opp_percent_of_wins_away     1.806373   0.512918   3.522 0.000429 ***
Sagarin                     -0.021810   0.004677  -4.664 3.11e-06 ***
opp_Sagarin                  0.017057   0.002315   7.367 1.75e-13 ***
ppg                         -0.052143   0.015954  -3.268 0.001082 **
opp_Points_Scored_Per_Game   0.038951   0.018306   2.128 0.033354 *  
ppg_allowed                  0.061865   0.017446   3.546 0.000391 ***
opp_Points_Allowed_Per_Game -0.048207   0.019450  -2.479 0.013193 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1860.2  on 1574  degrees of freedom
Residual deviance: 1449.1  on 1560  degrees of freedom
AIC: 1479.1

Number of Fisher Scoring iterations: 11
```

#### Linear Model
```
Call:
lm(formula = win_margin ~ seed + opp_seed + win.percent + opp_win_percent +
    wins_in_last_10 + opp_wins_in_last_10 + percent_of_wins_away +
    opp_percent_of_wins_away + Sagarin + opp_Sagarin + ppg +
    opp_Points_Scored_Per_Game + ppg_allowed + opp_Points_Allowed_Per_Game,
    data = bracketData)

Residuals:
    Min      1Q  Median      3Q     Max
-37.566  -7.170  -0.153   6.917  98.264

Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 -23.55206    7.59611  -3.101 0.001966 **
seed                          0.15635    0.21535   0.726 0.467928    
opp_seed                      0.27724    0.12602   2.200 0.027958 *  
win.percent                  30.44453    6.94182   4.386 1.23e-05 ***
opp_win_percent               2.06114    6.13474   0.336 0.736932    
wins_in_last_10              -0.24395    0.26724  -0.913 0.361449    
opp_wins_in_last_10          -0.22487    0.24244  -0.928 0.353809    
percent_of_wins_away        -14.08964    4.07961  -3.454 0.000568 ***
opp_percent_of_wins_away      4.64165    3.57898   1.297 0.194851    
Sagarin                      -0.12991    0.03133  -4.146 3.57e-05 ***
opp_Sagarin                   0.08636    0.01021   8.461  < 2e-16 ***
ppg                           0.19611    0.10963   1.789 0.073823 .  
opp_Points_Scored_Per_Game   -0.28903    0.13199  -2.190 0.028683 *  
ppg_allowed                  -0.14389    0.12106  -1.189 0.234773    
opp_Points_Allowed_Per_Game   0.31557    0.13942   2.264 0.023739 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 10.89 on 1560 degrees of freedom
Multiple R-squared:  0.3247,	Adjusted R-squared:  0.3186
F-statistic: 53.57 on 14 and 1560 DF,  p-value: < 2.2e-16
```

# Todos
- [ ] Update dataset to remove matchups before 1997 (don't contain all statistics) and to include all matchups up until 2016
- [ ] Include more advanced statistics for matchups, such as pace, offensive rating, and defensive rating
- [ ] Include Ken Pomeroy's statistics, as his goal is prediction
- [ ] Properly use variables / weed out what is a good predictor
- [ ] Re-learn statistics to understand what the hell I'm doing
