library(dplyr)
library(lubridate)

limpar_dados_clima <- function(dados) {
  dados$data_hora <- as.POSIXct(dados$data_hora, format = "%Y-%m-%dT%H:%M", tz = "America/Sao_Paulo")
  
  dados$temperatura <- as.numeric(dados$temperatura)
  dados$umidade <- as.numeric(dados$umidade)
  dados$vento <- as.numeric(dados$vento)
  dados$precipitacao <- as.numeric(dados$precipitacao)
  
  dados <- na.omit(dados)
  
  dados <- dados %>%
    mutate(
      data = as.Date(data_hora),
      hora = hour(data_hora),
      periodo = case_when(
        hora >= 5 & hora < 12 ~ "Manhã",
        hora >= 12 & hora < 18 ~ "Tarde",
        hora >= 18 & hora < 24 ~ "Noite",
        TRUE ~ "Madrugada"
      )
    )
  
  return(dados)
}

salvar_historico_clima <- function(novos_dados) {
  caminho <- "dados/historico_clima.csv"
  
  if (!dir.exists("dados")) {
    dir.create("dados")
  }
  
  if (file.exists(caminho)) {
    historico <- read.csv(caminho, stringsAsFactors = FALSE)
    historico <- rbind(historico, novos_dados)
  } else {
    historico <- novos_dados
  }
  
  write.csv(historico, caminho, row.names = FALSE)
}

gerar_tabela_atual <- function(dados) {
  dados %>%
    slice(1) %>%
    select(cidade, data_hora, temperatura, umidade, vento, precipitacao)
}

gerar_resumo_previsao <- function(dados) {
  dados %>%
    summarise(
      temperatura_media = round(mean(temperatura), 2),
      temperatura_minima = round(min(temperatura), 2),
      temperatura_maxima = round(max(temperatura), 2),
      umidade_media = round(mean(umidade), 2),
      vento_medio = round(mean(vento), 2),
      precipitacao_total = round(sum(precipitacao), 2)
    )
}