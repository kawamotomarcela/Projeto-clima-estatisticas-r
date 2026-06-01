library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

source("R/api.R")
source("R/limpeza.R")
source("R/graficos.R")
source("R/insights.R")
source("R/estatistica.R")

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  
  titlePanel("Clima Agora BR"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "cidade",
        label = "Selecione a cidade:",
        choices = c(
          "Aracaju",
          "Belém",
          "Belo Horizonte",
          "Brasília",
          "Campo Grande",
          "Cuiabá",
          "Curitiba",
          "Florianópolis",
          "Fortaleza",
          "Goiânia",
          "João Pessoa",
          "Maceió",
          "Manaus",
          "Natal",
          "Palmas",
          "Porto Alegre",
          "Recife",
          "Rio de Janeiro",
          "Salvador",
          "São Paulo"
        ),
        selected = "Brasília"
      ),
      
      actionButton(
        inputId = "atualizar",
        label = "Buscar clima"
      ),
      
      br(),
      br(),
      
      helpText(
        "Selecione uma cidade e clique em Buscar clima para consultar os dados climáticos, gerar gráficos e aplicar análises estatísticas."
      )
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel(
          "Resumo",
          br(),
          div(
            class = "main-panel-card",
            h3("Dados atuais do clima"),
            tableOutput("tabela_atual")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Resumo da previsão"),
            tableOutput("resumo_previsao")
          )
        ),
        
        tabPanel(
          "Gráficos",
          br(),
          div(
            class = "main-panel-card",
            h3("Temperatura ao longo do tempo"),
            plotOutput("grafico_linha")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Comparação entre variáveis climáticas"),
            plotOutput("grafico_barras")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Relação entre temperatura e umidade"),
            plotOutput("grafico_dispersao")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Temperatura por período do dia"),
            plotOutput("grafico_boxplot")
          )
        ),
        
        tabPanel(
          "Estatística",
          br(),
          div(
            class = "main-panel-card",
            h3("Teste de normalidade"),
            verbatimTextOutput("normalidade")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Correlação entre temperatura e umidade"),
            verbatimTextOutput("correlacao")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Regressão linear"),
            verbatimTextOutput("regressao")
          ),
          br(),
          div(
            class = "main-panel-card",
            h3("Comparação entre períodos do dia"),
            verbatimTextOutput("comparacao_periodos")
          )
        ),
        
        tabPanel(
          "Insights",
          br(),
          div(
            class = "main-panel-card",
            h3("Insight automático"),
            textOutput("insight_texto")
          )
        ),
        
        tabPanel(
          "Dados",
          br(),
          div(
            class = "main-panel-card",
            h3("Base organizada"),
            tableOutput("dados_completos")
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  dados_clima <- eventReactive(input$atualizar, {
    dados <- buscar_clima_previsao(input$cidade)
    dados <- limpar_dados_clima(dados)
    salvar_historico_clima(dados)
    dados
  })
  
  output$tabela_atual <- renderTable({
    req(dados_clima())
    gerar_tabela_atual(dados_clima())
  }, rownames = FALSE)
  
  output$resumo_previsao <- renderTable({
    req(dados_clima())
    gerar_resumo_previsao(dados_clima())
  }, rownames = FALSE)
  
  output$grafico_linha <- renderPlot({
    req(dados_clima())
    gerar_grafico_linha(dados_clima(), input$cidade)
  })
  
  output$grafico_barras <- renderPlot({
    req(dados_clima())
    gerar_grafico_barras(dados_clima(), input$cidade)
  })
  
  output$grafico_dispersao <- renderPlot({
    req(dados_clima())
    gerar_grafico_dispersao(dados_clima(), input$cidade)
  })
  
  output$grafico_boxplot <- renderPlot({
    req(dados_clima())
    gerar_grafico_boxplot(dados_clima(), input$cidade)
  })
  
  output$normalidade <- renderPrint({
    req(dados_clima())
    teste_normalidade_clima(dados_clima())
  })
  
  output$correlacao <- renderPrint({
    req(dados_clima())
    teste_correlacao_clima(dados_clima())
  })
  
  output$regressao <- renderPrint({
    req(dados_clima())
    modelo_regressao_clima(dados_clima())
  })
  
  output$comparacao_periodos <- renderPrint({
    req(dados_clima())
    comparar_periodos_clima(dados_clima())
  })
  
  output$insight_texto <- renderText({
    req(dados_clima())
    gerar_insight_clima(dados_clima())
  })
  
  output$dados_completos <- renderTable({
    req(dados_clima())
    dados_clima()
  }, rownames = FALSE)
}

shinyApp(ui = ui, server = server)