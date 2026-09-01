## Carbon tax of 1% of ex-ante GDP, permanent from shockyear
## Revenue recycled to households at the share Phi_TR_CO2 (50%, Luxembourg rule)

# Define the series necessary to calibrate the scenario
series <- c("t_co2", "EMS", "Y", "P") %>% tolower

# Load the selected series for the range baseyear:lastyear
selection <- calib_new_base %>% select(year, all_of(series))

## Change in exogenous variables
# t_co2 is set so that ex-ante revenue (t_co2 * EMS) equals 1% of nominal GDP
# at the year of the shock, and kept constant afterwards.

shock_ch <- mutate(selection,
                   t_co2 = ifelse(year >= shockyear,
                                  0.01 * p[which(year == shockyear)] * y[which(year == shockyear)] /
                                    ems[which(year == shockyear)],
                                  t_co2)
                   ) %>% select(year, t_co2)
