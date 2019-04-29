# ---------- Install and charge packages and data ----------
if (!require("tidyverse")) {install.packages("tidyverse")}
library(tidyverse)

if (!require("shiny")) {install.packages("shiny")}
library(shiny)

if (!require("shinydashboard")) {install.packages("shinydashboard")}
library(shinydashboard)

if (!require("shinyWidgets")) install.packages("shinyWidgets")
library(shinyWidgets)

if (!require("plotly")) install.packages("plotly")
library(plotly) #Used for plot interactivity

if (!require("reshape2")) install.packages("reshape2")
library(reshape2) #Used for the melt function to convert a dataframe from tidy to long format

load("PokeData.RData")
# --------------------------------------------------------



# ---------------------- UI ------------------------------
ui <- dashboardPage(skin='red',
                    
        dashboardHeader(title = "Pokedex Analysis"),                            
        dashboardSidebar( 
      
          sidebarMenu(
            br(),
            HTML('<h3>&nbsp;&nbsp;&nbsp;Constraints</h3>'),
            id = "tabs",

            menuItem(h4('Statistics'), tabName = 'stats',
                   
              menuItem('HP',
                  
                menuItem(
                              
                  sliderInput(inputId = 'HPSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$HP), max = max(pokedata$HP), 
                              value = c(min(pokedata$HP), max = max(pokedata$HP)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                            
              ),
                   
              menuItem('Attack',
                            
                menuItem(
                              
                  sliderInput(inputId = 'AtkSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$Attack), max = max(pokedata$Attack), 
                              value = c(min(pokedata$Attack), max = max(pokedata$Attack)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                
              ),
                   
              menuItem('Defense',
                       
                menuItem(
                         
                  sliderInput(inputId = 'DefSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$Defense), max = max(pokedata$Defense), 
                              value = c(min(pokedata$Defense), max = max(pokedata$Defense)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                       
              ),
                   
              menuItem('Sp. Attack',
                            
                menuItem(
                         
                  sliderInput(inputId = 'SpAtkSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$Sp_Atk), max = max(pokedata$Sp_Atk), 
                              value = c(min(pokedata$Sp_Atk), max = max(pokedata$Sp_Atk)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                       
              ),
                   
              menuItem('Sp. Defense',
                            
                menuItem(
                         
                  sliderInput(inputId = 'SpDefSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$Sp_Def), max = max(pokedata$Sp_Def), 
                              value = c(min(pokedata$Sp_Def), max = max(pokedata$Sp_Def)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                            
              ),
                   
              menuItem('Speed',
                            
                menuItem(
                              
                  sliderInput(inputId = 'SpeedSlider',
                              label = NULL,                                                                                       
                              min = min(pokedata$Speed), max = max(pokedata$Speed), 
                              value = c(min(pokedata$Speed), max = max(pokedata$Speed)),
                              step = 1,
                              sep = ""
                  )
                  
                )
                            
              )
          
            ),
  
            menuItem(h4('Legendariness'), tabName = 'isLegendary',
                 
              menuItem(
                            
                checkboxGroupInput(inputId = "isLegendary",
                                   label = NULL,               
                                   choices = list("Legendary Pokemon" = "TRUE", 
                                                  "Non-legendary Pokemon" = "FALSE")
                                   
                )
                
              )
                 
            ),
        
            menuItem(h4('Alternate form'), tabName = 'isAlternate',
                
              menuItem(
                   
                checkboxGroupInput(inputId = "isAlternate",
                                   label = NULL,               
                                   choices = list("Alternate forms" = "TRUE", 
                                                  "Vanilla forms" = "FALSE"),
                                   selected='FALSE'
                                   
                )
                
              )
                 
            ),
        
            menuItem(h4('Types'), tabName = 'type_chk',
                          
              menuItem("Type 1",
                            
                checkboxGroupInput(inputId = "type1",
                                   label = NULL,
                                   choices = list ("Bug" = "Bug",
                                                   "Dark" = "Dark",
                                                   "Dragon" = "Dragon",
                                                   "Electric" = "Electric",
                                                   "Fairy" = "Fairy",
                                                   "Fighting" = "Fighting",
                                                   "Fire" = "Fire",
                                                   "Flying" = "Flying",
                                                   "Ghost" = "Ghost",
                                                   "Grass" = "Grass", 
                                                   "Ground" = "Ground",
                                                   "Ice" = "Ice",
                                                   "Normal" = "Normal",
                                                   "Poison" = "Poison",
                                                   "Psychic" = "Psychic",
                                                   "Rock" = "Rock",
                                                   "Steel" = "Steel",
                                                   "Water" = "Water")
                                          
                  )
                       
              ),
                          
              menuItem("Type 2",
                            
                checkboxGroupInput(inputId = "type2",
                                   label = NULL,
                                   choices = list ("None" = "None",
                                                   "Bug" = "Bug",
                                                   "Dark" = "Dark",
                                                   "Dragon" = "Dragon",
                                                   "Electric" = "Electric",
                                                   "Fairy" = "Fairy",
                                                   "Fighting" = "Fighting",
                                                   "Fire" = "Fire",
                                                   "Flying" = "Flying",
                                                   "Ghost" = "Ghost",
                                                   "Grass" = "Grass", 
                                                   "Ground" = "Ground",
                                                   "Ice" = "Ice",
                                                   "Normal" = "Normal",
                                                   "Poison" = "Poison",
                                                   "Psychic" = "Psychic",
                                                   "Rock" = "Rock",
                                                   "Steel" = "Steel",
                                                   "Water" = "Water")
                )
                            
              )
                 
            ),
          
            menuItem(h4('Generation'), tabName = 'gen',
                             
              menuItem(
                               
                checkboxGroupInput(inputId = "generation",
                                   label = NULL,               
                                   choices = list("Gen. 1" = "1", 
                                                  "Gen. 2" = "2",
                                                  "Gen. 3" = "3",
                                                  "Gen. 4" = "4",
                                                  "Gen. 5" = "5",
                                                  "Gen. 6" = "6")
                                   
                )
                
              )
                   
            )

          )
        
        ),
        
    dashboardBody(
      
      tabBox(title = "", id = "tabbox1", height = "1920px", width = "1080px",
             tabPanel("Best overall Pokemon",
          
              fluidRow(
                   
                box(
                  title=textOutput("pokeName"),
                  background = 'red',
                  width=7,
                  height="300px",
                  box(
                    width=4,
                    htmlOutput("picture")
                  ),
                  
                  box(
                    width=8,
                    plotlyOutput("currentMatchStat", height="200px")
                  )
                     
                ),
                
                box(
                  title="Top Pokemons satisfying the constraints",
                  width=5,
                  height="300px",
                  background = "red",
                  box(
                    width=12,
                    plotlyOutput("top6Stacked", height = "200px")
                  )
                )
              ),
                 
                 
              fluidRow(
                
                box(
                  title="Synthetic view of the Pokemon satisfying the constraints",
                  width=12,
                  background ="red",
                  height="300px",
                  
                  box(
                    width=12,
                    plotlyOutput("syntView", height="200px")
                  )
                )
              )
            ),
                 
            tabPanel("Best Pokemons based on specific statistics",
                 
                     fluidRow(
                       
                       box(
                         title="Top Pokemon in terms of HP",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_HP', height='200px')
                         )
                       ),
                       
                       box(
                         title="Top Pokemon in terms of Attack",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_Attack', height='200px')
                         )
                       ),
                       
                       box(
                         title="Top Pokemon in terms of Defense",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_Defense', height='200px')
                         )
                       )
                     ),
                     
                     fluidRow(
                       
                       box(
                         title="Top Pokemon in terms of Sp. Attack",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_Spatk', height='200px')
                         )
                       ),
                       
                       box(
                         title="Top Pokemon in terms of Sp. Defense",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_Spdef', height='200px')
                         )
                       ),
                       
                       box(
                         title="Top Pokemon in terms of Speed",
                         background = 'red',
                         width=4,
                         height="300px",
                         box(
                           width=12,
                           plotlyOutput('top6Stacked_Speed', height='200px')
                         )
                       )
                     )
                    
              
            ),
            
            tabPanel("Data table",
              
              #Styling of the table using css              
              tags$style(HTML('table.dataTable tr:nth-child(even) {background-color: #fae1de !important;}')),
              tags$style(HTML('table.dataTable th {background-color: #e15e4e !important;color:white;}')),       
              DT::dataTableOutput("dataTable")
                     
            )
            
          )
      
      )
    
)
# ----------------------------


# ---------- SERVER ----------
server <- function(input, output){
  
  data <- reactive({
    
    #Filter pokemon statistics
    buffer <- pokedata
    
    #HP
    buffer <- buffer %>%      
      filter(HP >= input$HPSlider[1], HP <= input$HPSlider[2])
    
    #Attack
    buffer <- buffer %>%      
      filter(Attack >= input$AtkSlider[1], Attack <= input$AtkSlider[2]) 
    
    #Defense
    buffer <- buffer %>%      
      filter(Defense >= input$DefSlider[1], Defense <= input$DefSlider[2]) 
    
    #Sp.Attack
    buffer <- buffer %>%      
      filter(Sp_Atk >= input$SpAtkSlider[1], Sp_Atk <= input$SpAtkSlider[2]) 
    
    #Sp. Defense
    buffer <- buffer %>%      
      filter(Sp_Def >= input$SpDefSlider[1], Sp_Def <= input$SpDefSlider[2]) 
    
    #Speed
    buffer <- buffer %>%      
      filter(Speed >= input$SpeedSlider[1], Speed <= input$SpeedSlider[2]) 
    
    #Type 1
    if(length(input$type1)>0){
      buffer <- buffer %>%
        filter(Type_1 %in% input$type1)
    }
    
    #Type 2
    if(length(input$type2)>0){
      buffer <- buffer %>%
        filter(Type_2 %in% input$type2)
    }
    
    #Filter legendary status
    if (length(input$isLegendary)>0){
      buffer <- buffer %>%
        filter(Legendary %in% input$isLegendary)
    } 
    
    #Filter alternate-vanilla form
    if (length(input$isAlternate)>0){
      buffer <- buffer %>%
        filter(Alternate %in% input$isAlternate)
    } 
    
    #Filter generation
    if (length(input$generation)>0){
      buffer <- buffer %>%
        filter(Generation %in% input$generation)
    } 
    
    #Check Emptyness
    if (dim(buffer)[1]==0){
      buffer <- pokedata[314,] #Return #389 Slaking in case of no data available (a specific message is added later)
      buffer$Name <- "Empty" #This serves to signal that no data correspond to the constraint, even if a line is returned
    } 
    
    return(buffer)
    
  })
  
  
  
  #Simple display of a subset of the filtered data table
  output$dataTable <- DT::renderDataTable({data()[c("Id", "Full_Name", "Generation", "Type_1", "Type_2", "HP", "Attack", "Defense", "Sp_Atk", "Sp_Def", "Speed")]}, options=list(pageLength=14))
  
  
  
  #Get the best overall pokemon under constraints
  bestMatch <- reactive({
    
    bestMatch <- arrange(data(), desc(Total)) %>% head(1)
    
    return(bestMatch)
    
  })
  
  
  
  #Get the name of the best overall Pokemon (or display a message in case of no data to display)
  getName <- reactive({
    
    if (data()$Name=="Empty"){
      
      return(toupper("No data to display, please enjoy this wild Slaking instead (:"))
      
    } else {
      
      return(paste(paste('#',bestMatch()$Id, sep=""),toupper(bestMatch()$Full_Name), sep=" "))
      
    }
    
  })
  
  
  
  #Render the name of the best overall Pokemon (or no data message)
  output$pokeName <- renderText({getName()})
  

  
  output$top6Stacked <- renderPlotly({
    
    #Select top 6 entries and format it in long format (necessary for a stack barplot)
    plotStackData <- arrange(data(), desc(Total)) %>% head(6) %>% melt(id.vars=4:7,8:13)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Total) , y = value, label=value, fill=variable, text=paste(variable,": ", value))) + 
                 geom_bar(stat="identity", position='stack', col='black', alpha=.6) + xlab("") + ylab("") + labs(fill='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  
  
  #Display the best Pokemon's statistics as a histogram
  output$currentMatchStat <- renderPlotly({
    
    #New dataframe to gather the best Pokemon's statistics
    currentStats <- data.frame(Statistic=c('HP', 'Attack', 'Defense', 'Sp. Attack', 'Sp. Defense', 'Speed'), Value=c(bestMatch()$HP, bestMatch()$Attack, bestMatch()$Defense, bestMatch()$Sp_Atk, bestMatch()$Sp_Def, bestMatch()$Speed))
    currentStats$Statistic <- factor(currentStats$Statistic,levels=c('HP', 'Attack', 'Defense', 'Sp. Attack', 'Sp. Defense', 'Speed'), ordered=TRUE)
    
    #GGplot with the 'text' aesthetic trick
    statPlot <- currentStats %>% ggplot(aes(x=reorder(Statistic, desc(Statistic)), y=Value, label=Value, fill=factor(Statistic, ordered=FALSE), text=paste(Statistic,": ", Value))) + 
                                 geom_histogram(stat='identity', col="black", alpha = .6) + ylab("") + xlab("") + labs(x="", y="", fill="") + theme(legend.position = "none") + coord_flip()
    
    #Conversion to plotly
    statPlot <- ggplotly(statPlot, tooltip = 'text') %>% config(displayModeBar = F)
    
    return(statPlot)
    
  })
  
  
  
  output$syntView <- renderPlotly({
    
    #Calculate the offensivity stat
    Offensivity = round((1-((data()$HP+data()$Defense+data()$Sp_Def)/data()$Total))*100, 2)
    
    #Calculate best stat
    subdata = data()[c("HP", "Attack", "Defense", "Sp_Atk", "Sp_Def", "Speed")]
    bestStat = colnames(subdata)[max.col(subdata,ties.method="first")]
    
    #GGplot with the 'text' trick
    syntplot_gg <- ggplot(data()) + geom_point(aes(
                                      x = Offensivity, 
                                      y = Total,
                                      #size = Legendary,
                                      color = factor(bestStat), 
                                      #size=0.01, 
                                      alpha = .3, 
                                      text=paste("Name:", Full_Name,"<br\ >Types:", Type_1," - ", Type_2,"<br\ >Offensivity:", Offensivity,"%","<br\ >Sum of Statistics:", Total, "<br\ >Best Statistic: ", bestStat))) +
      labs(color="Best Statistic", x="", y="", size='', alpha='') +
      xlab("(Defensive Pokemons  <-)                                 Offensivity in %                                (->  Offensive Pokemons)") + ylab("Sum of statistics")
    
    #Conversion to plotly
    syntplot_plotly <- ggplotly(syntplot_gg, tooltip = c("text")) %>% config(displayModeBar = F)
  
    return(syntplot_plotly)
    
  })

    
  
  #Get the picture of the best overall Pokemon (from the official website) and return the link as text with HTML
  pic <- reactive({
    
    picBuffer <- arrange(data(), desc(Total)) %>% head(1)
    pokeName <- picBuffer[['Full_Name']]
    
    pictureData <- paste('<img alt="Photo of the best pokemon satisfying the constraints"
                               src="',pokedata$Picture[which(pokedata$Full_Name==pokeName)],'"
                               height="200px">', '</img>', sep = "" )
    return(pictureData)
  })
  
  
  
  #Render the picture link and HTML as text
  output$picture <- renderText({pic()})
  
  
  #Plot of the top Pokemons in terms of HP 
  output$top6Stacked_HP <- renderPlotly({
    
    #Select top 6 entries in terms of HP
    plotStackData <- arrange(data(), desc(HP)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, HP), y=HP, text=paste("Name:", Full_Name, "<br\ >HP:", HP) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#f8766d") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  #Plot of the top Pokemons in terms of Attack 
  output$top6Stacked_Attack <- renderPlotly({
    
    #Select top 6 entries in terms of Attack
    plotStackData <- arrange(data(), desc(Attack)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Attack), y=Attack, text=paste("Name:", Full_Name, "<br\ >Attack:", Attack) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#b79f00") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  #Plot of the top Pokemons in terms of Defense 
  output$top6Stacked_Defense <- renderPlotly({
    
    #Select top 6 entries in terms of Defense
    plotStackData <- arrange(data(), desc(Defense)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Defense), y=Defense, text=paste("Name:", Full_Name, "<br\ >Defense:", Defense) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#00ba38") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  #Plot of the top Pokemons in terms of Sp. Attack
  output$top6Stacked_Spatk <- renderPlotly({
    
    #Select top 6 entries in terms of Sp. Attack
    plotStackData <- arrange(data(), desc(Sp_Atk)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Sp_Atk), y=Sp_Atk, text=paste("Name:", Full_Name, "<br\ >Sp. Attack:", Sp_Atk) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#00bfc4") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  #Plot of the top Pokemons in terms of Sp. Defense 
  output$top6Stacked_Spdef <- renderPlotly({
    
    #Select top 6 entries in terms of Sp. Defense
    plotStackData <- arrange(data(), desc(Sp_Def)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Sp_Def), y=Sp_Def, text=paste("Name:", Full_Name, "<br\ >Sp. Defense:", Sp_Def) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#619cff") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  #Plot of the top Pokemons in terms of Speed
  output$top6Stacked_Speed <- renderPlotly({
    
    #Select top 6 entries in terms of Speed
    plotStackData <- arrange(data(), desc(Speed)) %>% head(6)
    
    #Vertical stacked barplot containing top 6 pokemons (or less depending on the constraints)
    plotStack <- ggplot(plotStackData, aes(x = reorder(Full_Name, Speed), y=Speed, text=paste("Name:", Full_Name, "<br\ >Speed:", Speed) )) + 
      geom_bar(stat="identity", col='black', alpha=.6, fill="#f564e3") + xlab("") + ylab("") + labs(x='', y='') + coord_flip()
    
    #During conversion to plotly, we use the unofficial "text" aestethics to control the info given on hover
    plotStack <- ggplotly(plotStack, tooltip="text") %>% config(displayModeBar = F)
    
    return(plotStack)
    
  })
  
  
  
}
# ---------------------------------


# ---------- Run the app ----------
shinyApp(ui = ui, server = server)
# ---------------------------------