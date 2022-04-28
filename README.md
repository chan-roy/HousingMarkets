# HousingMarkets
This repository is a replication of the paper Unemployment Insurance as a Housing Market Stabilizer (DOI: 10.1257/aer.20140989).

## Organization

`inputs/data` contains the raw datasets used within this paper. The data has not been included within the repository due to large filesizes.

`outputs/paper` contains the Rmarkdown file in which the report is written, with `paper.pdf` being the final knitted output and `references.bib` containing references in BibTEX format.

`scripts/` contain `R` scripts used to clean/prepare the data for presenting.

## Steps for replicating the report
Rstudio is recommended with `p5.Rproj` for workspace setup.

1. The replication data of the of the original paper must be downloaded [from here](https://www.openicpsr.org/openicpsr/project/116160/version/V1/view?path=/openicpsr/116160/fcr:versions/V1&type=project) and saved in a folder named `inputs/data`.
2. Run `scripts/01-data_conversion_and_summary.R`.
3. Open and knit `paper.Rmd`. 
