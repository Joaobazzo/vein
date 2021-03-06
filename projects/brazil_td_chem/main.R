options(encoding = "UTF-8")
library(vein) # vein
library(sf) # spatial data
library(cptcity) # 7120 colour palettes
library(ggplot2) # plots
library(eixport) # create wrfchemi
library(data.table) # faster data.frames
sessionInfo()

# 0 Configuration
language           <- "english" # spanish portuguese
path               <- "config/inventory.xlsx"
readxl::excel_sheets(path)
metadata           <- readxl::read_xlsx(path = path, sheet = "metadata")
mileage            <- readxl::read_xlsx(path = path, sheet = "mileage")
tfs                <- readxl::read_xlsx(path = path, sheet = "tfs")
veh                <- readxl::read_xlsx(path = path, sheet = "fleet")
fuel               <- readxl::read_xlsx(path = path, sheet = "fuel")
pmonth             <- readxl::read_xlsx(path = path, sheet = "pmonth")
met                <- readxl::read_xlsx(path = path, sheet = "met")
year               <- 2018
scale              <- "tunnel"
theme              <- "black" # dark clean ing
delete_directories <- TRUE
source("config/config.R", encoding = "UTF-8")

# 1) Network ####
net                <- sf::st_read("network/net.gpkg")
crs                <- 31983
source("scripts/net.R", encoding = "UTF-8")

# 2) Traffic ####
net                <- readRDS("network/net.rds")
metadata           <- readRDS("config/metadata.rds")
categories         <- c("pc", "lcv", "trucks", "bus", "mc") # in network/net.gpkg
veh                <- readRDS("config/fleet_age.rds")
k_D                <- 1/2.482039
k_E                <- 1/5.708199
k_G                <- 1/5.866790
verbose            <- FALSE
year               <- 2018
theme              <- "black" # dark clean ink
source("scripts/traffic.R", encoding = "UTF-8")

# 3) Estimation ####
language           <- "portuguese" # english chinese spanish portuguese
metadata           <- readRDS("config/metadata.rds")
mileage            <- readRDS("config/mileage.rds")
veh                <- readRDS("config/fleet_age.rds")
net                <- readRDS("network/net.rds")
pmonth             <- readRDS("config/pmonth.rds")
met                <- readRDS("config/met.rds")
verbose            <- FALSE
year               <- 2018

# fuel calibration with fuel consumption data
fuel              <- readRDS("config/fuel.rds")
pol               <- "FC"
source("scripts/fuel_eval.R", encoding = "UTF-8")

# Exhaust
pol               <- c("CO", "HC", "NMHC", "NOx", "CO2",
                       "PM", "NO2", "NO", "SO2")
scale             <- "tunnel"
source("scripts/exhaust.R", encoding = "UTF-8")

# Evaporative
source("scripts/evaporatives.R", encoding = "UTF-8")

# distribute emissions into OSM roads ####
# To download OpenStreetMap data...
# Read and edit the file osm.R
# Then run manually
#download_osm <- TRUE
#OSM_region <- "sudeste"
#"scripts/osm.R"
# I already included OSM hre network/roads.rds

# 4) Post-estimation ####
language          <- "spanish" # english chinese spanish portuguese
net               <- readRDS("network/net.rds")
roads             <- readRDS("network/roads.rds") # I already included OSM
months_subset     <- 8           #10:11 for instance
g                 <- eixport::wrf_grid(
    paste0(system.file("extdata",
                       package = "eixport"),
           "/wrfinput_d01"))
# Number of lat points 99
# Number of lon points 149
crs               <- 4326
osm_name          <- "fclass"          #OSM column for type of road (motorway, trunk...)
source("scripts/post.R", encoding = "UTF-8")


# plots
metadata          <- readRDS("config/metadata.rds")
tfs               <- readRDS("config/tfs.rds")
veh               <- readRDS("config/fleet_age.rds")
pol               <- c("CO", "HC", "NOx", "CO2", "PM", "NMHC")
year              <- 2018
bg                <- "white"
pal               <- "mpl_viridis" # procura mais paletas com ?cptcity::find_cpt
breaks            <- "quantile" # "sd" "quantile" "pretty"
tit               <- "Emissões veiculares em São Paulo [t/ano]"
source("scripts/plots.R", encoding = "UTF-8")

# MECH ####
language          <- "portuguese" # english spanish 
months_subset     <- 8   #only one month each time
g                 <- eixport::wrf_grid(
    paste0(system.file("extdata",
                       package = "eixport"),
           "/wrfinput_d01"))
mech              <- "iag"        # iag_cb05v2, neu_cb05, iag_racm
aer               <- "pmneu2"          # pmiag, pmneu
source('scripts/mech.R', encoding = 'UTF-8')


# WRF CHEM
language          <- "portuguese" # english spanish 
# hourly distribution for NOx with HDV
# hourly distribution for other than NOX with PC
tfs               <- readRDS("config/tfs.rds")
year              <- 2018
months_subset     <- 8   #only one month each time
cols              <- 99 # da grade
rows              <- 149 # da grade
wrf_times         <- 24 # ?
data("emis_opt")# names(emis_opt)
emis_option       <- emis_opt$ecb05_opt1
emis_option[length(emis_option)]<- "E_PM_10"
pasta_wrfinput    <- system.file("extdata",
                                 package = "eixport")
pasta_wrfchemi    <- "wrf"
wrfi              <- paste0(system.file("extdata",
                                        package = "eixport"),
                            "/wrfinput_d01")
domain           <- 1
wrf_times        <- 24
hours            <- 0
lt_emissions     <- "2011-07-25 00:00:00"
source("scripts/wrf.R", encoding = "UTF-8")