# gluestick 0.1.1  2021-06-05

* Escape any '%' in fmt string which might exist elsewhere 
  (as long as it's not followed by 's')
* Add logical argument `eval`
    * If `TRUE` then evaluate expressions as R code
    * If `FALSE` treat expressions as variable names and `mget()` them from 
      the data source.

# gluestick 0.1.0  2021-06-04

* Initial release