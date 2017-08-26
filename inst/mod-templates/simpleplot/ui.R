###########################################################
# UI definitions of the {{id-capital}} module
#
# Author: {{author}}
# Created: {{creation_date}}
###########################################################

{{id}}ModuleUI <- function(id) {
  # obtain namespace
  ns <- NS(id)

  tagList(
    # TODO: add UI elements here
    div(
      id = ns("headline-help"),
      h3("{{name}}")
    ),
    material_card(
      div(id = ns("plot-help"), highchartOutput(ns("plot")))
    )
  )
}
