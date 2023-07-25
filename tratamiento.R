library(readxl)
library(tidyverse)

# Importación de los datos
excel_censo <- read_excel("Datos descargados/PROV_02_201911_1.xlsx", 
                               skip = 5)
excel_partidos <- read_excel("Datos descargados/PROV_02_201911_1.xlsx", 
                             skip = 4)

# Seleccionar las variables y los casos pertinentes de los datos censales
datos_censo <- excel_censo %>%  select(1:16)
datos_censo <- datos_censo[-53,]
saveRDS(datos_censo, "Datos tratados/censo.RDS")

# Seleccionar los datos de los votos a candidaturas
matches <- excel_partidos %>%  colnames() %>%  grepl("\\.\\.\\.", .)
prov_com <- datos_censo %>% select(1:3)
datos_partidos <- excel_partidos[,!matches]
datos_partidos <- datos_partidos[-c(1,54), ]
datos_partidos <- bind_cols(prov_com, datos_partidos)
saveRDS(datos_partidos, "Datos tratados/votos.RDS")

# Señeccionar los datos de los escaños ACTUALES
datos_escanos <- excel_partidos[,-(1:16)]
matches <- datos_escanos %>% colnames() %>% grepl("\\.\\.\\.", .)
nombres_partidos <- colnames(datos_escanos)[!matches]
escanos_partidos <- datos_escanos[,matches]
escanos_partidos <- escanos_partidos[-c(1,54),]
colnames(escanos_partidos) <- nombres_partidos
escanos_partidos <- bind_cols(prov_com, escanos_partidos)
saveRDS(escanos_partidos, "Datos tratados/escanos.RDS")
