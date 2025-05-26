library(shiny)
library(uuid)
library(grid)

# UI -----------------------------------------------------------------------
ui <- fluidPage(
  tags$head(
    tags$style(
      HTML(paste(
        "body {background: white; color: black;}",
        "#plot {cursor: crosshair;}",
        "h3 {margin-bottom: 20px; text-align:center;}",
        "#exit {position: absolute; top: 10px; right: 10px;}",
        sep = "\n"
      ))
    )
  ),
  titlePanel(h3("Click on the square that is larger")),
  fluidRow(
    column(12,
           plotOutput("plot", height = "400px", click = "plot_click"),
           actionButton("exit", "Exit")
    )
  )
)

# Server -------------------------------------------------------------------
server <- function(input, output, session) {
  # Constants
  fixed_area <- 9
  cross_thresh <- 0.05  # fraction of plot (npc) for cross region ~±0.05
  
  # Session ID & results
  session_id <- UUIDgenerate()
  results <- reactiveVal(
    data.frame(
      trial = integer(),
      ref_position = character(),
      var_area = numeric(),
      response = character(),
      correct = logical(),
      rt = numeric(),
      stringsAsFactors = FALSE
    )
  )
  
  # Reactive state: phase = 'idle' or 'trial'; ready for click
  state <- reactiveValues(
    phase = 'idle',  # 'idle' before trial start, 'trial' during stimulus
    ready = TRUE,    # only allow start when ready=TRUE
    trial = 0,
    ref_left = TRUE,
    var_area = NA_real_,
    start_time = Sys.time()
  )
  
  # Function to start a new trial
  newTrial <- function() {
    state$trial <- state$trial + 1
    state$ref_left <- sample(c(TRUE, FALSE), 1)
    state$var_area <- runif(1, 8, 15)
    state$start_time <- Sys.time()
    state$phase <- 'trial'
  }
  
  # After leaving trial, schedule readiness after 0.5s
  observe({
    req(state$phase == 'idle' && !state$ready)
    invalidateLater(500, session)
    isolate({ state$ready <- TRUE })
  })
  
  # Handle all plot clicks
  observeEvent(input$plot_click, {
    click <- input$plot_click
    x <- click$x; y <- click$y
    if (state$phase == 'idle' && state$ready) {
      # start trial only if clicked on fixation cross area
      if (abs(x - 0.5) <= cross_thresh && abs(y - 0.5) <= cross_thresh) {
        state$ready <- FALSE
        newTrial()
      }
    } else if (state$phase == 'trial') {
      # record response during trial
      resp_left <- (x < 0.5)
      response <- ifelse(resp_left, 'L', 'R')
      correct_answer <- if (state$var_area > fixed_area) {
        if (state$ref_left) 'R' else 'L'
      } else {
        if (state$ref_left) 'L' else 'R'
      }
      correctness <- (response == correct_answer)
      rt <- as.numeric(difftime(Sys.time(), state$start_time, units = 'secs'))
      df <- results()
      df <- rbind(df, data.frame(
        trial = state$trial,
        ref_position = ifelse(state$ref_left, 'L', 'R'),
        var_area = state$var_area,
        response = response,
        correct = correctness,
        rt = rt,
        stringsAsFactors = FALSE
      ))
      results(df)
      # end trial, go to idle
      state$phase <- 'idle'
      state$var_area <- NA_real_
      state$ready <- FALSE
    }
  })
  
  # Render based on phase
  output$plot <- renderPlot({
    grid.newpage()
    if (state$phase == 'idle') {
      # Draw fixation cross
      grid.lines(x = unit.c(unit(0.5, 'npc') - unit(5, 'mm'), unit(0.5, 'npc') + unit(5, 'mm')),
                 y = unit(0.5, 'npc'), gp = gpar(lwd = 2))
      grid.lines(x = unit(0.5, 'npc'),
                 y = unit.c(unit(0.5, 'npc') - unit(5, 'mm'), unit(0.5, 'npc') + unit(5, 'mm')),
                 gp = gpar(lwd = 2))
      grid.text(paste0('Click cross to start trial: ', state$trial + 1), y = unit(0.3, 'npc'))
      grid.text(session_id, y = unit(0.2, "npc"), gp = gpar(col = "lightgrey"))
      if (!state$ready) {
        grid.rect(gp = gpar(fill = "white", alpha = 0)) # no-op, placeholder
      }
    } else if (state$phase == 'trial') {
      # Draw squares
      fixed_side <- sqrt(fixed_area)
      var_side <- sqrt(state$var_area)
      x_ref <- if (state$ref_left) 0.25 else 0.75
      x_var <- if (state$ref_left) 0.75 else 0.25
      pushViewport(viewport(x = x_ref, y = 0.5, width = 0.5, height = 0.5,
                            just = c('center','center'), angle = 45))
      grid.rect(width = unit(fixed_side, 'mm'), height = unit(fixed_side, 'mm'), gp = gpar(fill = 'black'))
      popViewport()
      pushViewport(viewport(x = x_var, y = 0.5, width = 0.5, height = 0.5,
                            just = c('center','center'), angle = 45))
      grid.rect(width = unit(var_side, 'mm'), height = unit(var_side, 'mm'), gp = gpar(fill = 'black'))
      popViewport()
    }
  })
  
  # Exit: save and stop
  observeEvent(input$exit, {
    if(!dir.exists("data"))dir.create(data)
    write.csv(results(), paste0("data/", session_id, '.csv'), row.names = FALSE)
    stopApp()
  })
}

# Run ---------------------------------------------------------------------
shinyApp(ui = ui, server = server)
