# Super Rugby

This R package contains the `superrugby` dataset. This is a dataset of all Super
Rugby match results from 1996 - 2015.

Thanks to [Kevin Lassen](http://www.lassen.co.nz/s14tab.php) for meticulously 
collating the original database.

## Installation and usage

Install it from github with:

```{r}
devtools::install_github("thmcmahon/superrugby")
```

Load the dataset with:

```{r}
data(superrugby) 
```

More information on the variables in the dataset is available in the help file.

```{r}
?superrugby
```
