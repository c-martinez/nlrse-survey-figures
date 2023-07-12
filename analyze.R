library(ggplot2)
library(tidyr)


# Read raw data
ds = read.table(
  file = "NL-RSE+Survey_December+6,+2022_14.45.csv",
  header = TRUE,
  sep = ","
)

# Drop first two rows
ds = ds[c(-1, -2),]

# Number of participants
nrow(ds)

# NL-RSE should represent the interests of RSEs nation-wide
ds$nlrse_nationwide = factor(ds$nlrse_nationwide, levels = c(
  "Strongly disagree",
  "Somewhat disagree",
  "Neither agree nor disagree",
  "Somewhat agree",
  "Strongly agree"
))
ggplot(ds, aes(nlrse_nationwide)) +
  geom_bar(stat = "count")


# Are interests RSEs safeguarded?
ds$rse_safeguarded_scal = factor(ds$rse_safeguarded_scal, levels = c(
  "Strongly disagree",
  "Somewhat disagree",
  "Neither agree nor disagree",
  "Somewhat agree",
  "Strongly agree"
))
ggplot(ds, aes(rse_safeguarded_scal)) +
  geom_bar(stat = "count")

# How are interests of RSEs safeguarded?
temp = ds$rse_safeguarded_expl[ds$rse_safeguarded_expl != ""]
length(temp)

# Print open answers
cat(
  sub("\n", " ", ds$rse_safeguarded_expl[ds$rse_safeguarded_expl != ""], fixed = TRUE), 
  sep = "\n",
  file = "rse_safeguarded_expl.txt"
)
                                  
# How frequently does your work entail the activities below?
rse_activities = ds[,paste0("rse_activities_", 1:5)]
names(rse_activities) = c("engineering", "science", "educating", "management", "other")
rse_activities = pivot_longer(
  rse_activities,
  c("engineering", "science", "educating", "management", "other")
)
rse_activities$value = factor(rse_activities$value, levels = c(
  "Never",
  "Rarely",
  "Sometimes",
  "Often",
  "Always"
))
ggplot(rse_activities, aes(value)) +
  geom_bar(stat = "count") +
  facet_grid(rows = vars(name))
  
# What opportunities motivate you to go to NL-RSE meetups?
meetup_goals = ds[,paste0("meetup_goals_", c(1, 4, 5, 6, 7, 8))]
names(meetup_goals) = c("technical", "policy", "feedback", "support", "network", "inspired")
for (i in 1:6) {
  meetup_goals[,i] = meetup_goals[,i] != ""
}
meetup_goals = pivot_longer(
  meetup_goals,
  c("technical", "policy", "feedback", "support", "network", "inspired")
)
meetup_goals = meetup_goals[meetup_goals$value, ]
ggplot(meetup_goals, aes(name)) +
  geom_bar(stat = "count")

# Opportunities open text
cat(
  sub("\n", " ", ds$meetup_goals_3_TEXT[ds$meetup_goals_3_TEXT != ""], fixed = TRUE), 
  sep = "\n",
  file = "meetup_goals_3_TEXT.txt"
)



# What meetup format do you prefer?
ggplot(ds, aes(meetup_formats)) +
  geom_bar(stat = "count")

# Suggestions for meetup topics
cat(
  sub("\n", " ", ds$meetup_topic[ds$meetup_topic != ""], fixed = TRUE), 
  sep = "\n",
  file = "meetup_topic.txt"
)

# Would you like to become active?
cat(ds$rse_join[ds$rse_join != ""], sep = "\n\n")

# Comments/suggestions?
cat(
  sub("\n", " ", ds$suggestions[ds$suggestions != ""], fixed = TRUE), 
  sep = "\n",
  file = "suggestions.txt"
)

cat(ds$suggestions[ds$suggestions != ""], sep = "\n\n")
