library("openxlsx")
#install.packages("xlsx", )
#install.packages("rJava")


setwd("C:/Users/WilliamAncizar/Desktop/ShinyApp/FirstApp/FirtsApp")

#Primero creamo el dataframe 
contactos <- data.frame(nombre = character(),
                   numero = numeric(),
                   email= character())

data <- list(nombre="William", numero=3212582693, email="a.toro@gmail")
contactos <- rbind(contactos,data)
write.xlsx(contactos, file = "Conctatos.xlsx", append = TRUE)
contactos %>% 
  kable() %>% 
  kable_classic()


tablacontactos <- kable_classic(kable_input = contactos, lightable_options = "basic", html_font = "Arial")

library(shiny)
runExample("09_upload")


addregister <- function(){
  contactos <- data.frame(nombre = character(),
                          numero = numeric(),
                          email= character())
  
  data <- list(nombre=as.character(readline("Nombre:")), 
               numero= as.numeric(readline("Numero:")), 
               email=as.character(readline("Email:")))
  contactos <- rbind(contactos,data)
  openxlsx::write.xlsx(contactos, file = "Conctatos.xlsx", append = TRUE)
}

addregister()


#------------------
