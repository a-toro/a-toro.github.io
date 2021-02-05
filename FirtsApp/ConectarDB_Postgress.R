library("DBI")
#install.packages("RPostgres")
library(RPostgres)

#Conectarse a una bas de datos de tipo postgress
con <- dbConnect(RPostgres::Postgres(),dbname = 'Contactos', 
                 host = '127.0.0.1', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
                 port = 5432, # or any other port specified by your DBA
                 user = 'postgres',
                 password = '@WQ789456159t0r0')

#muestra el listado de tablas
dbListTables(con)

#leer y cargar una tabla de la base de datos
listaContactos <- dbReadTable(con, "Lista")


#Crear una tabla en la base de datos, en fields puede ir un dataframe o un vector de caracteres
data <- data.frame(nombre = "William",
                   numero=3212582693,
                   email="a.toro@utp.edu.co")

dbCreateTable(con, name = "TablaPrueba", fields = data ,temporary = FALSE, )

#Remover una base de datos
dbRemoveTable(con, name = "TablaPrueba")

#consultas base de datos PENDIENTE
consulta <- dbGetQuery(con, statement = "SELECT * FROM Lista")
dbFetch(consulta)
dbClearResult(consulta)

#Agregar datos a una tabla PENDIENTE
dbSendQuery(con, "SELECT * FROM Lista")

#Desconectarse de la base de datos
dbDisconnect(con)

#Agregar datos a una tabla de datos
cargar <- dbAppendTable(con, 
              name = "Lista", 
              data.frame(list(Nombre="William", Numero=3212582, Email="a.toro")))
