dashboardPage(
  dashboardHeader(title = "Scotland Health"),
  dashboardSidebar(sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
    menuItem("Life Expectancy", tabName = "life_expectancy", icon = icon("th")),
    menuItem("Alcohol", tabName = "alcohol_consumption", icon = icon("th"))
  )),
  dashboardBody(
    tabItems(
      # First tab
      tabItem(
        tabName = "overview",
        fluidRow(
          box(
            tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
            width = 12,
            leafletOutput("map"),
            fixedPanel(
              top = 100, right = 50, left = 700,
              selectInput("variable",
                "Select Variable",
                choices = c("Life Expectancy", "Alcohol Related Hospital Admissions"),
                selected = "Life Expectancy"
              )
            ),
            absolutePanel(
              bottom = 0,
              right = 20,
              left = 20,
              tags$style(
                ".irs-bar {",
                "  border-color: transparent;",
                "  background-color: transparent;",
                "}",
                ".irs-bar-edge {",
                "  border-color: transparent;",
                "  background-color: transparent;",
                "}"
              ),
              sliderInput("year",
                "Select year",
                value = 2017,
                max = 2017, min = 1999,
                sep = "",
                ticks = TRUE
              )
            )
          )
        ),
      ),
      # Second Tab
      tabItem(
        tabName = "life_expectancy",
        fluidRow(
          box(
            title = "Select Variables",
            width = 12,
            column(
              4,
              pickerInput(
                inputId = "select_sex",
                label = "Sex",
                choices = c("Male", "Female", "Both"),
                selected = "Both"
              )
            ),
            column(
              4,
              pickerInput(
                inputId = "select_year",
                label = "Year",
                1992:2017, selected = 2017
              )
            ),
            column(
              4,
              uiOutput("council_select")
            )
          )
        ),

        fluidRow(
          box(
            title = "Life Expectancy Over Time",
            width = 6,
            plotlyOutput("life_expectancy_time")
          ),

          box(
            title = "Difference From National Average",
            width = 6,
            plotlyOutput("life_expectancy_comparison"),
            tags$style(
              type = "text/css",
              ".shiny-output-error { visibility: hidden; }",
              ".shiny-output-error:before { visibility: hidden; }"
            )
          )
        )
      ),
      tabItem(
        tabName = "alcohol_consumption",
        fluidRow(
          box(
            title = "Select Variables",
            width = 12,
            column(
              6,
              pickerInput(
                inputId = "select_alcohol_year",
                label = "Year",
                1999:2018,
                selected = 2018
              )
            ),
            column(
              6,
              uiOutput("council_alcohol_select")
            )
          )
        ),
        fluidRow(
          box(
            title = "Number of Alcohol Related Hospital Admissions",
            width = 6,
            plotlyOutput("alcohol_time_plot")
          ),
          box(
            title = "Percentage Increase in Alcohol Related Hospital Admissions",
            width = 6,
            plotlyOutput("alcohol_consumption_percentage_diff"),
            tags$style(
              type = "text/css",
              ".shiny-output-error { visibility: hidden; }",
              ".shiny-output-error:before { visibility: hidden; }"
            )
          )
        )
      )
    )
  )
)
