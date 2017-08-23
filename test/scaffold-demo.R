library(shinyscaffold)

yaml_config_file <- system.file("config.yml", package = "shinyscaffold")
yaml_config <- readLines(yaml_config_file)
writeLines(yaml_config, con = "~/tmp/app/config.yml")

setwd("~/tmp")
scaffold_app("~/tmp/app/config.yml")
