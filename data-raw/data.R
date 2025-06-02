# expression and GO --------------------------------------------------------

library(tidyverse)
library(here)
library(janitor)

url <- "http://varianceexplained.org/files/Brauer2008_DataSet1.tds"

nutrient_abbrs <- tribble(
  ~nutrient_abbr, ~nutrient,
  "G", "Glucose",
  "L", "Leucine",
  "P", "Phosphate",
  "S", "Sulfate",
  "N", "Ammonia",
  "U", "Uracil"
)

brauer_gene_exp_raw <-
  read_delim(
    url,
    delim = "\t",
    show_col_types = FALSE
  ) |>
  separate(
    NAME,
    c("name", "BP", "MF", "systematic_name", "number"),
    sep = "\\|\\|"
  ) |>
  mutate(
    across(name:number, trimws)
  ) |>
  mutate(
    name = na_if(name, "")
  )

yeast_go_terms <-
  select(
    brauer_gene_exp_raw,
    systematic_name,
    common_name = name,
    go_molecular_function = MF,
    go_biological_process = BP
  ) |>
  distinct()

brauer_gene_exp_wide <-
  select(
    brauer_gene_exp_raw,
    -name,
    -number,
    -GID,
    -YORF,
    -GWEIGHT,
    -BP,
    -MF
  )

yeast_gene_exp <-
  pivot_longer(
    brauer_gene_exp_wide,
    -systematic_name,
    names_to = "nutrient_rate",
    values_to = "exp"
  ) |>
  separate(
    nutrient_rate,
    into = c("nutrient_abbr", "rate"),
    sep = 1,
    convert = FALSE
  ) |>
  filter(systematic_name != "") |>
  left_join(nutrient_abbrs, by = "nutrient_abbr") |>
  select(
    systematic_name,
    nutrient,
    everything(),
    -nutrient_abbr
  ) |>
  mutate(across(c(rate, nutrient), as_factor)) |>
  arrange(desc(systematic_name), nutrient, rate)

usethis::use_data(yeast_gene_exp, overwrite = TRUE)
usethis::use_data(yeast_go_terms, overwrite = TRUE)

# protein properties --------------------------------------------------------

url <- "http://sgd-archive.yeastgenome.org/curation/calculated_protein_info/protein_properties.tab"
yeast_prot_props <-
  read_tsv(url, show_col_types = FALSE) |>
  clean_names() |>
  rename(systematic_name = orf) |>
  select(-starts_with("assuming")) |>
  mutate(across(
    c(
      gravy_score,
      aromaticity_score,
      cai,
      codon_bias,
      fop_score,
      carbon:sulphur,
      instability_index_ii,
      aliphatic_index
    ),
    as.double
  ))

usethis::use_data(yeast_prot_props, overwrite = TRUE)
