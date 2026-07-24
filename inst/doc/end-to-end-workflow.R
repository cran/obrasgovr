## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(obrasgovr)

## ----define-query-------------------------------------------------------------
project_query <- list(
  uf_principal = "PE",
  situacao = "Em execução",
  page_size = 200,
  all_pages = TRUE,
  page_limit = 5
)

project_query

## ----validate-filter-names----------------------------------------------------
available_project_filters <- list_filters("projects")$filter
requested_filters <- c("uf_principal", "situacao")

all(requested_filters %in% available_project_filters)

## ----retrieve-projects, eval = FALSE------------------------------------------
# projects <- rlang::exec(get_projects, !!!project_query)
# 
# projects |>
#   dplyr::select(
#     id_projeto_investimento,
#     desc_nome,
#     situacao,
#     dt_inicial_prevista,
#     dt_final_prevista
#   )

## ----check-completeness, eval = FALSE-----------------------------------------
# project_metadata <- result_metadata(projects)
# 
# project_metadata[c(
#   "total_items",
#   "total_pages",
#   "pages_retrieved",
#   "retrieved_at"
# )]

## ----choose-identifiers, eval = FALSE-----------------------------------------
# project_ids <- projects |>
#   dplyr::distinct(id_projeto_investimento) |>
#   dplyr::slice_head(n = 10) |>
#   dplyr::pull(id_projeto_investimento)
# 
# project_ids

## ----retrieve-execution, eval = FALSE-----------------------------------------
# physical_execution <- project_ids |>
#   purrr::map(function(project_id) {
#     get_physical_execution(
#       id_projeto_investimento = project_id,
#       all_pages = TRUE,
#       page_limit = 5
#     )
#   }) |>
#   purrr::list_rbind()

## ----retrieve-contracts, eval = FALSE-----------------------------------------
# contracts <- project_ids |>
#   purrr::map(function(project_id) {
#     get_contracts(
#       id_projeto_investimento = project_id,
#       all_pages = TRUE,
#       page_limit = 5
#     )
#   }) |>
#   purrr::list_rbind()

## ----local-tables-------------------------------------------------------------
projects_example <- tibble::tibble(
  id_projeto_investimento = c("100.00-01", "200.00-02"),
  desc_nome = c("School renovation", "Health unit construction"),
  situacao = c("Em execução", "Em execução")
)

execution_example <- tibble::tibble(
  id_projeto_investimento = c("100.00-01", "200.00-02"),
  percentual_execucao_fisica = c(72.5, 35.0),
  dt_atualizacao_execucao = as.Date(c("2026-06-30", "2026-07-10"))
)

contracts_example <- tibble::tibble(
  id_projeto_investimento = c("100.00-01", "100.00-01", "200.00-02"),
  id_contrato = c(11L, 12L, 21L),
  valor_global_contrato = c(1200000, 300000, 2450000)
)

## ----join-execution-----------------------------------------------------------
project_execution <- projects_example |>
  dplyr::left_join(
    execution_example,
    by = "id_projeto_investimento"
  )

project_execution

## ----summarize-contracts------------------------------------------------------
contract_summary <- contracts_example |>
  dplyr::group_by(id_projeto_investimento) |>
  dplyr::summarise(
    contract_count = dplyr::n(),
    total_contract_value = sum(valor_global_contrato, na.rm = TRUE),
    .groups = "drop"
  )

analysis_table <- project_execution |>
  dplyr::left_join(
    contract_summary,
    by = "id_projeto_investimento"
  )

analysis_table

## ----save-provenance, eval = FALSE--------------------------------------------
# provenance <- list(
#   query = project_query,
#   project_metadata = result_metadata(projects),
#   source_updated_at = get_last_update(),
#   package_version = utils::packageVersion("obrasgovr"),
#   saved_at = Sys.time()
# )
# 
# saveRDS(
#   list(
#     projects = projects,
#     physical_execution = physical_execution,
#     contracts = contracts,
#     provenance = provenance
#   ),
#   "obrasgovr-pe-workflow.rds"
# )

