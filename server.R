#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


shinyServer(function(input, output, session) {
   
    results <- NULL
    
    results <- ngram_result(" ") # first time run, get the most frequent words.. ie. uni-gram words
    
    output$value1 <- renderText(names(results[1])) # set the action button name with the most freq uni-gram words
    output$value2 <- renderText(names(results[2]))
    output$value3 <- renderText(names(results[3]))
    output$value4 <- renderText(names(results[4]))
    output$value5 <- renderText(names(results[5]))
    
    # when actionbutton is clicked, rename the value of the text box to be existing text + predicted word + space
    observeEvent(input$button1, { 
        updateTextInput(session, "text", value = paste0(input$text, names(results[1]), " ")) 
    })
    observeEvent(input$button2, {
        updateTextInput(session, "text", value = paste0(input$text, names(results[2]), " "))
    })
    observeEvent(input$button3, {
        updateTextInput(session, "text", value = paste0(input$text, names(results[3]), " "))
    })
    observeEvent(input$button4, {
        updateTextInput(session, "text", value = paste0(input$text, names(results[4]), " "))
    })
    observeEvent(input$button5, {
        updateTextInput(session, "text", value = paste0(input$text, names(results[5]), " "))
    })
    
    # observe input$text, if there is space at the end then start the prediction
    observe({   
        if (grepl(" $", input$text)) { # detects "space" at the end of the sentence
            results <<- ngram_result(input$text) # <<- for results to be a global variable
            output$value1 <- renderText(names(results[1])) #set actionbutton value with highest predicted word
            output$value2 <- renderText(names(results[2])) #set actionbutton value with 2nd highest predicted word
            output$value3 <- renderText(names(results[3]))
            output$value4 <- renderText(names(results[4]))
            output$value5 <- renderText(names(results[5]))
        }
    })
    
})
