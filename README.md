# Capstone Project
# Coursera Data Science Specialization
# Word Prediction

The alogarithm for word predition follows Katz Discounted Backoff Model for 4-gram words all the way down to Uni-gram. 

The full corpora characteristics analysis can be found [here] (http://rpubs.com/Ramiroz/capstone_milestone)

The following model has been applied:
- Forming 4-gram, 3-gram, bi-gram and Uni-gram Frequency Matrix
- Triming the Frequency Matrix for the low frequency words
- Match the written sentence last 4 words to the 4-gram matrix
- Discounting the matching matrix and maintaining the remainder for unseen words
- Applying the unseen portion to 3-gram model, then bi-gram and finally Uni-gram

The .R files are in the following sequence:
Global.R
Ui.R
Server.R

Global.R file which includes all the libraries and functions
2- The global.R file will be loaded before either ui.R or server.R.
3- The following functions are in the Global.R file
4- Loading the Frequency N-Gram files
5- Extracting last N words in a sentence
6- Vector Match. Matching the input sentence with the N-Gram Frequency matrices 
