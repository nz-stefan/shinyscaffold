###########################################################
# UI definitions for the app
#
# Author: {{author}}
# Created: {{creation_date}}
###########################################################


# Header ------------------------------------------------------------------

db_header <- dashboardHeader(
  title = "{{title}}",
  tags$li(class = "dropdown", actionButton("intro", "Help", icon = icon("question-circle"), class = "btn-help")))


# Sidebar -----------------------------------------------------------------

db_sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "tabs",
    {{#modules}}
    menuItem("{{value.name}}", tabName = "{{value.id}}", icon = icon("{{value.icon}}")),
    {{/modules}}
    .list = NULL
  ),
  collapsed = {{style.side-bar-collapsed}}
)


# Body --------------------------------------------------------------------

db_body <- dashboardBody(
  # include shinyjs globally (must be included once only)
  useShinyjs(),
  introjsUI(),

  # add CSS customizations
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "assets/css/style.css")
  ),
  {{#style.make-side-bar-collapsed}}
  # make sidebar collapse when a menu item is clicked
  tags$script("$('.sidebar-menu a').click(function (e) {
              $('body').addClass('sidebar-collapse');
              $('body').removeClass('sidebar-open');
              });"),
  {{/style.make-side-bar-collapsed}}
  {{#style.restrict-max-width}}
  # set a max width for the content (looks nicer on larger screens)
  # change max width in the CSS file
  tags$script("$('.content-wrapper').addClass('fixed-width');"),
  {{/style.restrict-max-width}}
  # add content for each menu item
  tabItems(
    {{#modules}}
    ## {{value.name}} --------------

    tabItem(
      tabName = "{{value.id}}",
      {{value.id}}ModuleUI("{{value.id}}_module")
    ),

    {{/modules}}
    tabItem("dummy")
  )
)


# Dashboard ---------------------------------------------------------------

ui <- dashboardPage(
  db_header,
  db_sidebar,
  db_body,
  skin = "{{style.dashboard-skin}}"
)
