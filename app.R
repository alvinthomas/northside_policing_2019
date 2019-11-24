source("helper_function.R")

# Use Shiny Dashboard Layout
ui <- dashboardPage(
  dashboardHeader(title="Northside Policing 2019", titleWidth=300),
  dashboardSidebar(
    # Put interactive first, other details are available for those interested
    sidebarMenu(
      # Icon names come from font awesome
      menuItem("Treemap", tabName="treemap", icon=icon("chart-bar")),
      menuItem("Background", tabName="background", icon=icon("star")),
      menuItem("Technical Details", tabName="technical", icon=icon("database")),
      menuItem("Arrests Data", tabName="datatable1", icon=icon("table")),
      menuItem("Incidents Data", tabName="datatable2", icon=icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName="treemap",
        h2("Treemaps of Incidents and Arrests"),
        p("Scroll down to toggle plot options. Questions? Contact Alvin at
          alvin {at} statsnips.com"),
        fluidRow(
          column(width=12,
            box(title="Police Arrests in Northside", status="primary",
              solidHeader=TRUE, width=6,
              plotOutput(outputId = "popPlot1"),
              h3("What am I looking at?"),
              p("This treemap shows police-reported arrests in the Northside
                neighborhood of Chapel Hill. The colors separate the data into
                categories. You can change the figure by modifying the choices
                below")
            ),
            box(title="Police Incidents in Northside", status="primary",
              solidHeader=TRUE, width=6,
              plotOutput(outputId = "popPlot2"),
              h3("What am I looking at?"),
              p("This treemap shows police-reported incidents in the Northside
                neighborhood of Chapel Hill. The colors separate the data into
                categories. You can change the figure by modifying the choices
                below")
            )
          )
        ),
        fluidRow(
          box(title="Arrests Date Range", status="primary",
            solidHeader=TRUE, width=3,
            dateRangeInput(inputId = "dateRange1",
                           label = "Date range: yyyy-mm-dd",
                           start = "2014-07-01", end = "2019-06-30",
                           min = "2014-07-01", max = "2019-06-30",
                           format = "yyyy-mm-dd",
                           startview = "year"),
            p("Enter the time period that you would like to plot. Whole months
            are encournaged but not required."),
            p("Allowable range: 2014-07-01 to 2019-06-30"),
            p("Recommended range: 2014-07-01 to 2019-06-30")
          ),
          box(title="Arrests Categories", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories1", "Countries",
                              choices = c("Alcohol" = "Alcohol",
                                 "Assult" = "Assult",
                                 "Drug" = "Drug",
                                 "Financial/Fraud" = "Financial/Fraud",
                                 "Moving Infraction" = "Moving Crime",
                                 "Personal Crime" = "Personal",
                                 "Property Crime" = "Property Crime",
                                 "Sexual Crime" = "Sexual Crime",
                                 "Theft" = "Theft",
                                 "Victimless Crime" = "Victimless Crime"),
                              selected = c("Alcohol", "Assult",
                               "Drug", "Financial/Fraud",
                               "Moving Crime", "Personal",
                               "Property Crime", "Sexual Crime",
                               "Theft", "Victimless Crime")
            )
          ),
          box(title="Incidents Date Range", status="primary",
            solidHeader=TRUE, width=3,
            dateRangeInput(inputId = "dateRange2",
                           label = "Date range: yyyy-mm-dd",
                           start = "2014-07-01", end = "2019-06-30",
                           min = "2014-07-01", max = "2019-06-30",
                           format = "yyyy-mm-dd",
                           startview = "year"),
            p("Enter the time period that you would like to plot. Whole months
            are encournaged but not required."),
            p("Allowable range: 2014-07-01 to 2019-06-30"),
            p("Recommended range: 2014-07-01 to 2019-06-30")
          ),
          box(title="Incidents Categories", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories2", "Countries",
                               choices = c("Alcohol" = "Alcohol",
                                  "Assult" = "Assult",
                                  "Domestic Crime" = "Domestic",
                                  "Drug" = "Drug",
                                  "Financial/Fraud" = "Financial",
                                  "Information" = "Information",
                                  "Moving Infraction" = "Moving Crime",
                                  "Non-Crime" = "Non-Crime",
                                  "Party/Noise" = "Party",
                                  "Personal Crime" = "Personal Crime",
                                  "Property Crime" = "Property Crime",
                                  "Sexual Crime" = "Sexual",
                                  "Theft" = "Theft",
                                  "Victimless Crime" = "Victimeless Crime"),
                               selected = c("Alcohol", "Assult",
                                "Domestic", "Drug", "Financial",
                                "Moving Crime","Party", "Personal Crime",
                                "Property Crime", "Sexual", "Theft",
                                "Victimeless Crime")
            )
          )
        )
      ),
      tabItem(tabName="background",
        h2("Background"),
        p(
          "This interactive dashboard explores police-reported incidents and
          arrests in the historically Black Northside neighborhood in
          Chapel Hill, NC, USA between 7/2015-6/2019. Data are from the
          Chapel Hill Open Data platform."
        )
      ),
      tabItem(tabName="technical",
        h2("Technical Details"),
        p(
          "The code for this interactive dashboard can be found at
          https://github.com/alvinthomas/northside_policing_2019."
        )
      ),
      tabItem(tabName="datatable1",
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable1"), width=12
          )
        )
      ),
      tabItem(tabName="datatable2",
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable2"), width=12
          )
        )
      )
    )
  )
)

# Run Server
server <- function(input, output) {

  output$popPlot1 <- renderPlot({
    make_graph1(dateRange = input$dateRange1, options = input$categories1)
  })

  output$popPlot2 <- renderPlot({
    make_graph2(dateRange = input$dateRange2, options = input$categories2)
  })

  output$popTable1 <- DT::renderDataTable({
    df <- get_dat1(dateRange = input$dateRange1, options = input$categories1)
    DT::datatable(df,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })

  output$popTable2 <- DT::renderDataTable({
    df <- get_dat2(dateRange = input$dateRange2, options = input$categories2)
    DT::datatable(df,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })
}

shinyApp(ui, server)
