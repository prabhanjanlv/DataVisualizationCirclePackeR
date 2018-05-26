#intall packages
'
install.packages("devtools")
install.packages("shiny")
install.packages("readxl")
devtools::install_github("jeromefroe/circlepackeR")
install.packages("data.tree")
install.packages("jsonlite")
'

library(shiny)
library(readxl)
library(circlepackeR)
library(data.tree)
library(jsonlite)
library(gplots)
#Reading the Excel File and inputing into the dataset called testdata#
testdata <- read_excel("dummy.xlsx", col_types = c("text", 
                                                   "text", "text", "text", "text", "text", 
                                                   "numeric", "text", "numeric", "text"))
# Changing the format. This uses the data.tree library. This library needs a column that looks like root/group/subgroup/..., so I build it #
'testdata=data.frame(testdata)
testdata$pathString <- paste("world", testdata$group, testdata$subgroup, testdata$subsubgroup, sep = "/")
population <- as.Node(testdata)'

root=toJSON(testdata$root)
group=toJSON(testdata$group)
sgroup=toJSON(testdata$subgroup)
ssgroup=toJSON(testdata$subsubgroup)
sssgroup=toJSON(testdata$subsubsubgroup)
ssssgroup=toJSON(testdata$subsubsubsubgroup)
dvalue=toJSON(testdata$`Dollar Value`)
color=toJSON(testdata$`Color Name`)
transparency=toJSON(testdata$Transparency)
desc=toJSON(testdata$Description)

'data1=toJSON(testdata,auto_unbox=TRUE,dataframe="rows")
data1=toJSON(testdata,auto_unbox=TRUE,dataframe="columns")'


rgb = t(col2rgb(testdata$`Color Name`))
rbind(rgb)
alpha=testdata$Transparency
testdatacolors=cbind(rgb,alpha)
testdatacolors=as.data.frame(testdatacolors)
testdatacolors$rgba=paste("rgba(",testdatacolors$red,",",testdatacolors$green,",",testdatacolors$blue,",",testdatacolors$alpha,")")
testdata$rgba=testdatacolors$rgba
rgb=toJSON(testdata$rgba)

'dt<-testdata
dt=dt[,c("root","group","subgroup","subsubgroup","Dollar Value")]
dt$pathString<-paste(dt$root,dt$group,dt$subgroup,dt$subsubgroup,sep="/")
`Dollar Value`<-as.Node(dt)
data = as.list(`Dollar Value`, mode = "explicit", unname = TRUE,nameName="name", childrenName="children")
data = jsonlite::toJSON(data, auto_unbox = TRUE,dataframe = "rows")
cat(data)'

dt<-testdata
dt$color<-dt$rgba
dt=dt[,c("root","group","subgroup","subsubgroup","Dollar Value","color")]
dt$pathString<-paste(dt$root,dt$group,dt$subgroup,dt$subsubgroup,sep="/")
`Dollar Value`<-as.Node(dt)
data = as.list(`Dollar Value`, mode = "explicit", unname = TRUE)
data = jsonlite::toJSON(data, pretty=TRUE,flatten=TRUE,auto_unbox = TRUE)
'data1 = HTMLWidgets.dataframeToD3(data)'



ui = fluidPage(
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
            tags$div(id = "transparency", style="display: none;", transparency),
            tags$div(id = "rgb", style="display: none;", rgb),
            tags$div(id = "desc", style="display: none;", desc),
            tags$div(id = "data", style="display: none;", data)),
  circlepackeROutput('test')
)

server = function(input, output, session) {
  output$test=renderCirclepackeR(testdata)
  'output$Venkat<-data1'
  observe({
    'query <- parseQueryString(session$clientData$url_search)
    if (!is.null(query[["text"]])) {
    updateTextInput(session, "text", value = query[["text"]])'
    
    })
  }
shinyApp(ui = ui, server = server)