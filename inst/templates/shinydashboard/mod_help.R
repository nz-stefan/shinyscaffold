###########################################################
# Help descriptions of the {{id-capital}} module
#
# Author: {{author}}
# Created: {{creation_date}}
###########################################################


{{id}}ModuleHelp <- function(id) {
  ns <- NS(id)

  help_defs <- list(
    list(
      id = ns("headline-help"),
      help = "Some help message specific to the {{name}} module"
    )
  )

  data.frame(
    element = lapply(help_defs, function(x) paste0("#", x$id)) %>% unlist(),
    intro = lapply(help_defs, function(x) x$help) %>% unlist()
  )
}
