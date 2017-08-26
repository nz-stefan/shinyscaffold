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
    div(tags$img(src = "assets/images/banner.png"), id = "page-banner")
  ),

  {{#modules}}
  tabPanel("{{value.name}}", value = "{{value.id}}", {{value.id}}ModuleUI("{{value.id}}_module")),
  {{/modules}}
  {{#style.restrict-max-width}}
  # set a max width for the content (looks nicer on larger screens)
  # change max width in the CSS file
  footer = tagList(
    tags$script("$('.navbar-default').addClass('fixed-width');"),
    tags$script("$('nav + .container-fluid').addClass('fixed-width')"),
    tags$script("$('#page-banner').addClass('fixed-width')")
  ),
  {{/style.restrict-max-width}}
  help_ui = div(
    style = "text-align: right;",
    actionButton("intro", "Help", icon = icon("question-circle"), class = "btn-help")
  )
)
