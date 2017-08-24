library(shinyscaffold)

scaffold_config("~/tmp/app/config.yml")
setwd("~/tmp")
scaffold_app("~/tmp/app/config.yml", overwrite = TRUE)


setwd("~/tmp")
scaffold_app("~/tmp/config.yml", overwrite = TRUE)
