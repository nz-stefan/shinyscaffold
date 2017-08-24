###########################################################
# Global utility functions
#
# Author: Stefan Schliebs
# Created: 2017-07-25
###########################################################


material_card <- function(..., header = NULL, bgcolor = "white") {
  div(
    class = "card",
    header,
    div(class = "card-content", ..., style = sprintf("background-color: %s", bgcolor))
  )
}


hc_app_theme <- function(hc) {
  theme <- hc_theme(
    colors = c("#3366CC", "#DC3912", "#FF9900", "#109618", "#990099", "#0099C6"),
    # colors = c("#d35400", "#2980b9", "#2ecc71", "#f1c40f", "#2c3e50", "#7f8c8d"),
    chart = list(style = list(fontFamily = "Open Sans")),
    title = list(
      align = "left",
      style = list(fontWeight = "normal", fontSize = "11pt")
    ),
    subtitle = list(
      align = "left",
      style = list(fontFamily = "Open Sans")
    ),
    # legend = list(align = "right", verticalAlign = "bottom"),
    legend = list(enabled = FALSE),
    xAxis = list(
      gridLineWidth = 1,
      gridLineColor = "#F3F3F3",
      lineColor = "#F3F3F3",
      minorGridLineColor = "#F3F3F3",
      tickColor = "#F3F3F3",
      tickWidth = 1
    ),
    yAxis = list(
      gridLineColor = "#F3F3F3",
      lineColor = "#F3F3F3",
      minorGridLineColor = "#F3F3F3",
      tickColor = "#F3F3F3",
      tickWidth = 1
    ),
    plotOptions = list(
      line = list(marker = list(enabled = FALSE)),
      spline = list(marker = list(enabled = FALSE)),
      area = list(marker = list(enabled = FALSE)),
      areaspline = list(marker = list(enabled = FALSE)),
      series = list(animation = list(duration = 500))
    )
  )
  theme <- structure(theme, class = "hc_theme")

  # hc %>%
  #   hc_add_theme(theme)
  theme
}

#' Modified shiny::navbarPage function
#' @description Modified shiny::navbarPage function to include content above
#' the navigation bar and a help button in the navigation bar.
myNavbarPage <- function (
  ...,
  title = "",
  id = NULL,
  selected = NULL,
  position = c("static-top", "fixed-top", "fixed-bottom"),
  help_ui = NULL,
  nav_header = NULL,
  header = NULL,
  footer = NULL,
  inverse = FALSE,
  collapsible = FALSE, collapsable,
  fluid = TRUE,
  responsive = NULL,
  theme = NULL,
  windowTitle = title)
{
  if (!missing(collapsable)) {
    shinyDeprecated("`collapsable` is deprecated; use `collapsible` instead.")
    collapsible <- collapsable
  }

  pageTitle <- title
  navbarClass <- "navbar navbar-default"

  position <- match.arg(position)
  if (!is.null(position))
    navbarClass <- paste(navbarClass, " navbar-", position, sep = "")

  if (inverse)
    navbarClass <- paste(navbarClass, "navbar-inverse")

  if (!is.null(id))
    selected <- restoreInput(id = id, default = selected)

  tabs <- list(...)
  tabset <- shiny:::buildTabset(tabs, "nav navbar-nav", NULL, id, selected)

  className <- function(name) {
    if (fluid)
      paste(name, "-fluid", sep = "")
    else name
  }

  if (collapsible) {
    navId <- paste("navbar-collapse-", p_randomInt(1000, 10000), sep = "")
    containerDiv <- div(
      class = className("container"),
      div(
        class = "navbar-header",
        tags$button(
          type = "button",
          class = "navbar-toggle collapsed",
          `data-toggle` = "collapse",
          `data-target` = paste0("#", navId),
          span(class = "sr-only", "Toggle navigation"),
          span(class = "icon-bar"),
          span(class = "icon-bar"),
          span(class = "icon-bar")
        ),
        span(class = "navbar-brand", pageTitle)
      ),
      div(class = "navbar-collapse collapse", id = navId, tabset$navList)
    )
  }
  else {
    containerDiv <- div(
      class = className("container"),
      div(
        class = "navbar-header",
        span(class = "navbar-brand", pageTitle)
      ),
      tabset$navList,
      help_ui
    )
  }

  contentDiv <- div(class = className("container"))
  if (!is.null(header))
    contentDiv <- tagAppendChild(contentDiv, div(class = "row", header))

  contentDiv <- tagAppendChild(contentDiv, tabset$content)

  if (!is.null(footer))
    contentDiv <- tagAppendChild(contentDiv, div(class = "row", footer))

  bootstrapPage(
    title = windowTitle,
    responsive = responsive,
    theme = theme,
    nav_header,
    tags$nav(class = navbarClass, role = "navigation", containerDiv),
    contentDiv
  )
}
