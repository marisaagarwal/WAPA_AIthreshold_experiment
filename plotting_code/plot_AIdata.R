# 2022-03-07

## 1. Set up

    # point to data locale
    data_locale = "analysis_code/"
    
    # load in the data
    source(paste0(data_locale, "analyze_AIdata.R"))
    
    str(experiment_data)


## 2. Plotting time spent per photo at different AI thresholds
    
    # boxplot
    experiment_data %>%
        ggplot(aes(confidence_threshold, time_spent)) +
            geom_boxplot(aes(fill = confidence_threshold), show.legend = F) +
            scale_fill_viridis_d(alpha = 0.4) +
            geom_signif(comparisons = list(c("50", "75")), 
                        map_signif_level = TRUE,
                        y_position = 60) +
            labs(x = "AI Confidence Threshold",
                 y = "Time Spent (sec/photo)") +
            theme_light()
    
    # pointrange
    experiment_summary %>%
        ggplot(aes(confidence_threshold, mean_user_annotation_time)) +
            geom_pointrange(aes(ymin = mean_user_annotation_time - se_user_annotation_time,
                            ymax = mean_user_annotation_time + se_user_annotation_time)) +
            theme_light()
    
    
## 3. Plotting proportion of annotations correct at diff AI thresholds
    
    # boxplot
    experiment_data %>%
        ggplot(aes(confidence_threshold, propAIannotations_correct)) +
            geom_boxplot(aes(fill = confidence_threshold), show.legend = F) +
            scale_fill_viridis_d(alpha = 0.4) +
            geom_signif(comparisons = list(c("50", "75")), 
                        map_signif_level = TRUE,
                        y_position = 1.01) +
            labs(x = "AI Confidence Threshold",
                 y = "AI Accuracy **(points correct/points labelled)**") +
                theme_light()
    
 
    # pointrange
    experiment_summary %>%
        ggplot(aes(confidence_threshold, mean_AI_accuracy)) +
        geom_pointrange(aes(ymin = mean_AI_accuracy - se_AI_accuracy,
                            ymax = mean_AI_accuracy + se_AI_accuracy))+
        theme_light()

    
## 4. Plotting number annotations unknown by AI vs time spent
    
    experiment_data %>%
        ggplot(aes(n_todo_annotations/50, time_spent)) +
            geom_point(aes(color = confidence_threshold), 
                       alpha = 0.6) +
            scale_color_viridis_d() +
            geom_smooth(method = "lm") +
            labs(x = "Proportion of Points Unconfirmed by AI",
                 y = "Time Spent on Photo (sec)", 
                 color = "Confidence Threshold") +
            theme_light()
    
    
## 5. Proportion annotations connfirmed by AI vs prop annotations correct by AI
    
    experiment_data %>%
        ggplot(aes(propAIannotations_confirmed, propAIannotations_correct)) +
            geom_point(aes(color = confidence_threshold)) +
            geom_smooth(method = "lm") +
            scale_color_viridis_d() +
            theme_light()
    
        
    