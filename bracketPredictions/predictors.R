require(aod)
require(ggplot2)

bracketData <- read.csv("1986.2010.bracketData.csv")

probitModel <- glm(
  win ~ seed + opp_seed + 
    win.percent + opp_win_percent + 
    wins_in_last_10 + opp_wins_in_last_10 +
    percent_of_wins_away + opp_percent_of_wins_away +
    Sagarin + opp_Sagarin +
    ppg + opp_Points_Scored_Per_Game +
    ppg_allowed + opp_Points_Allowed_Per_Game, 
  family = binomial(link = "probit"), 
  data = bracketData
)

summary(probitModel)

linearModel <- lm(
  win_margin ~ seed + opp_seed + 
    win.percent + opp_win_percent + 
    wins_in_last_10 + opp_wins_in_last_10 +
    percent_of_wins_away + opp_percent_of_wins_away +
    Sagarin + opp_Sagarin +
    ppg + opp_Points_Scored_Per_Game +
    ppg_allowed + opp_Points_Allowed_Per_Game,
  data = bracketData
)

summary(linearModel)
