## Materials

[This repository](https://github.com/liamirwin/LPS_lidRtutorial) contains the material for an 80 minute `lidR` tutorial workshop. You should install the material on your own machine from [this repository](https://github.com/liamirwin/LPS_lidRtutorial). It contains the code, the shapefiles and point-clouds we will use. The workshop intends to:

-   Present an overview of what can be done with `lidR`
-   Give users an understanding of how `lidR` may fit their needs
-   Exercises will be done depending on available time - users are encouraged to work on these after the workshop!

Find the code, exercises, and solutions used in the `.\R` directory.

## Requirements

### R version and Rstudio

-   You need to install a recent version of `R` i.e. `R 4.0.x` or newer.
-   We will work with [Rstudio](https://www.rstudio.com/). This IDE is not mandatory to follow the workshop but is highly recommended.

### R Packages

You need to install the `lidR` package in its latest version (v \>= 4.0.0).

``` r
install.packages("lidR")
```

To run all code in the tutorial yourself, you will need to install the following packages. You can use `lidR` without them, however.

``` r
libs <- c("geometry","viridis","future","sf","gstat","terra","mapview","mapedit","concaveman","microbenchmark")

install.packages(libs)
```

## Estimated schedule

-   Introduction and set-up (09:00)
-   Reading LAS and LAZ files (09:10)
-   Canopy Height Model (9:20)
-   Digital Terrain Model (9:25)
-   Vegetation Indices and Metrics (9:30)
-   Connecting ALS metrics with Optical Satellite Imagery (9:50)
-   Individual tree detection and segmentation (10:10)
-   File collection processing engine (10:30)


## Resources

We strongly recommend having the following resources available to you:

-   The [`lidR` official documentation](https://cran.r-project.org/web/packages/lidR/lidR.pdf)
-   The [lidRbook](https://r-lidar.github.io/lidRbook/) of tutorials


When working on exercises:

-   [Stack Exchange with the `lidR` tag](https://gis.stackexchange.com/questions/tagged/lidr)

## Additional Resources

-   [Silvilaser 2023 lidR tutorial - Forest Inventory Focused](https://tgoodbody.github.io/lidRtutorial/)


## `lidR`

`lidR` is an R package to work with lidar data developed at Laval University (Québec). It was developed & continues to be maintained by [Jean-Romain Roussel](https://github.com/Jean-Romain) and was made possible between:

-   2015 and 2018 thanks to the financial support of the AWARE project NSERC CRDPJ 462973-14; grantee Prof. Nicholas C. Coops.

-   2018 and 2021 thanks to the financial support of the Ministère des Forêts, de la Faune et des Parcs (Québec).

-   2021 and 2024 thanks to the financial support of Laval University.

The current release version of `lidR` can be found on [CRAN](https://cran.r-project.org/web/packages/lidR/) and source code is hosted on [GitHub](https://github.com/r-lidar/lidR).

> \[!NOTE\] Since 2024, the `lidR` package is no longer supported by Laval University, but the software will remain free and open-source. `r-lidar` has transitioned into a company to ensure sustainability and now offers independent services for training courses, consulting, and development. Please feel free to visit their [website](https://www.r-lidar.com/) for more information.

