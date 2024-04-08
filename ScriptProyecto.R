#### 1: Instalación y activación de librerias ####

#Instalamos la libreria dplyr
install.packages(dplyr)

#Abrimos la libreria dplyr
library(dplyr)

#### 2: Exploración y lectura de datos ####
#Guardamos el dataset en una variable
datos <- read.csv("ad_df.csv")
#Vemos los datos
View(datos)

#Vemos los tipos de variables
glimpse(datos)

#Vemos el tamaño de nuestra dataset
dim(datos)

#### 3: Limpieza de datos ####

#Eliminamos columnas que no usaremos
datos <- subset(datos, select = -c(auction_id, timestamp,creative_duration,
                                   creative_id,campaign_id,advertiser_id,
                                   placement_id,website_id,ua_os,ua_browser_version,
                                   seconds_played))
##### 3.1: Rectificación de la limpieza de datos #####

#Vemos el tamaño de nuestra nueva dataset
dim(datos)

#Vemos el resumen estadistico 
summary(datos)

##### 3.2: Verificación de datos faltantes #####

#Vemos si hay datos vacios
any(is.na(datos))

#Procedemos a ver cuántos datos de estos estan vacios en cada columna
colSums(is.na(datos))

##### 3.3: Reemplazo datos faltantes y verificando que no quede ninguno#####

#Rellenamos los valores NA con 0 en la columna user_average_seconds_played

#En este caso le pusimos 0 porque donde no hay valor quiere decir que nunca vieron un anuncio.
datos$user_average_seconds_played[is.na(datos$user_average_seconds_played)] <- 0

#Rectificamos si ya no hay valores nulos
any(is.na(datos))


##### 3.4: Manejo de datos atipicos #####

#Uso de diagrama Boxplot
boxplot(datos$user_average_seconds_played,horizontal=TRUE,col="darkgoldenrod3",
        xlab = "Segundos vistos")


##### 4: Categorización de los dispotivos (Cambio de variable cuantitativa a cualitativa) ####
#Observamos los nombres unicos de las variables
unique(datos$ua_devices)

#Con esta información, hacemos una nueva columna para separarlas en labels
datos$ua_devices_numeric <- as.numeric(factor(datos$ua_device, levels = c("PersonalComputer", "Tablet", "Phone", "ConnectedTv"), labels = c(1, 2, 3, 4)))

#Identificamos que no hayan datos faltantes :)
any(is.na(datos$ua_devices_numeric))

#Vemos cuántos datos faltantes hay
summary(datos$ua_devices_numeric)

#Como hay pocos datos faltantes, decidimos eliminar las filas con los NA
datos <- datos[complete.cases(datos),]

#Rectificamos que ya no queden datos faltantes
any(is.na(datos$ua_devices_numeric))

###### 4.1: Categorización de los paises (Cambio de variable cuantitativa a cualitativa) #####

#Observamos los nombres unicos de las variables
unique(datos$ua_country)

#Hacemos la categorización correspondiente
paises <- c("ch", "uk", "us", "fr", "nl", "jp", "de", "ar", "es", "it", "hk", "ca", "pl", "pe", "no", "sg", "br", "id", "ec", "kr", "at",
            "pt", "th", "cn", "do", "nz", "mx", "ph", "my", "be", "dk", "hu", "cr", "fi", "co", "ro", "se", "ae", "ru", "cl", "tw", "il",
            "au", "cz", "vn", "za", "in", "gg", "ng", "bg", "sa", "sk", "gt", "ma", "lu", "aw", "az", "ua", "uy", "sr", "gr", "kw", "cw",
            "gh", "bq", "ug", "eg", "pk", "kz", "tr", "jm", "cv", "cy", "ke", "ba", "bo", "ie", "tt", "bd", "ve", "mc", "", "al", "tz",
            "ss", "mv", "ee", "lk", "mu", "bh", "ck", "sx", "hr", "pr", "ni", "py", "lv", "ge", "om", "qa", "re", "ly", "cd", "bz", "np",
            "tn", "is", "si", "mg", "zw", "pa", "mw", "sv", "ci", "bw", "lt", "hn", "fj", "af", "tc", "gm", "mt", "et", "kh", "iq", "mk",
            "zm", "lb", "mr", "la")



#Hacemos otro dataset, pero con los datos limpios.

write.csv(datos, "datos_limpios.csv")

