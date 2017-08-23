#' Create Shiny module boilerplate code
#' @description Creates the boilerplate code for a Shiny module
#' @details
#' The function creates a directory in \code{<APP_ROOT>/modules/<MODULE_ID>} in
#' which seperate files \code{ui.R}, \code{server.R}, \code{global.R},
#' \code{utils.R} and \code{help.R} are created. The files contain boilerplate
#' code to setup the module along with some basic examples to describe the usage
#' of the module. To include the module, the module's \code{global.R} must be
#' sourced in the app's main \code{global.R} and the module's UI and server
#' functions need to be called in the app's main \code{ui.R} and
#' \code{server.R} files.
#' @param app_dir Path to root directory of the Shiny app
#' @param app_template App template to use for the module. Currently only
#' "shinydashboard" is supported.
#' @param module_config Configuration of the module in the form of a list, e.g.
#' \code{list(id = "overview", name = "Overview Module")}
#' @param overwrite Logical indicating whether existing module files should be
#' overwritten. Default is \code{FALSE}.
#' @examples
#' module_conf <- list(
#'   id = "overview",
#'   name = "Overview"
#' )
#' scaffold_module("app", "shinydashboard", module_conf)
scaffold_module <- function(app_dir, app_template, module_config, overwrite = FALSE) {
  # create module directory
  mod_dir <- file.path(app_dir, "modules", module_config$id)
  dir.create(mod_dir, recursive = TRUE, showWarnings = FALSE)

  # add generated variables
  module_config$creation_date <- Sys.Date()
  module_config$`id-capital` <- toupper(module_config$id)

  for(templ in c("global.R", "server.R", "ui.R", "help.R", "utils.R")) {
    if (file.exists(file.path(mod_dir, templ)) && !overwrite) {
      stop(sprintf("File %s already exists.", file.path(mod_dir, templ)))
    }
    process_template(
      config = module_config,
      app_template = app_template,
      template_name = paste0("mod_", templ),
      fout = file.path(mod_dir, templ)
    )
  }
}


#' Create boilerplate code from config file
#' @description Creates the boilerplate code for a Shiny app as specified in
#' a YAML configuration file.
#' @param yaml_config_file String pointing to the path of a YAML file
#' @examples
#' # export config file from package to disk
#' yaml_config_file <- system.file("config.yml", package = "shinyscaffold")
#' yaml_config <- readLines(yaml_config_file)
#' writeLines(yaml_config, con = "/tmp/config.yml")
#' # -> modify /tmp/config.yml as needed
#'
#' # scaffold app
#' setwd("/tmp")
#' scaffold_app("/tmp/config.yml")
scaffold_app <- function(yaml_config_file) {
  # load configuration from YAML file
  yaml_config <- get_config(yaml_config_file)

  # create app structure
  dirs <- c(
    "utils", "data", "modules",
    file.path("www", "assets", "css"),
    file.path("www", "assets", "images")
  )
  lapply(dirs, function(dir_name) {
    cat("Creating directory", dir_name, "...\n")
    dir.create(
      file.path(yaml_config$`app-directory`, dir_name),
      showWarnings = FALSE,
      recursive = TRUE
    )
  })

  # process main templates
  for(templ in c("global.R", "server.R", "ui.R")) {
    process_template(
      config = yaml_config,
      app_template = yaml_config$`app-template`,
      template = templ,
      fout = file.path(yaml_config$`app-directory`, templ)
    )
  }

  # process modules
  for(module in yaml_config$modules) {
    module_config <- module$value
    module_config$author <- yaml_config$author

    scaffold_module(
      app_dir = yaml_config$`app-directory`,
      app_template = yaml_config$`app-template`,
      module_config = module_config
    )
  }

  # copy assets
  copy_asset(yaml_config$`app-directory`, yaml_config$`app-template`, "style.css", "css")
  copy_asset(yaml_config$`app-directory`, yaml_config$`app-template`, "ui-utils.R", "utils")

  cat("App scaffolded\n")
}


#' List available app templates
#' @description Lists all app templates available for scaffolding
#' @examples list_app_templates()
list_app_templates <- function() {
  dir(system.file("templates", package = "shinyscaffold"))
}


#' Create scaffolding config file
#' @description Creates YAML config file with the specification of the Shiny
#' app to scaffold. The file allows configuration of modules, styles and
#' other generic app features.
#' @param outfile String of a file name where the config file is exported to.
#' If left \code{NULL}, the config is printed to stdout.
#' @examples
#' # print config to screen
#' scaffold_config()
#'
#' # write config to file
#' scaffold_config("/tmp/my-config.yml")
scaffold_config <- function(outfile = NULL) {
  yaml_config_file <- system.file("config.yml", package = "shinyscaffold")
  yaml_config <- readLines(yaml_config_file)

  if (is.null(outfile)) {
    cat(paste(yaml_config, collapse = "\n"))
  } else {
    writeLines(yaml_config, con = outfile)
  }
}


get_config <- function(yaml_config_file) {
  # load yaml config
  yaml_config <- yaml.load_file(yaml_config_file)

  # convert sequence items into a list format that whisker understands
  yaml_config$modules <- iteratelist(yaml_config$modules)

  # add generated variables
  yaml_config$creation_date <- Sys.Date()

  yaml_config
}


process_template <- function(config, app_template, template_name, fout) {
  # load template
  templ_file <- system.file(file.path("templates", app_template), template_name, package = "shinyscaffold")
  templ <- readLines(templ_file)

  # render template and export to file
  cat("Creating", fout, "...\n")
  writeLines(whisker.render(templ, config), con = fout)
}


copy_asset <- function(app_directory, app_template, asset_filename, asset_type) {
  if(asset_type %in% c("css", "images")) {
    dest_path <- file.path(app_directory, "www", "assets", asset_type)
  } else if(asset_type == "utils") {
    dest_path <- file.path(app_directory, "utils")
  } else {
    stop("Unknown asset type. Must be one of c('css', 'images', 'utils')")
  }

  cat("Copying asset", asset_filename,"...\n")

  file.copy(
    from = system.file(file.path("templates", app_template), "assets", asset_filename, package = "shinyscaffold"),
    to = file.path(dest_path, asset_filename)
  )
}
