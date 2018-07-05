#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#




library(shiny)

## ui.R ##
library(shinydashboard)

dashboardPage( skin = "red",
  dashboardHeader(title = "OptiFind", titleWidth = 250),
  dashboardSidebar(width = 250,
    sidebarMenu(
      menuItem("Dashboard",tabName = "Dashboard", icon = icon("dashboard")),
      menuItem("Account",tabName = "Account", icon = icon("account"))
      )
  ),

 
    
  body <- dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
      font-family: "Georgia", Times, "Times New Roman", serif;
      font-weight: bold;
      font-size: 24px;
      }
      '))),
    
    tags$style(HTML("
            .btn {
                    color: #2ecc71;
                    border: 2px #2ecc71 solid;
                    }
                    .btn:hover {
                    color: #fff;
                    background-color: #2ecc71;
                    }
                    .btn-default.active, .btn-default:active, .open > .dropdown-toggle.btn-default {
                    color: #fff;
                    background-color: #2ecc71;
                    border-color: #2ecc71;
                    align: right;
                    }
                    ")),
    
    
    fluidRow(
      tabBox(
        title = "OptiFind Image Detector",
        # The id lets us use input$tabset1 on the server to find the current tab
        id = "tabset1", height = "500px", width = "match_parent",
        tabPanel("Image Uplaoder", "Please Uplaod your image here"),
        
        
        br(),
        br(),
        br(),
        actionButton("button", "UPLOAD") 
      )
     
    )
  ),
  
  shinyApp(
    ui = dashboardPage(
      dashboardHeader(title = "tabBoxes"),
      dashboardSidebar(),
      body
    ),
    server = function(input, output) {
      # The currently selected tab from the first box
      output$tabset1Selected <- renderText({
        input$tabset1
      })
    }
  )
)