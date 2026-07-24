## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(obrasgovr)

## ----resources----------------------------------------------------------------
list_resources()

## ----project-filters----------------------------------------------------------
project_filters <- list_filters("projects")
project_filters[c("filter", "type")]

## ----filter-values------------------------------------------------------------
project_filters$allowed_values[
  project_filters$filter == "situacao"
][[1]]

## ----first-query, eval = FALSE------------------------------------------------
# projects_pe <- get_projects(
#   uf_principal = "PE",
#   situacao = "Em execução",
#   dt_cadastro = as.Date("2024-01-01"),
#   page_size = 25
# )
# 
# projects_pe

## ----inspect-metadata, eval = FALSE-------------------------------------------
# metadata <- result_metadata(projects_pe)
# 
# metadata$total_items
# metadata$total_pages
# metadata$pages_retrieved
# metadata$retrieved_at

## ----related-resources, eval = FALSE------------------------------------------
# project_id <- projects_pe$id_projeto_investimento[[1]]
# 
# physical_execution <- get_physical_execution(
#   id_projeto_investimento = project_id
# )
# 
# contracts <- get_contracts(
#   id_projeto_investimento = project_id
# )
# 
# commitments <- get_commitments(
#   id_projeto_investimento = project_id
# )
# 
# status_history <- get_status_history(
#   id_projeto_investimento = project_id
# )

## ----updated, eval = FALSE----------------------------------------------------
# source_updated_at <- get_last_update()
# source_updated_at

## ----portuguese-aliases, eval = FALSE-----------------------------------------
# projetos_pe <- obter_projetos(
#   uf_principal = "PE",
#   tamanho_da_pagina = 25,
#   todas_paginas = FALSE
# )

## ----options, eval = FALSE----------------------------------------------------
# options(
#   obrasgovr.base_url = "https://api-publica.obrasgov.gestao.gov.br/obras",
#   obrasgovr.timeout = 30,
#   obrasgovr.user_agent = "my-project/1.0 (contact@example.org)"
# )

