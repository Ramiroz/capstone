#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Define UI for application
shinyUI(fluidPage(theme = shinytheme("superhero"),
                  
          navbarPage("Word Prediction",
                     tabPanel("Prediction",
                              textInput("text", label = h3("Text Prediction Model"),width = 500),
                              
                              hr(),
                              h4("Top used words"),
                              actionButton("button1",label = textOutput("value1")),
                              actionButton("button2",label = textOutput("value2")),
                              actionButton("button3",label = textOutput("value3")),
                              actionButton("button4",label = textOutput("value4")),
                              actionButton("button5",label = textOutput("value5"))
                     ),
                     tabPanel("How it works",
                              
                              img(src = "wordprediction.gif",  height = 303, width = 535),
                              h4("1- Start writing your sentence"),
                              h4("2- Once you hit a 'space'"),
                              h4("3- The top predicted words would show in the 5 boxes below"),
                              h4("4- Either type the word followed by 'space' or click the box with the most suitable predicted word"),
                              h4("5- You can toggle between the boxes by hitting 'tab' then selecting the word by 'Enter'")
                              
                     ),
                     tabPanel("About",
                              h4("This Application is part of Coursera 'Data Science Specialization' Capstone Project"),
                              hr(),
                              h4(strong("by Ramy Hashem"))
                     ),
                     tabPanel("Acknowledgment",
                              hr(),
                              h3("Special thanks to Johns Hopkins University and the great professors Brian Caffo, Jeff Leek and Roger D. Peng"),
                              hr(),
                              h4("Thanks to my family and friends who supported me during the specialization"),
                              hr(),
                              h4("Acknowledgements to great resources on the internet on 'Natural Language Processing'"),
                              hr(),
                              h5("Youtube Video Estimating N-gram Probabilities - Stanford NLP - Professor Dan Jurafsky & Chris"),
                              a("https://www.youtube.com/watch?v=o-CvoOkVrnY&t=66s"),
                              h5("Youtube Video Markov Processes - Columbia University"),
                              a("https://www.youtube.com/watch?v=ruU_Y0iCMDA"),
                              h5("The great guide of Michael Szczepaniak - Predicting Next Word Using Katz Back-Off"),
                              a("https://rpubs.com/mszczepaniak/predictkbo3model"),
                              hr(),
                              h4("And Finally Special Thanks to All colleagues who contributed strongly in the course Forum")
                              
                     )
          )
))
