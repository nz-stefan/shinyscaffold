library(shinyscaffold)

list_mod_templates()
list_app_templates()

scaffold_config("~/tmp/config.yml")

setwd("~/tmp")
scaffold_app("~/tmp/config.yml", overwrite = TRUE)
