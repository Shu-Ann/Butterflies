library(tidyverse)
library(ggplot2)
library(leaflet)
library(shiny)


pe2<-read_csv("Butterfly_biodiversity_survey_2017_PE2.csv")
#VIS1
top5<-pe2%>%
  group_by(Site)%>%
  summarise(sum=sum(ButterflyCount))

top5<-head(top5[order(top5$sum, decreasing = TRUE),],5)
top5<-as.data.frame(top5)
#VIS2
pe2$day<-substr(pe2$Datetime,1,5)
pe2<- pe2[order(pe2$day, decreasing = FALSE),]

top5_day<-pe2%>%
  group_by(Site, day)%>%
  filter(Site%in%top5$Site)%>%
  summarise(Count=sum(ButterflyCount))


#MAP
sites<-pe2%>%
  group_by(Site)%>%
  summarise(lat=mean(Lat), lng=mean(Lon), ButterflyCount=sum(ButterflyCount))


ui<-fixedPage(fixedRow(
  column(12, div(style="height:30px;font-size:30px;",
         "SURVEY OF BUTTERFLIES IN MELBOURNE 2017"),
         fixedRow(
           column(12,div(style="height:20px;font-size:20px;",
                         "Total number of butterflies observed in 15 sites from January to March in 2017 at City of Melbourne's public green spaces"),
           fixedRow(
             column(4),
             column(8,
                    sliderInput(inputId = "butterflycount", 
                                label="Total number of butterflies",
                                min=(min(sites$ButterflyCount)),
                                max=(max(sites$ButterflyCount)),
                                value=c(min(sites$ButterflyCount),max(sites$ButterflyCount)))),
             fixedRow(
               column(4,div(style="height:20px;font-size:18px;",
                                    "Location of the survey"),br(),
              "This map illustrates the total number of recorded butterflies in each park/garden,
               with the number of butterflies as the radius of the marker.As shown in the map,Womens Peace Gardens and Royal Park recorded the most at 60, 
               while Canning/Neill St Reserve, State Library of Victoria and University Square recorded 0.",br(),br(),
               "Use the range slider on the top of the map to filter the markers shown on the map.
               "
                      ),
               column(8,leafletOutput("MAP")),
               fixedRow(
                 column(4,
                        plotOutput("VIS1")),
                 column(2,div(style="height:16px;font-size:16px;",
                             "Top Sites for Butterflies"),br(),
                        "The bar chart on the left side displays the top 5 sites with the most largest total numbers of butterflies
                                 that be recorded in 2017.",br(),
                        "From the graph on the right hand side, telling the numbers of butterflies 
                        recorded in these 5 sites by each observation date"),
                 column(6,
                        plotOutput("VIS2"))
               )
             )
           )
         )
  )
)
)
)

server <- function(input, output,session) {
  index<-reactive({
    sites[sites$ButterflyCount>=input$butterflycount[1]&sites$ButterflyCount<=input$butterflycount[2],]
    
  })
  output$MAP<-renderLeaflet({
    content <- paste("Site:",sites$Site ,"<br>",
                     "Total number of butterflis:",sites$ButterflyCount)
    leaflet(data = sites) %>% addTiles() %>%
      addCircleMarkers(
        lng=~lng, 
        lat=~lat, 
        radius = ~ButterflyCount,
        popup = paste("Site:",sites$Site ,"<br>",
                      "Total number of butterflis:",sites$ButterflyCount)
        )
      
  })
  
  observe({
    leafletProxy(mapId = "MAP", data = index()) %>%
      clearMarkers() %>%  
      addCircleMarkers(lng=~lng, 
                       lat=~lat, 
                       radius = ~ButterflyCount,
                       popup = paste("Site:",sites$Site ,"<br>",
                                     "Total number of butterflis:",sites$ButterflyCount)
                      )
  })
  
  output$VIS1<-renderPlot({
    ggplot(data=top5, aes(x=Site, y=sum))+
      geom_bar(stat="identity")+
      coord_flip()+
      ggtitle("Top 5 number of butterflies count Sites")+
      ylab("Total number of butterflies")+
      scale_colour_brewer(palette="Dark2")
    
  })
  output$VIS2<-renderPlot({
    ggplot(data=top5_day, aes(x=Count, y=day))+
      geom_point()+
      facet_wrap(~ top5_day$Site, ncol=5)+
      scale_colour_brewer(palette="Dark2")
  })
}



shinyApp(ui = ui, server = server)