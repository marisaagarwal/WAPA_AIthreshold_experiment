# 2022-03-07


## 1. Set up

    # point to data locale
    data_locale = "data/"
    
    # point to data file
    data_file = "AI Threshold Experiment - all categories.xlsx"
    
    # call to data
    experiment_data = 
        paste0(data_locale, data_file) %>%
        read_excel()

    # check structure of data
    str(experiment_data)


## 2. Groom data
    
    # make confidence threshold a factor
    experiment_data$confidence_threshold =
      factor(experiment_data$confidence_threshold,
             levels = c(50,75, 100))
    
    # check structure of data
    str(experiment_data)
    
      
## 3. Add columns
    
    # proportion of AI annotations completed, then prop that were correct & wrong
    experiment_data %<>%
        mutate(propannotations_byAI = n_preconfirmed_annotations/n_annotations,
               propAIannotations_wrong = n_preconfirmed_wrong / n_preconfirmed_annotations,
               propAIannotations_correct = 1 - propAIannotations_wrong)

    
    
    
    
    
    

