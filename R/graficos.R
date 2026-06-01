library(ggplot2)
library(dplyr)

gerar_grafico_linha <- function(dados, cidade) {
  ggplot(dados, aes(x = data_hora, y = temperatura)) +
    geom_line(linewidth = 1) +
    geom_point(size = 1.5) +
    labs(
      title = paste("Temperatura por hora -", cidade),
      x = "Data e hora",
      y = "Temperatura em °C"
    ) +
    theme_minimal()
}

gerar_grafico_barras <- function(dados, cidade) {
  resumo <- dados %>%
    summarise(
      Temperatura = mean(temperatura),
      Umidade = mean(umidade),
      Vento = mean(vento),
      Precipitacao = mean(precipitacao)
    )
  
  dados_plot <- data.frame(
    variavel = names(resumo),
    valor = as.numeric(resumo[1, ])
  )
  
  ggplot(dados_plot, aes(x = variavel, y = valor)) +
    geom_col() +
    labs(
      title = paste("Média das variáveis climáticas -", cidade),
      x = "Variável",
      y = "Valor médio"
    ) +
    theme_minimal()
}

gerar_grafico_dispersao <- function(dados, cidade) {
  ggplot(dados, aes(x = umidade, y = temperatura)) +
    geom_point(size = 2) +
    geom_smooth(method = "lm", se = FALSE) +
    labs(
      title = paste("Relação entre umidade e temperatura -", cidade),
      x = "Umidade relativa do ar (%)",
      y = "Temperatura em °C"
    ) +
    theme_minimal()
}

gerar_grafico_boxplot <- function(dados, cidade) {
  ggplot(dados, aes(x = periodo, y = temperatura)) +
    geom_boxplot() +
    labs(
      title = paste("Temperatura por período do dia -", cidade),
      x = "Período do dia",
      y = "Temperatura em °C"
    ) +
    theme_minimal()
}