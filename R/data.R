#' Yeast gene expression
#'
#' Expression of *S. cerevisiae* genes during chemostat growth under
#' nutrient limitation.
#'
#' @source \url{https://pubmed.ncbi.nlm.nih.gov/17959824/}
#' @seealso \url{http://varianceexplained.org/files/Brauer2008_DataSet1.tds}
#'
#' @format
#' A tibble with 199,296 rows and 4 columns:
#' \describe{
#'   \item{systematic_name}{systematic gene name}
#'   \item{nutrient}{limiting nutrient}
#'   \item{rate}{growth rate}
#'   \item{exp}{gene expression value}
#' }
"yeast_gene_exp"

#' Yeast gene ontology
#'
#' Gene ontology terms for *S. cerevisiae* genes
#'
#' @seealso \url{https://geneontology.org/docs/ontology-documentation/}
#'
#' @format
#' A tibble with 5,537 rows and 4 columns
#' \describe{
#'   \item{systematic_name}{systematic gene name}
#'   \item{common_name}{common gene name}
#'   \item{go_molecular_function}{GO molecular function}
#'   \item{go_biological_process}{GO biological process}
#' }
"yeast_go_terms"

#' Yeast protein properties
#'
#' Protein properties for *S. cerevisiae* genes
#'
#' @source \url{http://sgd-archive.yeastgenome.org/curation/calculated_protein_info/protein_properties.tab]
#' @seealso \url{http://sgd-archive.yeastgenome.org/curation/calculated_protein_info/protein_properties.README}
#'
#' @format
#' A tibble with 6,724 rows and 38 columns
#' \describe{
#'   \item{systematic_name}{systematic gene name}
#'   \item{mw}{molecular weight}
#'   \item{pi}{isoelectric point}
#'   ...
#' }
"yeast_prot_props"
