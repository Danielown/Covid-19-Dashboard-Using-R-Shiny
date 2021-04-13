server <- function(input, output) {
    
    showNotification("Created by Daniel Lumban Gaol", duration = NULL, type
                     = "message")
    
    reactive_case <- reactive({
        pivot_covid %>%
            filter(Province == input$province)
        
    })
    
    reactive_grafik <- reactive({
        pivot_covid %>% 
            filter(month_year == input$monthyear)
        
    })
    
    reactive_monthyear <- reactive({
        pivot_covid %>% 
            filter(month_year == input$monthyear, Province == input$province)
    })
    
    
    output$daily_case <- renderValueBox({
        
        value_daily_case <- reactive_monthyear() %>%
            pull(Daily_Case) %>%
            mean() %>%
            round(2)
        
        valueBox(
            value = value_daily_case,
            subtitle = "Avg Monthly Covid Case ",
            icon = icon("virus"),
            color = "green", width = 3
        )
        
    })
    
    output$daily_death <- renderValueBox({
        
        value_daily_death <- reactive_monthyear() %>%
            pull(Daily_Death) %>%
            mean() %>%
            round(2)
        
        valueBox(
            value = value_daily_death,
            subtitle = "Avg Monthly Death Case",
            icon = icon("virus"),
            color = "red", width = 3
        )
        
    })
    
    output$daily_recovered <- renderValueBox({
        
        value_daily_recovered <- reactive_monthyear() %>%
            pull(Daily_Recovered) %>%
            mean() %>%
            round(2)
        
        valueBox(
            value = value_daily_recovered,
            subtitle = "Avg Monthly Recovered Case",
            icon = icon("virus"),
            color = "green", width = 3
        )
        
    })
    
    output$daily_active <- renderValueBox({
        
        
        value_daily_active <- reactive_monthyear() %>%
            pull(Active_Case) %>%
            mean() %>%
            round(2)
        
        valueBox(
            value = value_daily_active,
            subtitle = "Avg Monthy Active Case",
            icon = icon("virus"),
            color = "red", width = 3
        )
        
    })
    
    output$provNum <- renderPlotly({
        
        DC <- reactive_grafik() %>%
            group_by(Province) %>%
            summarise(total_death = sum(Daily_Death)) %>%
            arrange(desc(total_death)) %>%
            head(5)
        
        p <- DC %>%
            ggplot(aes(x = total_death, y = reorder(Province, total_death)))+
            geom_col(aes(fill = Province))+
            labs(title = "Top 5 Provinces",
                 x = "Death Case Value",
                 y = NULL)+
            theme(legend.position = "none")
        
        ggplotly(p)
        
    })
    
    
    output$persCase <- renderPlotly({
        
        pivot <- reactive_case()
        
        piv <- pivot %>%
            ggplot(aes(x= Nilai, y= reorder(month_year,Nilai)))+
            geom_col(aes(fill= ratio), postion = "dodge", show.legend = F, width= 0.7)+
            scale_fill_manual(values = c("blue","firebrick4"))+
            facet_wrap(~ratio,scales = "free_y")+
        labs(title = "Recovered and Death Ratio/Month",
             x=""
             , y="Month&Year")+theme(legend.position = "none")
        
        ggplotly(piv)
    })
    
}
