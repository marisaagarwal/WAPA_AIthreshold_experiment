# 2022-03-11


## 1. Set up

    # point to data locale
    data_locale = "creation_code/"
    
    # load in the data
    source(paste0(data_locale, "create_AIannotations.R"))
    
    # check data structure
    str(annotations50)
    str(annotations75)

    
## 2. Basic summary items
    
    # how many annotations did the AI do out of the 50 points
    summary50 = 
        annotations50 %>%
            group_by(Name) %>%
            summarize(n_MA = length(which(Annotator == "marisa_agarwal")),
                      n_AI = length(which(Annotator == "Alleviate")),
                      prop_AI = n_AI / 50, 
                      confidence_threshold = 50)
    
    summary75 = 
        annotations75 %>%
            group_by(Name) %>%
            summarize(n_MA = length(which(Annotator == "marisa_agarwal")),
                      n_AI = length(which(Annotator == "Alleviate")),
                      prop_AI = n_AI / 50, 
                      confidence_threshold = 75)
    
    summary100 = data.frame(Name = summary75$Name,
                            n_MA = rep(c(50),50),
                            n_AI = rep(c(0),50), 
                            confidence_threshold = 100) %>%
                    mutate(prop_AI = n_AI/50)
        
    
    # how did the number of points annotated by AI vary between Confidence Thresholds
    annotation_summary = 
        rbind(summary50, summary75, summary100) %>% 
            group_by(confidence_threshold) %>%
            summarize(mean_n_AI = mean(n_AI),
                      se_n_AI = std.error(n_AI), 
                      mean_prop_AI = mean(prop_AI),
                      se_prop_AI = std.error(prop_AI))
    
            # was that difference significant?
    
                    # can we do parametric tests?
                    
                    
    
    
    
        
## 3. What were the annotations that were wrong most frequently
    
    correction_counts = 
        all_annotations %>%
            filter(Annotator == "marisa_agarwal") %>%       # to select for the ones I changed manually
            group_by(confidence_threshold) %>%
            count(Label, `Machine suggestion 1`) %>%
            filter(Label != `Machine suggestion 1`)  %>%    # filter out where I wasnt actually changing anything, (ie when i was already manually annotating)
            mutate(total_misIDed = sum(n),
                   prop_misIDed_ofwrong = n/total_misIDed,
                   prop_misIDed_overall = total_misIDed / 2500)
                  
        
        
        
        