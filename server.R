function(input, output, session) {
  'output$testing<-data1'
  observe({
    'query <- parseQueryString(session$clientData$url_search)
    if (!is.null(query[["text"]])) {
    updateTextInput(session, "text", value = query[["text"]])'
    
    })
  }