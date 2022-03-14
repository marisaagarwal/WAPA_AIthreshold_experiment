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
            summarize(mean_n_AI = mean(n_preconfirmed_annotations),
                      se_n_AI = std.error(n_preconfirmed_annotations),
                      mean_prop_AI = mean(n_preconfirmed_annotations/50),
                      se_prop_AI = std.error(n_preconfirmed_annotations/50),
                      time_spent_for50_inseconds = sum(time_spent),
                      mean_user_annotation_time = mean(time_spent), 
                      se_user_annotation_time = std.error(time_spent), 
                      mean_AI_accuracy = mean(propAIannotations_correct), 
                      se_AI_accuracy = std.error(propAIannotations_correct))
    
    total_time = experiment_summary %>% 
                    group_by(confidence_threshold, time_spent_for50_inseconds) %>%
                    summarize(time_spent_for50_inmin = time_spent_for50_inseconds/60)
    

## 3. Confidence threshold vs. number annotations done by AI 
    
    # # ANOVA
    # 
    #     # check assumptions --> not met
    # 
    #         # any extreme outliers? --> only three, so not that bad; proceed
    #         experiment_data %>%
    #             group_by(confidence_threshold) %>%
    #             identify_outliers(n_preconfirmed_annotations)
    # 
    #         # normal? --> all groups significant, so not normal, normality violated
    #         experiment_data %>%
    #             group_by(confidence_threshold) %>%
    #             do(shapiro_test(experiment_data$n_preconfirmed_annotations))
    # 
    #         # homogeneity of variance? --> significant, so violated
    #         experiment_data %>%
    #             levene_test(n_preconfirmed_annotations ~ confidence_threshold)
    
    # Kruskal-Wallice (non-parametric)
    
        # perform the test
        experiment_data %>%
            kruskal_test(n_preconfirmed_annotations ~ confidence_threshold)
    
        # # post-hoc Dunn test
        # experiment_data %>%
        #     dunn_test(n_preconfirmed_annotations ~ confidence_threshold)
    
        # pairwise Wilcox tests
        experiment_data %>%
            wilcox_test(n_preconfirmed_annotations ~ confidence_threshold)
       
    

## 4. Confidence threshold vs. time spent per photo
    
    # # ANOVA 
    # 
    #     # check ANOVA assumptions
    #     
    #         # any extreme outliers? --> only one, so not that bad; proceed 
    #         outlier_check1 = 
    #             experiment_data %>% 
    #                 group_by(confidence_threshold) %>%
    #                 identify_outliers(time_spent)
    #         
    #         # normal? --> 2 group significant, so not normal, normality violated
    #         experiment_data %>%
    #             group_by(confidence_threshold) %>%
    #             shapiro_test(time_spent)
    #         
    #         # homogeneity of variance? --> significant, so violated 
    #         experiment_data %>%
    #             levene_test(time_spent ~ confidence_threshold)
    #         
    #     # perform one-way ANOVA
    #     experiment_data %>% 
    #         anova_test(time_spent ~ confidence_threshold)
    #     
    #     # post-hoc Tukey test
    #     experiment_data %>% 
    #         tukey_hsd(time_spent ~ confidence_threshold)
    
        
    ## Kruskal-Wallice (non-parametric)
        
        # perform the test
        experiment_data %>%
            kruskal_test(time_spent ~ confidence_threshold)
        
        # # post-hoc Dunn test 
        # experiment_data %>%
        #     dunn_test(time_spent ~ confidence_threshold)
        
        # pairwise Wilcox tests
        experiment_data %>%
            wilcox_test(time_spent ~ confidence_threshold)
    
    
## 5. Confidence threshold vs. prop AI got correct (aka AI accuracy)
        
    # # T-test

        # # check T-test assumptions
        #
        #     # any extreme outliers? --> none!
        #     outlier_check2 =
        #         experiment_data %>% 
        #         filter(!confidence_threshold == "100") %>%
        #             group_by(confidence_threshold) %>%
        #             identify_outliers(propAIannotations_correct)
        #     
        #     # normal? --> one is significant (non-normal) so not great
        #     experiment_data %>%
        #         filter(!confidence_threshold == 100) %>%
        #         group_by(confidence_threshold) %>%
        #         shapiro_test(propAIannotations_correct)
        #     
        #     # homogeneity of variance? --> not significant, great!  
        #     experiment_data %>%
        #         filter(!confidence_threshold == 100) %>%
        #         levene_test(propAIannotations_correct ~ confidence_threshold)
        #     
        # # perform T-test    
        # experiment_data %>% 
        #     filter(!confidence_threshold == 100) %>%
        #     t_test(propAIannotations_correct ~ confidence_threshold)

        
    # Kruskal-Wallis test (non-parametric)
        
        # perform the test
        experiment_data %>% 
            filter(!confidence_threshold == "100") %>%
            wilcox_test(propAIannotations_correct ~ confidence_threshold)
        
        # experiment_data %>% 
        #     mutate(propAIannotations_correct = replace_na(propAIannotations_correct, 1)) %>%
        #     kruskal_test(propAIannotations_correct ~ confidence_threshold)
        # 
        # # pairwise wilcoxon tests
        # experiment_data %>% 
        #     mutate(propAIannotations_correct = replace_na(propAIannotations_correct, 1)) %>%
        #     wilcox_test(propAIannotations_correct ~ confidence_threshold)
    
    
## 6. Proportion annotations preconfirmed by AI vs time spent 
        
    # linear regression
    preconf_time_linreg = lm(formula = time_spent ~ propannotations_byAI, 
                            data = experiment_data)    
    
    summary(preconf_time_linreg)   
    
    
## 7. Potentially problematic artifact?
    
    # more annotations confirmed by AI means more annotations correct by AI?
    
    summary(lm(propAIannotations_correct ~ propannotations_byAI,
               data = experiment_data))
                    # no significant relationship, yay no artifact!
    

    
    
    
    