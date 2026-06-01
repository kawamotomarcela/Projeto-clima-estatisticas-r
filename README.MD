# Clima Agora BR

## Resumo

O **Clima Agora BR** é uma aplicação desenvolvida em **R com Shiny** para consultar, organizar, visualizar e analisar dados climáticos de cidades brasileiras.

O projeto busca dados por meio de uma **API meteorológica**, organiza essas informações e apresenta tabelas, gráficos, análises estatísticas e insights automáticos.

A proposta atende ao que foi pedido na atividade: **extração de dados, organização, visualização e análise utilizando R**.

## O que o projeto faz

- Busca dados climáticos por API;
- Permite selecionar uma cidade;
- Organiza e limpa os dados recebidos;
- Mostra tabelas com informações climáticas;
- Gera gráficos com `ggplot2`;
- Aplica análises estatísticas;
- Gera insights automáticos;
- Salva o histórico das consultas em CSV.

## Tecnologias utilizadas

- R
- Shiny
- httr
- jsonlite
- dplyr
- lubridate
- ggplot2
- tidyverse
- CSS

## Estrutura do projeto

```bash
Clima-Estatisticas/
├── app.R
├── R/
│   ├── api.R
│   ├── limpeza.R
│   ├── graficos.R
│   ├── insights.R
│   └── estatistica.R
├── dados/
│   └── historico_clima.csv
├── www/
│   └── style.css
└── README.md
```

## Função dos arquivos

- `app.R`: arquivo principal da aplicação Shiny;
- `R/api.R`: busca os dados climáticos na API;
- `R/limpeza.R`: limpa e organiza os dados;
- `R/graficos.R`: cria os gráficos da aplicação;
- `R/insights.R`: gera interpretações automáticas;
- `R/estatistica.R`: aplica testes estatísticos;
- `www/style.css`: personaliza o visual do projeto;
- `dados/`: armazena o histórico das consultas.

## Análises realizadas

O projeto aplica algumas análises estatísticas básicas vistas em aula:

- Teste de normalidade;
- Correlação entre temperatura e umidade;
- Regressão linear;
- Comparação da temperatura por período do dia.

## Como rodar o projeto

### 1. Abrir no RStudio

Abra a pasta do projeto no **RStudio** e depois abra o arquivo:

```bash
app.R
```

### 2. Instalar os pacotes necessários

No console do RStudio, execute:

```R
install.packages(c(
  "shiny",
  "httr",
  "jsonlite",
  "dplyr",
  "lubridate",
  "ggplot2",
  "tidyverse"
))
```

### 3. Rodar pelo RStudio

Com o arquivo `app.R` aberto, clique em:

```bash
Run App
```

### 4. Rodar pelo console do R

Também é possível rodar com o comando:

```R
shiny::runApp()
```

Caso queira indicar o caminho completo da pasta:

```R
shiny::runApp("C:/Users/SEU_USUARIO/Desktop/Clima-Estatisticas")
```

Substitua `SEU_USUARIO` pelo nome correto do usuário do computador.

## Como usar

Depois que a aplicação abrir:

1. Selecione uma cidade;
2. Clique em **Buscar clima**;
3. Veja os dados principais na aba **Resumo**;
4. Veja os gráficos na aba **Gráficos**;
5. Veja os testes na aba **Estatística**;
6. Veja a interpretação automática na aba **Insights**;
7. Veja a base organizada na aba **Dados**.

## Possíveis erros

Se aparecer erro de pacote não encontrado, rode novamente:

```R
install.packages(c(
  "shiny",
  "httr",
  "jsonlite",
  "dplyr",
  "lubridate",
  "ggplot2",
  "tidyverse"
))
```

Se aparecer erro de arquivo não encontrado, confira se os arquivos estão dentro da pasta `R/` com estes nomes:

```bash
R/
├── api.R
├── limpeza.R
├── graficos.R
├── insights.R
└── estatistica.R
```

Se o estilo visual não carregar, confira se o arquivo CSS está em:

```bash
www/style.css
```

## Status

Projeto em desenvolvimento.

## Autora

## Autora

**Nome:** Marcela Kawamoto Fernandes  
**RA:** 2224453