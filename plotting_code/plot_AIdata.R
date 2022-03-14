# 2022-03-07

## 1. Set up

    # point to data locale
    data_locale = "analysis_code/"
    
    # load in the data
    source(paste0(data_locale, "analyze_AIdata.R"))
    
    str(experiment_data)
    
  
## 2. Plotting number of annotations done by AI at different thresholds

    # boxplot
    experiment_data %>%
      ggplot(aes(confidence_threshold, n_preconfirmed_annotations)) +
        geom_boxplot(aes(fill = confidence_threshold), show.legend = F) +
        scale_fill_viridis_d(alpha = 0.4) +
        geom_signif(test = "wilcox.test", 
                    comparisons = combn(
                      levels(experiment_data$confidence_threshold),
                      2,
                      simplify = F),
                    step_increase = 0.2,
                    map_signif_level = T) +
        # stat_compare_means(method = "kruskal.test", label.y = 170) +
        labs(x = "Confidence Threshold",
             y = "Number of Annotations Done by Feature Extractor") +
        theme_pubr()
    
    
## 3. Plotting time spent per photo at different thresholds
    
    # boxplot
    experiment_data %>%
        ggplot(aes(confidence_threshold, time_spent)) +
            geom_boxplot(aes(fill = confidence_threshold), show.legend = F) +
            scale_fill_viridis_d(alpha = 0.4) +
            geom_signif(test = "wilcox.test", 
                        comparisons = combn(
                            levels(experiment_data$confidence_threshold),
                            2,
                            simplify = F),
                        step_increase = 0.2,
                        map_signif_level = T) +
            # stat_compare_means(method = "kruskal.test", label.y = 170) +
            labs(x = "Confidence Threshold",
                 y = "Annotation Time (sec/photo)") +
            theme_pubr()
    
    
    # pointrange
    experiment_summary %>%
        ggplot(aes(confidence_threshold, mean_user_annotation_time)) +
            geom_pointrange(aes(ymin = mean_user_annotation_time - se_user_annotation_time,
                            ymax = mean_user_annotation_time + se_user_annotation_time)) +
            theme_light()
    
    
## 4. Plotting proportion of annotations correct at diff AI thresholds
    
    # boxplot
    experiment_data %>%
        filter(!confidence_threshold == "100") %>%
        # mutate(propAIannotations_correct = replace_na(propAIannotations_correct, 1)) %>%
            ggplot(aes(confidence_threshold, propAIannotations_correct)) +
                geom_boxplot(aes(fill = confidence_threshold), show.legend = F) +
                scale_fill_manual(values = alpha(c("#440154FF", "#238A8DFF"), 0.4)) +
                # scale_fill_viridis_d(alpha = 0.4) +
                geom_signif(test = "wilcox.test",
                            comparisons = list(c("50", "75")),
                            map_signif_level = TRUE) +
                # geom_signif(test = "wilcox.test", 
                #             comparisons = combn(
                #                 levels(experiment_data$confidence_threshold),
                #                 2,
                #                 simplify = F),
                #             step_increase = 0.2,
                #             map_signif_level = T) +
                labs(x = "Confidence Threshold",
                     y = "Feature Extractor Accuracy") +
                theme_pubr()
    
 
    # pointrange
    experiment_summary %>%
        filter(!confidence_threshold == "100") %>%
            ggplot(aes(confidence_threshold, mean_AI_accuracy)) +
                geom_pointrange(aes(ymin = mean_AI_accuracy - se_AI_accuracy,
                                    ymax = mean_AI_accuracy + se_AI_accuracy))+
                theme_light()

    
## 5. Plotting proportion annotations unknown by AI vs time spent
    
    experiment_data %>%
        ggplot(aes(propannotations_byAI, time_spent)) +
            geom_point(aes(color = confidence_threshold), 
                       alpha = 0.6) +
            scale_color_viridis_d() +
            geom_smooth(method = "lm") +
            # geom_smooth(method = "loess") +
            labs(x = "Proportion of Points Confirmed by Feature Extractor",
                 y = "Time Spent Annotating Photo (sec)", 
                 color = "Confidence Threshold") +
            theme_pubr(legend = "bottom")
    
  
## 6. Plotting potentially problematic artifacts    
      
    # proportion annotations confirmed by AI vs prop annotations correct by AI
        
        experiment_data %>%
            filter(!confidence_threshold == "100") %>%
                ggplot(aes(propannotations_byAI, propAIannotations_correct)) +
                    geom_point(aes(color = confidence_threshold)) +
                    geom_smooth(method = "lm") +
                    scale_color_viridis_d() +
                    theme_light()
        
     
    # time vs prop annotations correct by AI: not an artifact, unrelated     
        
        experiment_data %>%
            filter(!confidence_threshold == "100") %>%
            ggplot(aes(time_spent, propAIannotations_correct)) +
                geom_point(aes(color = confidence_threshold)) +
                geom_smooth(method = "lm") +
                scale_color_viridis_d() +
                theme_light()
    
    