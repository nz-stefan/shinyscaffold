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
