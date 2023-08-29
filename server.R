dashboard_name <- "TEST" # Must match name that exists in portal admin 

# I have set an environment variable on dashboard server that is read here. Will be empty on local server
sys_env <- Sys.getenv(x = "env", unset = "", names = NA) 

# Set options
options(dplyr.summarise.inform = FALSE)
options(warn = -1) 

# Set up authentication (very rarely need to change this)
test_auth <- F # TRUE to enforce authentication in testing
portal_api <- parse_url("https://portal.valueadvisory.com.au")
# portal_api <- parse_url("http://localhost:3000")

temp_auth <- NULL

function(input, output, session) {
  is_authenticated <- reactiveVal(FALSE)
  
  # Authentication. Unlikely to ever need to modify this block.
  observe({
    query <- parseQueryString(session$clientData$url_search)
    
    if (sys_env == "production" || test_auth) {
      auth_path <- portal_api
      auth_path$path <- "auth/validate_token"
      
      # extract token from URL
      access_token <- query[['pass']]
      if (is.null(access_token)) {
        access_token <- temp_auth
      }
      
      auth_path$query <- list(
        dashboard_name = dashboard_name,
        code = access_token
      )
      
      response_obj <- content(GET(build_url(auth_path)))
      
      if(response_obj[['valid']]) {
        # Success
        is_authenticated(TRUE)
        session$sendCustomMessage("cleanurl", "")
        hideElement("loading_window")
        showElement("main_window")
      } else {
        # Permission denied
        session$sendCustomMessage("redirect", dashboard_name)
      }
    } else {
      # Test Mode is enabled - Authentication requirement switched off
      is_authenticated(TRUE)
      hideElement("loading_window")
      showElement("main_window")
    }
  })
  
  # Dashboard server logic to go here
  

  
  library(oro.nifti)# skull stripping using FSL's Brain Extraction Tool (BET)
  library(fslr)
  library(manipulate)
  source("lazyr.R")
  source("interactive.R")
  source("animation.R")
  
  # iplot = function(img, plane = c("axial", 
  #                                 "coronal", "sagittal"), ...){
  #   ## pick the plane
  #   plane = match.arg(plane, c("axial", 
  #                              "coronal", "sagittal"))
  #   # Get the max number of slices in that plane for the slider
  #   ns=  switch(plane,
  #               "axial"=dim(img)[3],
  #               "coronal"=dim(img)[2],
  #               "sagittal"=dim(img)[1])
  #   ## run the manipulate command
  #   manipulate({
  #     image(img, z = z, plot.type= "single", plane = plane, ...)
  #     # this will return mouse clicks (future experimental work)
  #     pos <- manipulatorMouseClick()
  #     if (!is.null(pos)) {
  #       print(pos)
  #     }
  #   },
  #   ## make the slider
  #   z = slider(1, ns, step=1, initial = ceiling(ns/2))
  #   )
  # }
  # 
  # 
  # url <- "https://raw.githubusercontent.com/muschellij2/Neurohacking_data/master/BRAINIX/NIfTI/Output_3D_File.nii.gz"
  # destfile <- "Output_3D_File.nii.gz"
  # name <- file.path(getwd(), destfile)
  # download.file(url, destfile,mode="wb") # NIfTI is binaryfile format
  # nii_T1 <- readNIfTI(destfile)
  
  
#   print (nii_T1)
#   
#   image(nii_T1,z=11,plot.type="single") 
#   
#   image(nii_T1) 
#   
#   orthographic(nii_T1,xyz=c(200,220,11)) 
#   
#   is_btw_300_400<- ((nii_T1>300) &
#                       (nii_T1<400))
#   nii_T1_mask<-nii_T1
#   nii_T1_mask[!is_btw_300_400]=NA
#   overlay(nii_T1,nii_T1_mask,z=11,plot.type="
# single") 
  
  # iplot(nii_T1)
  
    # output$image <- renderImage({
    #   
    #   image(nii_T1,z=11,plot.type="single") 
    #   
    #   
    #   # input$newimage
    #   # 
    #   # # Get width and height of image output
    #   # width  <- session$clientData$output_image_width
    #   # height <- session$clientData$output_image_height
    #   # 
    #   # # Write to a temporary PNG file
    #   # outfile <- tempfile(fileext = ".png")
    #   # 
    #   # png(outfile, width=width, height=height)
    #   # plot(rnorm(200), rnorm(200))
    #   # dev.off()
    #   # 
    #   # # Return a list containing information about the image
    #   # list(
    #   #   src = outfile,
    #   #   contentType = "image/png",
    #   #   width = width,
    #   #   height = height,
    #   #   alt = "This is alternate text"
    #   # )
    # })
  
  show_output <- reactiveVal(FALSE)
  
  read_img_as_array <- function(path) {
    img_raw <- RNifti::readNifti(path)
    if (length(dim(img_raw)) == 3) return(img_raw[,,])
    return(img_raw[,,,])
  }
  
  output$show_output <- reactive(show_output())
  outputOptions(output, "show_output", suspendWhenHidden = FALSE)
  
  observe({
    if (is.null(input$your_dt)) {
      show_output(F)
    } else {
      show_output(T)
    }
  })
  
  options(shiny.maxRequestSize = 500*1024^2)
  app_dt <- reactive({
    if (!(is.null(input$your_dt))) {
      datapath <- input$your_dt$datapath
      if (tools::file_ext(datapath) == "gz") {
        datapath <- sub("gz$", "nii.gz", datapath)
        file.rename(input$your_dt$datapath, datapath)
      }
      out <- read_img_as_array(datapath)
      return(out)
    }
    
  })
  output$raster_panel <- renderUI({
    if (input$interactive) {
      callModule(raster3d_interactive_Module, "mri_3d", im = app_dt)
      raster3d_interactive_UI("mri_3d")
    } else {
    callModule(raster3d_animation_Module, "mri_3d", im = app_dt)
    raster3d_animation_UI("mri_3d")
    }
  })

}
