% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ef_emfac.R
\name{ef_emfac}
\alias{ef_emfac}
\title{EMFAC2017 emission factors for Statewide California, Calendar Year 2020}
\usage{
ef_emfac(
  veh = "LDT1",
  fuel = "Gasoline",
  mph,
  pol = "CO_RUNEX",
  season = "winter",
  full = FALSE
)
}
\arguments{
\item{veh}{Character; "one of the 40 vehicle categories shown below.}

\item{fuel}{Character; "Diesel", "Gasoline", "Electricity" or "Natural Gas"}

\item{mph}{Numeric; Speed in miles per hour (optional).}

\item{pol}{Character;
\itemize{
\item{if the user enter mph}{"NOx_RUNEX", "PM2.5_RUNEX", "PM10_RUNEX",
"CO2_RUNEX", "CH4_RUNEX", "N2O_RUNEX", "ROG_RUNEX", "TOG_RUNEX", "CO_RUNEX",
"SOx_RUNEX"}
\item{if the user do not enter mph}{
"NOx_RUNEX", "NOx_IDLEX", "NOx_STREX",
"PM2.5_RUNEX", "PM2.5_IDLEX", "PM2.5_STREX",
"PM2.5_PMTW" , "PM2.5_PMBW", "PM10_RUNEX",
"PM10_IDLEX", "PM10_STREX", "PM10_PMTW",
"PM10_PMBW", "CO2_RUNEX", "CO2_IDLEX",
"CO2_STREX", "CH4_RUNEX", "CH4_IDLEX",
"CH4_STREX", "N2O_RUNEX", "N2O_IDLEX",
"N2O_STREX", "ROG_RUNEX", "ROG_IDLEX",
"ROG_STREX", "ROG_HOTSOAK", "ROG_RUNLOSS",
"ROG_RESTLOSS", "ROG_DIURN", "TOG_RUNEX",
"TOG_IDLEX", "TOG_STREX", "TOG_HOTSOAK",
"TOG_RUNLOSS", "TOG_RESTLOSS", "TOG_DIURN",
"CO_RUNEX", "CO_IDLEX", "CO_STREX",
"SOx_RUNEX", "SOx_IDLEX", "SOx_STREX"
}
}}

\item{season}{Character: "winter" or "summer".}

\item{full}{Logical: To return the whole data.table or not.}
}
\value{
data.table with emission factors.
}
\description{
\code{\link{ef_emfac}} returns emission factors reflecting California, US,
conditions. If the user enter speeds more emission factors are returned.
See details.
}
\examples{
{
dfef <- ef_emfac()
colplot(df = dfef,
        x = dfef$Model_Year,
        cols = "CO_RUNEX",
        main = "EF from LDT1 with Gasoline on Winter")

pols <- c("CO_RUNEX", "NOx_RUNEX")
dfef2 <- ef_emfac(full = TRUE)
colplot(df = dfef2,
        x = dfef2$Model_Year,
        cols = pols,
        main = "EF from LDT1 with Gasoline on Winter")
}
}
\references{
https://arb.ca.gov/emfac/emissions-inventory
}
\keyword{emfac}
\keyword{emission}
\keyword{factors}
\keyword{speed}
