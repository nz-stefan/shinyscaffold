scaffold_app <- function(config_yml) {
  # create app structure
  # TODO

  # load yaml config
  yaml_config_file <- system.file(file.path("templates", "shinydashboard"), "config.yml", package = "shinyscaffold")
  yaml_config <- yaml.load_file(yaml_config_file)

  yaml_config <- lapply(yaml_config, function(element) {
    if(class(element) == "list")
      iteratelist(element)
    else
      element
  })

  yaml_config$creation_date <- Sys.Date()


  # process global.R
  templ_global <- readLines(system.file(file.path("templates", "shinydashboard"), "global.R", package = "shinyscaffold"))
  cat(whisker.render(templ_global, yaml_config))

  # process server.R
  templ_server <- readLines(system.file(file.path("templates", "shinydashboard"), "server.R", package = "shinyscaffold"))
  cat(whisker.render(templ_server, yaml_config))

  # process ui.R
  templ_ui <- readLines(system.file(file.path("templates", "shinydashboard"), "ui.R", package = "shinyscaffold"))
  cat(whisker.render(templ_ui, yaml_config))
}
