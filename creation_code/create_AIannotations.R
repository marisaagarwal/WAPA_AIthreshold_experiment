# 2022-03-11


## 1. Set up

    # point to data locale
    data_locale = "data/"
    
    # point to data file
    data_file1 = "allcategories_50thresh_expt_annotations.csv"
    data_file2 = "allcategories_75thresh_expt_annotations.csv"
    
    # call to data
    annotations50 = 
        paste0(data_locale, data_file1) %>%
        read_csv()
    
    annotations75 = 
        paste0(data_locale, data_file2) %>%
        read_csv()
    
    # check structure of data
    str(annotations50)
    str(annotations75)


## 2. Groom data

    # add confidence threshold column to each data frame
    annotations50$confidence_threshold = "50"
    annotations75$confidence_threshold = "75"  
    
    # remove empty columns
    annotations50 %<>%
        dplyr::select(c("Name", 19:34))
    
    annotations75 %<>%
        dplyr::select(c("Name", 19:34))

    # combine data frames
    all_annotations = rbind(annotations50, annotations75)

    
    
    