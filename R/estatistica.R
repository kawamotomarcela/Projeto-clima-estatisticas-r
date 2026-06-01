teste_normalidade_clima <- function(dados) {
  cat("Teste de Shapiro-Wilk para temperatura:\n")
  print(shapiro.test(dados$temperatura))
  
  cat("\nTeste de Shapiro-Wilk para umidade:\n")
  print(shapiro.test(dados$umidade))
  
  cat("\nInterpretação:\n")
  cat("Se o p-valor for maior que 0,05, não há evidência de que os dados sejam diferentes de uma distribuição normal.\n")
  cat("Se o p-valor for menor ou igual a 0,05, os dados não seguem distribuição normal.\n")
}

teste_correlacao_clima <- function(dados) {
  normal_temp <- shapiro.test(dados$temperatura)$p.value > 0.05
  normal_umid <- shapiro.test(dados$umidade)$p.value > 0.05
  
  if (normal_temp && normal_umid) {
    cat("Como temperatura e umidade apresentaram distribuição normal, foi utilizado Pearson.\n\n")
    print(cor.test(dados$temperatura, dados$umidade, method = "pearson"))
  } else {
    cat("Como pelo menos uma variável não apresentou distribuição normal, foi utilizado Spearman.\n\n")
    print(cor.test(dados$temperatura, dados$umidade, method = "spearman"))
  }
}

modelo_regressao_clima <- function(dados) {
  modelo <- lm(temperatura ~ umidade + vento + precipitacao, data = dados)
  
  cat("Modelo de regressão linear:\n")
  cat("Temperatura ~ Umidade + Vento + Precipitação\n\n")
  
  print(summary(modelo))
  
  cat("\nTeste de normalidade dos resíduos:\n")
  print(shapiro.test(modelo$residuals))
  
  cat("\nInterpretação:\n")
  cat("O R² indica quanto da variação da temperatura é explicada pelo modelo.\n")
  cat("P-valores menores que 0,05 indicam variáveis com associação estatisticamente significativa.\n")
}

comparar_periodos_clima <- function(dados) {
  grupos <- split(dados$temperatura, dados$periodo)
  
  p_normal <- sapply(grupos, function(x) {
    if (length(x) >= 3) {
      shapiro.test(x)$p.value
    } else {
      NA
    }
  })
  
  cat("P-valores do teste de normalidade por período:\n")
  print(p_normal)
  
  if (all(p_normal > 0.05, na.rm = TRUE)) {
    cat("\nComo os grupos apresentam distribuição aproximadamente normal, foi aplicada ANOVA.\n\n")
    modelo_anova <- aov(temperatura ~ periodo, data = dados)
    print(summary(modelo_anova))
  } else {
    cat("\nComo pelo menos um grupo não apresentou normalidade, foi aplicado Kruskal-Wallis.\n\n")
    print(kruskal.test(temperatura ~ periodo, data = dados))
  }
}