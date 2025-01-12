## Data pull

## TWharfSurface
narts20_15 <- all_params_dtrng("nartswq", c('08/01/2015', '12/31/2020'))
narts14_09 <- all_params_dtrng("nartswq", c('01/01/2009', '07/31/2015'))
narts08_04 <- all_params_dtrng("nartswq", c('01/01/2004', '12/31/2008'))

# # Wrangle data
# -5 Outside high sensor range
# -4 Outside low sensor range
# -3 Data rejected due to QAQC
# -2 Missing data
# -1 Optional parameter not collected
# 0 Passed initial QAQC checks
# 1 Suspect data
# 2 Reserved for future use
# 3 Calculated data: non-vented depth/level sensor correction for changes in barometric pressure
# 4 Historical: Pre-auto QAQC
# 5 Corrected data


# Bind 15 min data
narts<- rbind(narts20_15, narts14_09, narts08_04)

## Get temperature data
narts.temp.daily<- narts %>%
  select(datetimestamp, temp, f_temp)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("NAR")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

narts.temp.daily %>% 
  ggplot(aes(x = date, y = mean_daily))+
  geom_point(size = 0.2)+
  geom_line()+
  geom_ribbon(aes(ymin = lower_ci, ymax = upper_ci ), alpha = 0.5)

narts.dopct.daily<- narts %>%
  select(datetimestamp, do_pct, f_do_pct)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("NAR")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

narts.domgl.daily<- narts %>%
  select(datetimestamp, do_mgl, f_do_mgl)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("NAR")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

narts.turb.daily<- narts %>%
  select(datetimestamp, turb, f_turb)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("NAR")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

narts.sal.daily<- narts %>%
  select(datetimestamp, sal, f_sal)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("NAR")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

narts.daily<- rbind(narts.domgl.daily, narts.dopct.daily, narts.temp.daily, narts.turb.daily, narts.sal.daily)
#write.csv(narts.daily, file = "data/nartsdaily.csv")
# get heatwave date set
nar_hw<- narts.temp.daily %>% 
  select(date, mean_daily) %>% 
  drop_na() %>% 
  rename(t = date, 
         temp = mean_daily)

write.csv(nar_hw, file = "data/nar_heatwave.csv")
# Get monthly mean of TS data
narts.monthly <- narts.daily %>%
  mutate(month.year = format(date, "%y-%m")) %>%
  group_by(month.year, Variable) %>%
  summarise(mean_monthly = mean(mean_daily), 
            sd_monthly = sd(mean_daily), 
            upper_ci = mean_monthly + sd_monthly, 
            lower_ci = mean_monthly - sd_monthly) %>%
  mutate(station = c("NAR"))

#write.csv(narts.monthly, file = "data/nartsmonthly.csv")

narts.monthly %>% 
  ggplot(aes(x = month.year, y = mean_monthly))+
  geom_point()+
  geom_line()+
  geom_ribbon( aes(ymin = lower_ci, ymax = upper_ci ), alpha = 0.5)+
  facet_wrap(~Variable) 

#############################
## GREAT BAY
grb20_15 <- all_params_dtrng("grbgbwq", c('01/01/2015', '12/31/2020'))
grb14_09 <- all_params_dtrng("grbgbwq", c('01/01/2009', '12/31/2014'))
grb08_04 <- all_params_dtrng("grbgbwq", c('01/01/2004', '12/31/2008'))
grb03_96 <- all_params_dtrng("grbgbwq", c('01/01/1996', '12/31/2003'))

# Bind 15 min data
grb<- rbind(grb20_15, grb14_09, grb08_04, grb03_96)

## Get temperature data
grb.temp.daily<- grb %>%
  select(datetimestamp, temp, f_temp)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("GRB")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

grb.temp.daily %>% 
  ggplot(aes(x = date, y = mean_daily))+
  geom_point(size = 0.2)+
  geom_line()+
  geom_ribbon(aes(ymin = lower_ci, ymax = upper_ci ), alpha = 0.5)

grb.dopct.daily<- grb %>%
  select(datetimestamp, do_pct, f_do_pct)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("GRB")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

grb.domgl.daily<- grb %>%
  select(datetimestamp, do_mgl, f_do_mgl)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("GRB")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

grb.turb.daily<- grb %>%
  select(datetimestamp, turb, f_turb)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("GRB")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

grb.sal.daily<- grb %>%
  select(datetimestamp, sal, f_sal)%>%
  mutate_if(is.character,as.numeric) %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value < 0) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 1) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 2) %>%
  dplyr::filter(!Variable == str_detect(Variable, "f_") &  !Value == 4) %>%
  pivot_wider(names_from = Variable, values_from = Value) %>%
  drop_na() %>%
  tidyr::pivot_longer(!datetimestamp, names_to = "Variable", values_to = "Value") %>%
  mutate(date = as.Date(datetimestamp)) %>%
  group_by(date, Variable) %>%
  summarise(mean_daily = mean(Value, na.rm=TRUE),
            sd_daily  = sd(Value)) %>%
  filter(!str_detect(Variable, "f_")) %>%
  dplyr::mutate(station = c("GRB")) %>%
  ungroup() %>%
  mutate(month = lubridate::month(date),
         year = lubridate::year(date),
         upper_ci = mean_daily + sd_daily,
         lower_ci = mean_daily - sd_daily)

grb.daily<- rbind(grb.domgl.daily, grb.dopct.daily, grb.temp.daily, grb.turb.daily, grb.sal.daily)
#write.csv(narts.daily, file = "data/nartsdaily.csv")
# get heatwave date set
grb_hw<- grb.temp.daily %>% 
  select(date, mean_daily) %>% 
  drop_na() %>% 
  rename(t = date, 
         temp = mean_daily)

write.csv(grb_hw, file = "data/grb_heatwave.csv")
# Get monthly mean of TS data
grb.monthly <- grb.daily %>%
  mutate(month.year = format(date, "%y-%m")) %>%
  group_by(month.year, Variable) %>%
  summarise(mean_monthly = mean(mean_daily), 
            sd_monthly = sd(mean_daily), 
            upper_ci = mean_monthly + sd_monthly, 
            lower_ci = mean_monthly - sd_monthly) %>%
  mutate(station = c("GRB")) %>% 
  ungroup()

#write.csv(narts.monthly, file = "data/nartsmonthly.csv")

grb.monthly %>% 
  ggplot(aes(x = month.year, y = mean_monthly))+
  geom_point()+
  geom_line()+
  geom_ribbon( aes(ymin = lower_ci, ymax = upper_ci ), alpha = 0.5)+
  facet_wrap(~Variable)


daily_wq<- rbind(narts.daily, grb.daily)
write.csv(daily_wq, file = "data/daily_wq.csv")
monthly_wq <- rbind(narts.monthly, grb.monthly)
write.csv(monthly_wq, file = "data/monthly_wq.csv")
