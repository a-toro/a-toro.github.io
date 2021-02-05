#------------------------First App----------------------------

library(shiny)
library(tidyverse)
library(kableExtra)
#Data base
library("DBI")
library(RPostgres)

setwd("C:/Users/WilliamAncizar/Desktop/ShinyApp/FirstApp/FirtsApp")
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel(h1("Mis contactos")),
  
  sidebarLayout(
    sidebarPanel(h3("Registrar contactos"),
                 textInput(inputId = "nombre", label = "Nombre"),
                 #En label Numero, no se coloca tilde porque genera error
                 textInput(inputId = "numero", label = "Numero"),
                 textInput(inputId = "email", label = "Gmail"),
                 actionButton(inputId = "registrar", label = "Registrar"),
                 actionButton(inputId = "actualizar", label = "Actualizar"),
                 actionButton(inputId = "limpiar", label = "Limpiar"),
                 actionButton(inputId = "saveDB", label = "Guardar DB")
                 ),
    
    
    mainPanel(h1("Lista de contactos"),
              tableOutput(outputId = "tabla"),
              verbatimTextOutput("mainPanel"),
              
              )
  )#siderbarLayout
)#fluidpage

# Crear un dataframe con los datos

#---------------Server----------------------
server <- function(input, output, session) {
  #Guardar registro
  guardarRegistro <- function(){
    contactos <- data.frame(nombre = character(),
                            numero = numeric(),
                            email= character())
    contactos <- rbind(contactos,list(nombre = input$nombre, numero= input$numero, email=input$email))
    openxlsx::write.xlsx(contactos, file = "Contactos.xlsx", append=TRUE)
  }
  
  observeEvent(input$registrar, {
    print("Guardando...")
    guardarRegistro()
    #contactos <- data.frame(nombre = character(),
    #                        numero = numeric(),
    #                        email= character())
    #
    #contactos <- rbind(contactos,list(nombre = input$nombre, numero= input$numero, email=input$email))
    #openxlsx::write.xlsx(contactos, file = "Contactos.xlsx", append=TRUE)
    #saveWorkbook(wb)
    #return(data.frame())
  })

  # Boton limpiar
observeEvent(input$limpiar,{
    updateTextInput(session, "nombre", value = "")
    updateTextInput(session, "numero", value = "")
    updateTextInput(session, "email", value = "")
})
  
  
  output$tabla <- reactive({
    
    contactos <- openxlsx::read.xlsx("Contactos.xlsx")
    contactos %>% 
      kableExtra::kable()# %>% 
      #kableExtra::kable_classic()
  })
  
  
  
  
  
  
  #Agregra datos al data.frame
  
  # Boton registrar
  #reactive({
    #if (input$registrar){
     # contactos <- rbind(contactos,data)
      #wb <- openxlsx::write.xlsx(contactos, file = "Contactos.xlsx", append=TRUE)
      
    #}
  #})
  
  #reg <- function(){
   # contactos <- rbind(contactos,data)
  #wb <- openxlsx::write.xlsx(contactos, file = "Contactos.xlsx", append=TRUE)}
  
  #input$registrar <- reg()
  
  # Boton limpiar
  
    
  #})
  
  #output$tabla <- renderTable(as.table(listaContactos))
  #data <- eventReactive(input$registrar, {
   # x <- read.xlsx("Contactos.xlsx", 1)
  #  z <- x %>%
   #   kale
  #  return(z)
  #})
  #Output text ----
  #output$text <- renderText({data()})
  
  ##Guardar DB
  observeEvent(input$saveDB,{
    #conectar BD
    con <- dbConnect(RPostgres::Postgres(),dbname = 'Contactos', 
                     host = '127.0.0.1', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
                     port = 5432, # or any other port specified by your DBA
                     user = 'postgres',
                     password = '@WQ789456159t0r0')
    dbAppendTable(con, 
                  name = "Lista", 
                  data.frame(
                    list(Nombre=input$nombre,
                         Numero=input$numero, 
                         Email=input$email)))
    dbDisconnect(con)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)