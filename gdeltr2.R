library(gdeltr2)

sports_terms <-
  c('"Brooklyn Nets"', "Caris LeVert", '"Kyrie Irving" Trade', '"Luka Doncic"',
    'NBA "Draft Prospect"', '"Jarrett Allen"')

political_terms <-
  c('"Bill Perkins"', '"New York City" "City Counsel"')

finance_real_estate_terms <-
  c("Eastdil", "Condo Bubble", '"JBG Smith"', '"CPPIB"', "Anbang",
    "WeWork", '"Goldman Sachs"' , 'Blackstone "Real Estate"')

other_terms <-
  c("Supergoop", '"LNG"', 'Maryland "High School Football"',
    '"Jared Kushner"', '"Eddie Huang"')

my_terms <-
  c(sports_terms, political_terms, finance_real_estate_terms, other_terms)


news_domains <-
  c("nypost.com", "washingtonpost.com", "wsj.com", "gothamgazette.com")

sports_domains <-
  c("espn.com", "netsdaily.com")

finance_real_estate_domains <-
  c("realdeal.com", "zerohedge.com", "institutionalinvestor.com", 'pionline.com',
    "curbed.com", "archdaily.com")

random_domains <-
  c("tmz.com", "snopes.com", "alphr.com", "oilprice.com")

my_domains <-
  c(news_domains, sports_domains, finance_real_estate_domains, random_domains)


df_gkg <- 
  get_gdelt_codebook_ft_api(code_book = "gkg")

View(df_gkg)


df_gkg <-
  gdeltr2::get_gdelt_codebook_ft_api(code_book = "gkg")

my_themes <-
  c("ECON_WORLDCURRENCIES_CHINESE_YUAN", # stories about china's currency -- god way to find stories about china's economy
    "ECON_BUBBLE", # articles about economic bubble
    "TAX_FNCACT_BROKER", # articles about brokers of things
    "ECON_HOUSING_PRICES", # articls about housing prices
    "ECON_BITCOIN", # articles about bitcoin
    "ELECTION_FRAUD", # articles about election fraud
    "SOC_POINTSOFINTEREST_GOVERNMENT_BUILDINGS", # articles about government buildings
    "WB_1277_BANKRUPTCY_AND_LIQUIDATION", # articles about bankruptcy
    "WB_639_REPRODUCTIVE_MATERNAL_AND_CHILD_HEALTH", # articles about pregnancy and child health
    "WB_2151_CHILD_DEVELOPMENT", # articles about child development
    "TAX_FNCACT_BUILDER" # articles about builders
  )

set.seed(1234)

random_themes <-
  df_gkg %>% pull(idGKGTheme) %>% sample(3)

my_themes <- 
  c(my_themes, random_themes)




my_ocr <-
  c(
    "Brooklyn Nets",
    "Panerai",
    "Four Seasons",
    "NBA",
    "Goldman Sachs",
    "Philadelphia Eagles",
    "Supergoop",
    "Boston Celtics",
    "Big Baller Brand",
    "BBB",
    "Boston Properties"
  )


df_imagetags <-
  get_gdelt_codebook_ft_api(code_book = "imagetags")

View(df_imagetags)


my_image_tags <-
  c("Toy Poodle", # looks for toy poodles
    "poodle", # looks for any form of poodle
    "commercial building", # looks for an office building
    "basketball player", # looks for a professional basketball player
    "supermodel" # take a guess :)s
  )

df_imageweb <-
  get_gdelt_codebook_ft_api(code_book = "imageweb")

View(df_imageweb)


my_image_web <-
  c(
    "Jared Kushner",
    "Empire State Building",
    "Serena Williams",
    "New York City",
    "Ivanka Trump",
    "Tesla Model 3",
    "Jeremy Lin",
    "NBA",
    "Brooklyn Nets"
  )



my_timespan <- 
  "5 days"



df_countries <- 
  get_gdelt_codebook_ft_api(code_book = "countries")

View(df_countries)



my_trelliscope_parameters <-
  list(
    rows = 1,
    columns = 2,
    path = NULL
  )

get_data_ft_v2_api(terms = my_terms, domains = my_domains, images_web_tag = my_image_web, 
                   images_tag = my_image_tags, images_ocr = my_ocr, gkg_themes = my_themes, 
                   modes = c("Artlist"), timespans = my_timespan, trelliscope_parameters = my_trelliscope_parameters)


trelliscopeImage


get_data_ft_v2_api(terms = my_terms, domains = my_domains, images_web_tag = my_image_web, 
                   images_tag = my_image_tags, images_ocr = my_ocr, gkg_themes = my_themes, 
                   modes = c("TimelineVolInfo"), timespans = "12 weeks", trelliscope_parameters = my_trelliscope_parameters)



trelliscopeHighcharter


get_data_ft_v2_api(terms = my_terms, domains = my_domains, images_web_tag = my_image_web, 
                   images_tag = my_image_tags, images_ocr = my_ocr, gkg_themes = my_themes, 
                   modes = c("WordCloudEnglish", "WordCloudTheme", "WordCloudImageTags", "WordCloudImageWebTags"), 
                   timespans = "2 weeks", trelliscope_parameters = list(rows = 1, columns = 1, 
                                                                        path = NULL))


trelliscopeWordcloud

options(viewer =  NULL)