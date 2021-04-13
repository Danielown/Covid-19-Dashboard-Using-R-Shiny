


dashboardPage(
    skin = "red",
    dashboardHeader(title = "Indonesia Covid 19"),
    dashboardSidebar(
        sidebarMenu(
            menuItem(
                text = "Personal",
                tabName = "personal",
                icon = icon("gears")
                
            ),
            
            selectInput(
                inputId = "monthyear",
                label = "Month&Year:",
                choices = unique(pivot_covid$month_year),
                selected = TRUE
                
            ),
            menuItem("About Me", icon = icon("linkedin"), 
                     href = "https://www.linkedin.com/in/daniel-lumban-gaol-b91099190/")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "personal",
                
                fluidRow(
                    box(
                        title = "Average of Covid 19 Cases",
                        width = 12, 
                        
                        selectInput(
                            inputId = "province",
                            label = "Province:",
                            choices = unique(pivot_covid$Province),
                            selected = TRUE
                        ),       
                        
                        valueBoxOutput(
                            outputId = "daily_case", width = 3 
                        ),
                        
                        valueBoxOutput(
                            outputId = "daily_death", width = 3 
                        ),
                        
                        valueBoxOutput(
                            outputId = "daily_recovered", width = 3 
                        ),
                        
                        valueBoxOutput(
                            outputId = "daily_active", width = 3 
                        )
                    ) 
                ),
                
                fluidRow(
                    box(
                        title = "Select the Province column to find out the Ratio of Death Cases
                                vs Recovered Case",
                        width = 12,
                        plotlyOutput(outputId = "persCase")
                    )
                ),
                
                fluidRow(
                    box(
                        title = "Select the month & year column to find out the Death Cases
                                for the Top 5 provinces each month",
                        width = 12,
                        plotlyOutput(outputId = "provNum")
                        
                    )
                )
            )
        )
    )
)
