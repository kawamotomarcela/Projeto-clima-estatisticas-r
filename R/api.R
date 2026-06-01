library(httr)
library(jsonlite)

buscar_coordenadas <- function(cidade) {
  cidades <- list(
    "Aracaju" = list(lat = -10.947, lon = -37.073),
    "Belém" = list(lat = -1.455, lon = -48.490),
    "Belo Horizonte" = list(lat = -19.916, lon = -43.934),
    "Brasília" = list(lat = -15.793, lon = -47.882),
    "Campo Grande" = list(lat = -20.469, lon = -54.620),
    "Cuiabá" = list(lat = -15.601, lon = -56.097),
    "Curitiba" = list(lat = -25.429, lon = -49.271),
    "Florianópolis" = list(lat = -27.595, lon = -48.548),
    "Fortaleza" = list(lat = -3.731, lon = -38.526),
    "Goiânia" = list(lat = -16.686, lon = -49.264),
    "João Pessoa" = list(lat = -7.119, lon = -34.845),
    "Maceió" = list(lat = -9.665, lon = -35.735),
    "Manaus" = list(lat = -3.119, lon = -60.021),
    "Natal" = list(lat = -5.794, lon = -35.211),
    "Palmas" = list(lat = -10.184, lon = -48.333),
    "Porto Alegre" = list(lat = -30.034, lon = -51.217),
    "Recife" = list(lat = -8.047, lon = -34.877),
    "Rio de Janeiro" = list(lat = -22.906, lon = -43.172),
    "Salvador" = list(lat = -12.971, lon = -38.501),
    "São Paulo" = list(lat = -23.550, lon = -46.633)
  )
  
  if (!cidade %in% names(cidades)) {
    stop("Cidade não encontrada. Verifique se ela foi cadastrada na lista de coordenadas.")
  }
  
  return(cidades[[cidade]])
}

buscar_clima_previsao <- function(cidade) {
  coords <- buscar_coordenadas(cidade)
  
  url <- paste0(
    "https://api.open-meteo.com/v1/forecast?",
    "latitude=", coords$lat,
    "&longitude=", coords$lon,
    "&current=temperature_2m,relative_humidity_2m,wind_speed_10m,precipitation",
    "&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m,precipitation",
    "&forecast_days=3",
    "&timezone=America%2FSao_Paulo"
  )
  
  resposta <- GET(url)
  
  if (status_code(resposta) != 200) {
    stop("Erro ao acessar a API meteorológica.")
  }
  
  conteudo <- content(resposta, as = "text", encoding = "UTF-8")
  dados <- fromJSON(conteudo)
  
  base <- data.frame(
    cidade = cidade,
    data_hora = dados$hourly$time,
    temperatura = dados$hourly$temperature_2m,
    umidade = dados$hourly$relative_humidity_2m,
    vento = dados$hourly$wind_speed_10m,
    precipitacao = dados$hourly$precipitation
  )
  
  return(base)
}