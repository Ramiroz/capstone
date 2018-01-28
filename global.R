#
# This is a Shiny web application. 
# This is the Global.R file which includes all the libraries and functions
# The global.R file will be loaded before either ui.R or server.R.
# The following functions are in the Global.R file
# Loading the Frequency N-Gram files
# Extracting last N words in a sentence
# Vector Match. Matching 

library(shiny)
library(shinythemes)
library(quanteda)
library(stringr)

##### LOADING n-gram Frequency tables ####
freq1grm <- readRDS("./data/freq1grm.rds")
freq2grm <- readRDS("./data/freq2grm.rds") 
freq3grm <- readRDS("./data/freq3grm.rds")
freq4grm <- readRDS("./data/freq4grm.rds")


#### TRIM the Frequency vector for faster operation and processing #####
#freq1grm <- freq1grm[which(freq1grm > 6)]
#freq2grm <- freq2grm[which(freq2grm > 3)]
#freq3grm <- freq3grm[which(freq3grm > 1)]

##### EXCTRACTION FUNCTION ####
# Function to extract the last n words of a string and replace spaces with "_"
# Input: "Hi My name is Ramy Hashem", ngram=4
# Output: "name_is_Ramy_Hashem"
extrct_str <- function(txt, ngram) {
    txt <- str_trim(txt) #trim the spaces from begining and end of sentence
    word_count <- str_count(txt," ") + 1 #number of words in sentence
    
    if (ngram > word_count) {
        return(NA)
        stop()
    } else {
        toks_txt <- texts(txt) %>% char_tolower() %>% 
            tokens(remove_punct=T, remove_separators=T, remove_numbers=T, remove_twitter=T, remove_hyphens=T, remove_url=T, remove_symbols = T)
        txt <- paste(unlist(txt),collapse = ' ')
        
        txt <- gsub(" ","_",txt) #format and replace spaces with "_"
        extr <- word(txt,-ngram,-1, "_")  #extract last ngram word of the sentense
        return(extr)
    }
}

### WORD MATCH VECTOR FUNCTION ####
# Function to return a vector of ngram words matching the input text
# Input: "be on my"
# Output intermediate: Vector -> be_on_my_own 3 | be_on_my_show 2 | be_on_my_way 1 ....
# Final Output: Vector > own 3 | show 2 | way 1 
word_match <- function(txt, ngram) {
    freqXgrm <- get(paste0("freq",ngram,"grm")) #convert the string into the object name
    freq <- freqXgrm[grepl(paste0("^",txt,"_"),names(freqXgrm),ignore.case = T,useBytes = T)] #lookup the text (start of sentence)
    if (sum(freq)==0) {
        return(NA)
        stop()
    } else {
        freq <- sort(freq,decreasing = TRUE)
        names(freq) <- word(names(freq),-1,-1,"_") #Extract only the last word of the sentence 
        return(freq)  
    }
}


###### Main Function for N-Grams matching the word ######
ngram_result <- function(txt, validation = FALSE) {
    #### set all the values
    #txt <- str_trim(txt) #trim the spaces from begining and end of sentence
    gammagrm <- 0.5
    discounted_n4grm <- 0; 
    discounted_n3grm <- 0; discounted_n3grm_wgt <- 0;
    discounted_n2grm <- 0; discounted_n2grm_wgt <- 0;
    discounted_n1grm_wgt <- 0
    alpha_n4grm <- 0; alpha_n3grm <- 0; alpha_n2grm <- 0
    
    #### N-Gram vector Match ---------------
    n4grm_match_vctr <- word_match(extrct_str(txt,3),4) #Extract an n-gram vector for the previous 3 words match; while returning the last word only of the 4-gram word
    n3grm_match_vctr <- word_match(extrct_str(txt,2),3) #Extract an n-gram vector for the previous 2 words match; while returning the last word only of the 3-gram word
    n2grm_match_vctr <- word_match(extrct_str(txt,1),2) #Extract an n-gram vector for the previous 1 words match; while returning the last word only of the 2-gram word
    
    #### Subsetting -----
    # if the 4-gram match exists then exclude from the 3-Gram match vector all those common with 4-Gram 
    if (!is.na(n4grm_match_vctr[[1]])) {
        n3grm_match_vctr_fltr <- n3grm_match_vctr[-which(names(n3grm_match_vctr) %in% names(n4grm_match_vctr))]
    } else { #otherwise the 3-Gram is the same (no exclusions)
        n3grm_match_vctr_fltr <- n3grm_match_vctr
    }
    
    if (!is.na(n3grm_match_vctr[[1]])) { # if the 3-gram match exisits then exclude from the 2-Gram vector all those common with 3-Gram
        n2grm_match_vctr_fltr <- n2grm_match_vctr[-which(names(n2grm_match_vctr) %in% names(n3grm_match_vctr))]
    } else {
        n2grm_match_vctr_fltr <- n2grm_match_vctr
    }
    
    ### 4-gram Discounted Vector -----
    if (!is.na(n4grm_match_vctr[[1]])) {
        n4grm_freq_sum <- sum(n4grm_match_vctr)                           # sum all frequencies of the matched vector
        discounted_n4grm <- (n4grm_match_vctr-gammagrm)/n4grm_freq_sum    # calculate the discounting (Count words - 0.5)/sum(count words)
        alpha_n4grm <- (1- sum(discounted_n4grm))                         # Calculate the remainder of this operation for unseen words
    }
    
    ### 3-GRAM Weighted Discounted Vector -----
    n3grm_freq_sum <- sum(n3grm_match_vctr_fltr)
    discounted_n3grm <- (n3grm_match_vctr_fltr-gammagrm)/n3grm_freq_sum #discounted 3-Gram for seen words
    
    if (!is.na(n4grm_match_vctr[[1]])) {
        alpha_n3grm <- 1- sum(discounted_n3grm)   # remainder for unseen words
        discounted_n3grm_wgt <- (1-alpha_n3grm) * alpha_n4grm * discounted_n3grm #Weighted discounting of 3-Gram
    } else if (!is.na(n3grm_match_vctr[[1]])) {
        discounted_n3grm_wgt <- discounted_n3grm
    }
    
    
    ### 2-GRAM Weighted Discounted Vector -----
    n2grm_freq_sum <- sum(n2grm_match_vctr_fltr)
    discounted_n2grm <- (n2grm_match_vctr_fltr)/n2grm_freq_sum #discounted 2-Ngram for seen words
    
    if (!is.na(n4grm_match_vctr[[1]])) {
        alpha_n2grm <- alpha_n4grm - sum(discounted_n3grm_wgt)
        discounted_n2grm_wgt <- alpha_n2grm * discounted_n2grm
    } else if (!is.na(n3grm_match_vctr[[1]])) {
        alpha_n2grm <- 1 - sum(discounted_n3grm_wgt)
        discounted_n2grm_wgt <- alpha_n2grm * discounted_n2grm
    } else if (!is.na(n2grm_match_vctr[[1]])) {
        alpha_n2grm <- 1
        discounted_n2grm_wgt <- alpha_n2grm * discounted_n2grm
    } else {
        discounted_n1grm_wgt <- freq1grm/sum(freq1grm)          # if no 4,3,2 Grams match, then use the Uni-gram for prediction
    }
    
    discounted_ngrm <- c(head(discounted_n4grm), head(discounted_n3grm_wgt), head(discounted_n2grm_wgt), head(discounted_n1grm_wgt))
    discounted_ngrm <- sort(discounted_ngrm,decreasing = TRUE)
    return(discounted_ngrm[1:5])
}
