# 2022-03-07

## 1. Set up

    # point to data locale
    data_locale = "creation_code/"
    
    # load in the data
    source(paste0(data_locale, "create_AIdata.R"))
    
    # check data structure
    str(experiment_data)

    
## 2. Data exploration & summary stats 
    
    # time spent annotating for whole batch of 50 expt photos
    # mean & se of time to analyze on photo
    experiment_summary = 
        experiment_data %>%
            group_by(confidence_threshold) %>%
            summarize(time_spent_for50_inseconds = sum(time_spent),
                      mean_user_annotation_time = mean(time_spent), 
                      se_user_annotation_time = std.error(time_spent), 
                      mean_AI_accuracy = mean(propAIannotations_correct), 
                      se_AI_accuracy = std.error(propAIannotations_correct))
    

## 3. ANOVA on confidence threshold vs. time spent per photo
    
    # check ANOVA assumptions
    
        # any extreme outliers? --> only one, so not that bad; proceed 
        outlier_check1 = 
            experiment_data %>% 
                group_by(confidence_threshold) %>%
                identify_outliers(time_spent)
        
        # normal? --> significant, so neither are normal, normality violated
        experiment_data %>%
            # filter(!confidence_threshold == 100) %>%
            group_by(confidence_threshold) %>%
            shapiro_test(time_spent)
        
        # homogeneity of variance? --> significant, so violated 
        experiment_data %>%
            # filter(!confidence_threshold == 100) %>%
            levene_test(time_spent ~ confidence_threshold)
        
    # perform one-way ANOVA
    experiment_data %>% 
        # filter(!confidence_threshold == 100) %>%
        anova_test(time_spent ~ confidence_threshold)
    
    # post-hoc Tukey test
    experiment_data %>% 
        # filter(!confidence_threshold == 100) %>%
        tukey_hsd(time_spent ~ confidence_threshold)
    
    
## 4. ANOVA on confidence threshold vs. prop AI got correct (aka AI accuracy)
    
   # check ANOVA assumptions
        
        # any extreme outliers? --> none! 
        outlier_check2 = 
            experiment_data %>% 
            group_by(confidence_threshold) %>%
            identify_outliers(propAIannotations_correct)
        
        # normal? --> one is significant, so not great
        experiment_data %>%
            # filter(!confidence_threshold == 100) %>%
            group_by(confidence_threshold) %>%
            shapiro_test(propAIannotations_correct)
        
        # homogeneity of variance? --> not significant, great!  
        experiment_data %>%
            # filter(!confidence_threshold == 100) %>%
            levene_test(propAIannotations_correct ~ confidence_threshold)
        
    # perform one-way ANOVA    
    experiment_data %>% 
        # filter(!confidence_threshold == 100) %>%
        anova_test(propAIannotations_correct ~ confidence_threshold)
        
    # post-hoc Tukey test 
    experiment_data %>% 
        # filter(!confidence_threshold == 100) %>%
        tukey_hsd(propAIannotations_correct ~ confidence_threshold)
    
    
    
    
    
    
    
    
    
    