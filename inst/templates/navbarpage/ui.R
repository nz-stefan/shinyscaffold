###########################################################
# UI definitions for the app
#
# Author: {{author}}
# Created: {{creation_date}}
###########################################################


ui <- myNavbarPage(
  id = "tabs",
  nav_header = tagList(
    # include shinyjs globally (must be included once only)
    useShinyjs(),
    introjsUI(),
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "assets/css/style.css")),
    tags$img(src = "assets/images/banner.png")
  ),

  {{#modules}}
  tabPanel("{{value.name}}", value = "{{value.id}}", {{value.id}}ModuleUI("{{value.id}}_module")),
  {{/modules}}
  help_ui = div(
    style = "text-align: right;",
    actionButton("intro", "Help", icon = icon("question-circle"), class = "btn-help")
  )
)
