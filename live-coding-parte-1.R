# Anotações: ------------------------------
# Sobre os dados:
# Baixar a base do SRAG antes.
# não deixamos no github pois é pesada e é atualizada frequentemente


# DADOS DE 2020
# https://opendatasus.saude.gov.br/dataset/bd-srag-2020
# Baixei, renomeei para INFLUD-2020.csv e deixei na pasta dados/


# DADOS DE 2021
# https://opendatasus.saude.gov.br/dataset/bd-srag-2021
# Baixei, renomeei para INFLUD-2021.csv e deixei na pasta dados/



# Dicionário de dados:
# https://opendatasus.saude.gov.br/dataset/9f76e80f-a2f1-4662-9e37-71084eae23e3/resource/b3321e55-24e9-49ab-8651-29cf5c8f3179/download/dicionario_de_dados_srag_hospitalizado_23.03.2021.pdf

# Live coding --------------------------

# Podemos escrever comentários no nosso código, usando o hashtag!
# tudo que é escrito em alguma linha após o hashtag não será considerado.

# Pacotes --------------
# Conceito importante: pacotes.
# Podemos pensar nos pacotes conjuntos de ferramentas!
# Essas "ferramentas" nós chamamos de funções.
# Para usar essas ferramentas, precisamos instalar
# os pacotes uma vez, e cada vez que quisermos usar precisamos
# carregar eles.

# Para instalar os pacotes usamos a função
# install.packages("nome_do_pacote")
# e para carregar o pacote usamos a função library(nome_do_pacote).

# Exemplo:

# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("data.table")


library(tidyverse) # este pacote oferece uma GRANDE quantidade
# de ferramentas para análise de dados!

library(janitor) # limpeza de dados

library(data.table) # funções para lidar com bases de dados GRANDES


# Importar os dados ---------
# Conceito importante: objetos!

dados_2020 <-
  fread(
    "dados/INFLUD-2020.csv",
    # Caminho até onde o arquivo está salvo
    # nome das colunas que queremos importar
    select = c(
      "CLASSI_FIN",
      "DT_ENCERRA",
      "DT_ENTUTI",
      "DT_EVOLUCA",
      "EVOLUCAO",
      "CS_SEXO",
      "DT_NASC",
      "SG_UF_NOT",
      "ID_MUNICIP"
    )
  )

dados_2021 <-
  fread(
    "dados/INFLUD-2021.csv",
    # Caminho até onde o arquivo está salvo
    # nome das colunas que queremos importar
    select = c(
      "CLASSI_FIN",
      "DT_ENCERRA",
      "DT_ENTUTI",
      "DT_EVOLUCA",
      "EVOLUCAO",
      "CS_SEXO",
      "DT_NASC",
      "SG_UF_NOT",
      "ID_MUNICIP"
    )
  )



# Conceito importante: data.frames. É um formato
# tabular de dados, similar ao que estamos acostumadas
# a ver no excel.
# linhas e colunas: cada linha é uma observação (neste caso, paciente),
# e cada coluna é uma variável.

# Juntar os dados! ------------------

dados <- bind_rows(dados_2020, dados_2021)

# Observar a base ----

# número de linhas
nrow(dados)
# [1] 2931531 em: 20022/08/15

# número de colunas
ncol(dados)
# [1] 9 em: 20022/08/15

# resumo: quais são as principais colunas/dados no nosso arquivo?
glimpse(dados)
#Rows: 2,931,531 em: 20022/08/15
#Columns: 9
#$ CLASSI_FIN <int> 2, 4, 4, 2, 4, 4, 1, 1, NA, 4, 4, 4, 4, 5, 2, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 5, 4, 2, …
#$ DT_ENCERRA <chr> "17/01/2020", "09/01/2020", "19/02/2020", "06/02/2020", "02/03/2020", "18/03/2020", "10/…
#$ DT_ENTUTI  <chr> "", "", "12/02/2020", "", "", "", "", "", "", "21/03/2020", "", "20/03/2020", "", "28/03…
#$ DT_EVOLUCA <chr> "12/01/2020", "08/01/2020", "13/02/2020", "", "", "13/03/2020", "10/03/2020", "27/04/202…
#$ EVOLUCAO   <int> 1, 1, 2, 1, 1, 1, 1, 1, NA, 1, 2, 3, 2, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
#$ CS_SEXO    <chr> "M", "M", "F", "M", "F", "F", "F", "M", "M", "M", "M", "F", "F", "M", "M", "F", "F", "M"…
#$ DT_NASC    <chr> "26/06/2019", "08/06/2018", "01/05/1962", "05/04/2019", "07/07/1991", "20/08/1964", "18/…
#$ SG_UF_NOT  <chr> "DF", "DF", "SP", "CE", "SP", "DF", "PR", "MG", "SP", "SP", "SP", "SC", "SP", "SP", "RJ"…
#$ ID_MUNICIP <chr> "BRASILIA", "BRASILIA", "SALTO", "FORTALEZA", "MAUA", "BRASILIA", "CURITIBA", "UBERABA",…
# Conceito importante: pipe %>% - usamos isso para usar funções
# sequencialmente! Assim fica mais fácil de entender a ordem.

# manter dados de mortes covid-19
mortes_covid <- dados %>%
  # limpar o nome das colunas
  janitor::clean_names() %>%
  # filtrar as linhas em que a classificação final do caso
  # seja igual à 5 (no dicionário de dados: 5-SRAG por covid-19)
  # E que também tenha evolução igual à 2
  # (no dicionário de dados: 2-Óbito)
  filter(classi_fin == 5 & evolucao == 2) %>%
  # remover as colunas que não serão mais necessárias
  select(-classi_fin,-evolucao)


# Exportar a base criada em um arquivo .Rds
write_rds(mortes_covid, "dados-output/mortes_covid.Rds")
