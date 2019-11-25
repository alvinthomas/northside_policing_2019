source("helper_function.R")

# Use Shiny Dashboard Layout
ui <- dashboardPage(
  dashboardHeader(title="Northside Policing 2019", titleWidth=300),
  dashboardSidebar(
    # Put interactive first, other details are available for those interested
    sidebarMenu(
      # Icon names come from font awesome
      menuItem("Treemap", tabName="treemap", icon=icon("chart-bar")),
      menuItem("Bar Plot", tabName="barplot", icon=icon("chart-bar")),
      menuItem("Background", tabName="background", icon=icon("star")),
      menuItem("Technical Details", tabName="technical", icon=icon("database")),
      menuItem("Arrests Data", tabName="datatable1", icon=icon("table")),
      menuItem("Incidents Data", tabName="datatable2", icon=icon("table")),
      menuItem("Race and Arrest Datas", tabName="datatable3", icon=icon("table"))
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
              p(
                "This treemap shows police-reported arrests in the Northside
                neighborhood of Chapel Hill. The colors separate the data into
                categories. You can change the figure by modifying the choices
                below"
              ),
              h3("How were these arrests grouped together?"),
              p(
                "A team of students grouped these arrests together based on
                a literature-based classification focused on the \"victim\" of
                a crime. There were also a few categories that were further
                split in order to highlight types of crimes thought to be
                important to the community (e.g. alcohol). These groupings are
                not perfect - so feel free to download the data an reclassify!"
              )
            ),
            box(title="Police Incidents in Northside", status="primary",
              solidHeader=TRUE, width=6,
              plotOutput(outputId = "popPlot2"),
              h3("What am I looking at?"),
              p(
                "This treemap shows police-reported incidents in the Northside
                neighborhood of Chapel Hill. The colors separate the data into
                categories. You can change the figure by modifying the choices
                below"
              ),
              h3("How were these incidents grouped together?"),
              p(
                "A team of students grouped these incidents together based on
                a literature-based classification focused on the \"victim\" of
                a crime. There were also a few categories that were further
                split in order to highlight types of crimes thought to be
                important to the community (e.g. alcohol). These groupings are
                not perfect - so feel free to download the data an reclassify!"
              ),
              p(
                "There were efforts made to tie the arrest categories to
                incident categories whenever possible."
              ),
              h3("What does Information and Non-Crime mean?"),
              p(
                "The police incident dataset sometimes report events that are
                not crime related (i.e. unlikely to be connected to an arrest).
                We do not include these by default, but they can be added to
                the treemap using the options below. Non-crimes are clearly
                not crime-related, i.e. a funeral police escort, while
                information could be crime-related but were consider
                non-specific i.e. suspicious behavior."
              ),

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
          box(title="Arrests", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories1a", "Arrest Categories",
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
            ),
            checkboxGroupInput("categories1b", "Race/Ethnicity",
                              choices = c("Asian" = "A",
                                "Black" = "B",
                                "Hispanic" = "H",
                                "Native American" = "I",
                                "White" = "W"),
                              selected = c("A", "B",
                                "H", "I", "W")
            ),
            checkboxGroupInput("categories1c", "Sex",
                              choices = c(
                                "Male" = "M",
                                "Female" = "F"),
                              selected = c("M", "F")
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
          box(title="Incidents", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories2", "Incidents Categories",
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
      tabItem(tabName="barplot",
        h2("Bar Plots of Arrests by Race"),
        p("Scroll down to toggle plot options. Questions? Contact Alvin at
          alvin {at} statsnips.com"),
        fluidRow(
          column(width=12,
            box(title="Bar Plot of Race by Origin of Arrest", status="primary",
              solidHeader=TRUE, width=12,
              plotOutput(outputId = "popPlot3"),
              h3("What am I looking at?"),
              p(
                "This bar plot shows the difference between overall arrests and
                incident-led arrests in the Northside Neighborhood. An
                incident-led arrest is an arrest that was connected to an
                incident reported to the Chapel Hill police. For instance,
                if a neighbor called 911 to cite a noise violation, that would
                be recorded as an incident by the dispatcher. If there was at
                least one arrest related to that specific call, then that arrest
                would be entered into our data as an incident-led arrest."
              ),
              h3("What does it mean when there is a difference?"),
              p(
                "While it is difficult to say, a difference could point to
                differences in policing behavior/response. Let us look at the
                example of Alcohol. Overall, the average arrest is that of a
                white male. However, when you look at incident-led arrests,
                the average arrest is a Black male. The cause of this could
                be difference in 911 calling behavior (a black male with an
                open container is more likely to be called on by a neighbor),
                or by a difference in policing behavior (a black male is more
                likely to be arrested given that there was a call placed).
                Other factors may also be at play."
              )
            )
          )
        ),
        fluidRow(
          box(title="Arrests Date Range", status="primary",
            solidHeader=TRUE, width=3,
            dateRangeInput(inputId = "dateRange3",
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
            checkboxGroupInput("categories3", "Arrests",
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
          box(title="Race/Ethnicity Categories", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories4", "Race",
                              choices = c("Asian" = "Asian",
                                "Black" = "Black",
                                "Hispanic" = "Hispanic",
                                "Native American" = "Native American",
                                "White" = "White"),
                              selected = c("Asian", "Black",
                                "Hispanic", "Native American", "White")
            )
          ),
          box(title="Sex Categories", status="primary",
            solidHeader=TRUE, width=3,
            checkboxGroupInput("categories5", "Sex",
                              choices = c(
                                "Male" = "M",
                                "Female" = "F"),
                              selected = c("M", "F")
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
        ),
        p(
          "Additional background information can be found at
          https://github.com/alvinthomas/northside_policing_2019"
        )
      ),
      tabItem(tabName="technical",
        h2("Technical Details"),
        h3("Code"),
        p(
          "The code for this interactive dashboard can be found at
          https://github.com/alvinthomas/northside_policing_2019."
        ),
        h3("Treemap"),
        p(
          "The arrest and incident datasets were provided seperately. Both
          used an open text field to describe the charge. These charges were
          categorized using a literature-based approach that focused on the
          victim of a crime (e.g. a person, property, or victimless). Some
          errors could have been made in the process, so the full datasets are
          available on Github and the original dataset can be downloaded from
          the Chapel Hill Open Data portal."
        ),
        p(
          "Data categorization was done in Stata (00_get_data.do,
          01_process_charges.do, 02_process_incidents.do) and
          visualization was handled in R."
        ),
        h3("Bar Plot"),
        p(
          "The data for the barplot required a merge of the incident and
          arrest datasets. Based on information provided by an analyst at
          the Chapel Hill police department, the identifiers inci_id and
          case_id could be used for the merge."
        ),
        p(
          "The data was processed by Stata (00_get_data.do) and can
          be found on Github. An m:m merge was done since neither identifier
          was unique. That is to say, a single call could result in multiple
          types of incidents filed, and a single arrest could count towards
          multiple charges. While difficult, it may be possible to generate a
          single row per arrested individual dataset from the raw data."
        )
      ),
      tabItem(tabName="datatable1",
        p(
          "Changes made to the \"Treemap\" tab will be reflected on
          this table. To add/remove observations, toggle the options
          underneath the arrest treemap."
        ),
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable1"), width=12
          )
        )
      ),
      tabItem(tabName="datatable2",
        p(
          "Changes made to the \"Treemap\" tab will be reflected on
          this table. To add/remove observations, toggle the options
          underneath the incidents treemap."
        ),
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable2"), width=12
          )
        )
      ),
      tabItem(tabName="datatable3",
        p(
          "Changes made to the \"Bar Plot\" tab will be reflected on
          this table. To add/remove observations, toggle the options
          underneath the bar plot."
        ),
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable3"), width=12
          )
        )
      )
    )
  )
)

# Run Server
server <- function(input, output) {

  output$popPlot1 <- renderPlot({
    make_graph1(dateRange = input$dateRange1, options1a = input$categories1a,
      options1b = input$categories1b, options1c = input$categories1c)
  })

  output$popPlot2 <- renderPlot({
    make_graph2(dateRange = input$dateRange2, options = input$categories2)
  })

  output$popPlot3 <- renderPlot({
    make_graph3(dateRange = input$dateRange3, options = input$categories3,
      options2 = input$categories4, options3 = input$categories5)
  })

  output$popTable1 <- DT::renderDataTable({
    df <- get_dat1(dateRange = input$dateRange1, options1a = input$categories1a,
      options1b = input$categories1b, options1c = input$categories1c)
    DT::datatable(df,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })

  output$popTable2 <- DT::renderDataTable({
    df <- get_dat2(dateRange = input$dateRange2, options = input$categories2)
    DT::datatable(df,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })

  output$popTable3 <- DT::renderDataTable({
    df <- get_dat3(dateRange = input$dateRange3, options = input$categories3,
      options2 = input$categories4, options3 = input$categories5)
    DT::datatable(df,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })
}

shinyApp(ui, server)
