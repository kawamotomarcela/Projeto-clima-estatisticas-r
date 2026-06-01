gerar_insight_clima <- function(dados) {
  temp_media <- mean(dados$temperatura)
  temp_max <- max(dados$temperatura)
  temp_min <- min(dados$temperatura)
  umid_media <- mean(dados$umidade)
  chuva_total <- sum(dados$precipitacao)
  
  texto <- paste0(
    "Nos próximos dados horários analisados, a temperatura média prevista é de ",
    round(temp_media, 1), "°C, variando entre ",
    round(temp_min, 1), "°C e ",
    round(temp_max, 1), "°C. "
  )
  
  if (umid_media >= 70) {
    texto <- paste0(texto, "A umidade média está elevada, indicando um clima mais úmido. ")
  } else if (umid_media <= 40) {
    texto <- paste0(texto, "A umidade média está baixa, indicando clima mais seco. ")
  } else {
    texto <- paste0(texto, "A umidade média está em um nível intermediário. ")
  }
  
  if (chuva_total > 0) {
    texto <- paste0(texto, "Há previsão de precipitação acumulada de aproximadamente ",
                    round(chuva_total, 1), " mm no período analisado.")
  } else {
    texto <- paste0(texto, "Não há previsão significativa de chuva no período analisado.")
  }
  
  return(texto)
}