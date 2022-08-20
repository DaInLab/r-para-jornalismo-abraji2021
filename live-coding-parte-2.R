# Carregando os pacotes necessários

library(tidyverse) # este pacote oferece uma GRANDE quantidade
# de ferramentas para análise de dados!

# Importando a base filtrada
mortes_covid <- read_rds("dados-output/mortes_covid.Rds")

# Respondendo perguntas --------

## Pergunta 1: -------
# Quantas mortes por Covid-19 no Brasil aparecem na nossa base
# de dados?

# NA são dados faltantes, informações que não sabemos!
# elas existem mas não temos acesso, então é importante considerar isso.


mortes_covid %>%
  count()  # faz uma contagem
#        n
#1: 605473

## Pergunta 2: ---
# Morreram mais mulheres ou mais homens de Covid-19?

mortes_covid %>%
  count(cs_sexo) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável
#   cs_sexo      n
#1:       M 339715
#2:       F 265694
#3:       I     64

## Pergunta 3: ---
# Quais estados têm o maior e o menor número de mortes,
# em números absolutos? E nas cidades?

# estados!
mortes_estados <- mortes_covid %>%
  count(sg_uf_not) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável

View(mortes_estados) # função View() é útil para visualizar
# os dados como tabela. mas NUNCA use com uma tabela
# muito grande, pois pode travar sua sessão do RStudio.

head(mortes_estados) # head é a função pra mostrar as primeiras
# linhas de uma base
#   sg_uf_not      n
#1:        SP 159807
#2:        RJ  70502
#3:        MG  57891
#4:        RS  36629
#5:        PR  36617
#6:        CE  26405

tail(mortes_estados) # tail é a função pra mostrar as últimas
# linhas de uma base
#   sg_uf_not    n
#1:        RO 6135
#2:        SE 6126
#3:        TO 3822
#4:        AP 1777
#5:        RR 1709
#6:        AC 1636

# municipios

mortes_municipios <- mortes_covid %>%
  count(sg_uf_not, id_municip) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável

head(mortes_municipios) # head é a função pra mostrar as primeiras
# linhas de uma base
#   sg_uf_not     id_municip     n
#1:        SP      SAO PAULO 46136
#2:        RJ RIO DE JANEIRO 39801
#3:        CE      FORTALEZA 14773
#4:        PE         RECIFE 11377
#5:        DF       BRASILIA 11252
#6:        PR       CURITIBA 10837

tail(mortes_municipios) # tail é a função pra mostrar as últimas
# linhas de uma base
#   sg_uf_not              id_municip n
#1:        TO            MURICILANDIA 1
#2:        TO                  NAZARE 1
#3:        TO             PALMEIRANTE 1
#4:        TO                 SAMPAIO 1
#5:        TO SAO MIGUEL DO TOCANTINS 1
#6:        TO            WANDERLANDIA 1

# Obs: alterações realizadas em: 20022/08/15
# Apenas para ilustrar
