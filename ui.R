fluidPage(
  textOutput("Venkat"), 
  htmlTemplate("www/index.html"), 
  tags$head(tags$script(src="hoge.js"),
  tags$div(id = "root", style="display: none;", root), 
  tags$div(id = "group", style="display: none;", group),
  tags$div(id = "sgroup", style="display: none;", sgroup), 
  tags$div(id = "ssgroup", style="display: none;", ssgroup),
  tags$div(id = "sssgroup", style="display: none;", sssgroup), 
  tags$div(id = "ssssgroup", style="display: none;", ssssgroup), 
  tags$div(id = "dvalue", style="display: none;", dvalue), 
  tags$div(id = "color", style="display: none;", color), 
  tags$div(id = "transparency", style="display: none;", transparency))
)