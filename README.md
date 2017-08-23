# shinyscaffold
Create boilerplate code for Shiny web applications

# Installation
The package can be installed directly from github using `devtools`.

```r
install.packages("devtools")
library(devtools)
install_github("nz-stefan/shinyscaffold")
```

# Usage
```r
library(shinyscaffold)

# create a configuration file
scaffold_config("/tmp/my-config.yml")

# scaffold a Shiny app from the config file
setwd("/tmp")
scaffold_app("/tmp/my-config.yml")
```
