library(bslib) # only ever needed in UI

jscode <- "
  Shiny.addCustomMessageHandler('cleanurl', function(pass) {
    window.history.replaceState(null, null, window.location.pathname);
  });
  
  Shiny.addCustomMessageHandler('redirect', function (dashboardName) {
    // production
    window.location = 'https://portal.valueadvisory.com.au/dashboard/' + dashboardName;
    
    // testing
    // window.location = 'http://localhost:3000/dashboard/' + dashboardName;
  });
"

page_fluid(
  useShinyjs(),
  title = "VAP Dashboard",
  
  # CSS
  tags$head(
    tags$link(rel = "apple-touch-icon", sizes = "180x180", href = "https://vap-portal.s3-ap-southeast-2.amazonaws.com/Logo/favicon/apple-touch-icon.png"),
    tags$link(rel = "icon", type="image/png", sizes = "32x32", href = "https://vap-portal.s3-ap-southeast-2.amazonaws.com/Logo/favicon/favicon-32x32.png"),
    tags$link(rel = "icon", type="image/png", sizes = "16x16", href = "https://vap-portal.s3-ap-southeast-2.amazonaws.com/Logo/favicon/favicon-16x16.png"),
    tags$link(rel = "stylesheet", type = "text/css", href = "css/main.css"),
    tags$script(jscode)
  ),
  navs_bar(
    # Settings
    title = HTML("<h2><b>DICOM Classifier</h2></b>"),
    position = "fixed-top",
    bg = "#09023f",
    inverse = TRUE,
    
    # Items
    nav_spacer(),
    nav_item(
      img(src = "IMRA_logo.png",
          width = "115%")
    )
  ),
  hr(),
  hidden(
    div(
      id = "main_window",
      fluidRow(
        column(
          # Sidebar
          2,
          id = "sidebar",
          style = "padding-top: 18px;
    padding-left: 24px;",
          fileInput("your_dt", "Upload a .nii or nii.gz file"),
          conditionalPanel(
            condition = "output.show_output",
            shinyWidgets::switchInput(
              "interactive", "Interactive", onStatus = "success"
            ),
            #       HTML("<h5>Or select </h5>"),
            #       HTML("<h5>Select Classification Complexity</h5>"),
            #       selectInput(
            #         "density",
            #         label = NULL,
            #         choices = c(
            #           "Market" = "medium",
            #           "Current Maximum Capacity" = "high",
            #           "Basic" = "asp"
            #         ),
            #         selected = "asp",
            #         width = "100%"
            #       ),
            #       
            #       HTML("<h6><p style = 'margin-top: -14px;
            # margin-left: 7px;'>Blue - Kidney, Red - Tumour</p></h6>"),
            actionButton("run",
                         "Run Classifier Algorithm",
                         width = "100%"
            ),
            hr(),
            conditionalPanel(
              condition = "output.algo_finished",
            actionButton("save",
                         "Save Classified DICOM Data",
                         width = "100%"
            )
            )
          )
        ),
        column(
          # Main Window
          9,
          style = "margin-left: 18px;",
          hr(),
          hr(),
          fluidRow(
            column(12,
                   conditionalPanel(
                     condition = "output.show_output",
                     HTML("<h4><b>Original</b></h4>"),
                     uiOutput("raster_panel")
                   ),
                   conditionalPanel(
                     condition = "!output.show_output",
                     HTML("<h2><b>Please upload DICOM data </b></h2>")
                   )
                   # img(src = "ct_scan.png",
                   #     width = "85%",
                   #     style = "border-style: outset;")
            ),
            # column(6,
            #        
            #        HTML("<h4><b>Classified</b></h4>"),
            #        img(src = "ct_scan2.png",
            #            width = "85%",
            #            style = "border-style: outset;")
            # )
          )
          # HTML("<h4><b>Main Window</b></h4>")
        )
      ),
      hr(),
      img(
        src="RMIT_logo.png",
        height = 50
      ),
      # tags$footer(paste0("© Value Advisory Partners. Build Date: ", format(all_data$meta$generated_time, format = "%d %B %Y")))
    )
  ),
  div(
    id = "loading_window",
    h4("LOADING")
  )
)
