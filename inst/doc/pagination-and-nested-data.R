## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(obrasgovr)

## ----one-page, eval = FALSE---------------------------------------------------
# projects <- get_projects(
#   uf_principal = "PE",
#   page = 1,
#   page_size = 200
# )
# 
# result_metadata(projects)

## ----limited-pages, eval = FALSE----------------------------------------------
# projects_sample <- get_projects(
#   uf_principal = "PE",
#   all_pages = TRUE,
#   page_limit = 3,
#   page_size = 200
# )
# 
# result_metadata(projects_sample)$pages_retrieved

## ----page-window, eval = FALSE------------------------------------------------
# projects_window <- get_projects(
#   uf_principal = "PE",
#   page = 4,
#   all_pages = TRUE,
#   page_limit = 3,
#   page_size = 200
# )

## ----nested-sample------------------------------------------------------------
projects <- tibble::tibble(
  id_projeto_investimento = c("100.00-01", "200.00-02"),
  desc_nome = c("School renovation", "Health unit construction"),
  executores = list(
    list(
      list(nome_organizacao = "Municipality A", cnpj = "00000000000100"),
      list(nome_organizacao = "State Agency", cnpj = "00000000000200")
    ),
    list(
      list(nome_organizacao = "Municipality B", cnpj = "00000000000300")
    )
  )
)

projects

## ----inspect-one-cell---------------------------------------------------------
projects$executores[[1]]

## ----normalize-executors------------------------------------------------------
executors <- projects |>
  dplyr::select(id_projeto_investimento, executores) |>
  tidyr::unnest_longer(executores) |>
  tidyr::unnest_wider(executores)

executors

## ----summarize, eval = FALSE--------------------------------------------------
# projects_sample |>
#   dplyr::count(situacao, sort = TRUE)

## ----reproducibility, eval = FALSE--------------------------------------------
# query <- list(
#   uf_principal = "PE",
#   all_pages = TRUE,
#   page_limit = 3,
#   page_size = 200
# )
# 
# provenance <- list(
#   query = query,
#   pagination = result_metadata(projects_sample),
#   source_updated_at = get_last_update()
# )
# 
# saveRDS(
#   list(data = projects_sample, provenance = provenance),
#   "projects-pe.rds"
# )

