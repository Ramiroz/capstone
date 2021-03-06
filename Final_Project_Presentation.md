Capstone Project - Word Prediction
========================================================
author: Ramy Hashem
date: 28th January 2018
autosize: true

Coursera Data Science Specialization  

[The Application is on this link] (https://ramiroz.shinyapps.io/wordprediction/)  
[The Code on Github click here] (https://github.com/Ramiroz/capstone)  
[![linkedin](linkedin.jpg)] (https://www.linkedin.com/in/ramy-hashem-b9981644/)  
<small>[Linked-in Profile] (https://www.linkedin.com/in/ramy-hashem-b9981644/)</small>

Word Prediction App
========================================================
[![word](word_logo.png)] (https://ramiroz.shinyapps.io/wordprediction/)  
This word prediction application relies on 3 datasets from Twitter, Blogs and News.  
The collection of words "corpora"" includes 4.2 Million Lines and 104 Million Words. Out of which 5% Sampled.

This Word Prediction App Release 1.0 *Top Features*:  
- Word Prediction Speed
- User Friendly Interface
- Intuitive Interface
- 5 Top predicted words 

Model Alogarithm
========================================================

The alogarithm for word predition follows Katz Discounted Backoff Model for 4-gram words all the way down to Uni-gram. 

The full corpora characteristics analysis can be found [*here on this link*] (http://rpubs.com/Ramiroz/capstone_milestone)

The following model has been applied:
- <small>Forming 4-gram, 3-gram, bi-gram and Uni-gram Frequency Matrix</small>
- <small>Triming the Frequency Matrix for the low frequency words</small>
- <small>Match the written sentence last 4 words to the 4-gram matrix</small>
- <small>Discounting the matching matrix and maintaining the remainder for unseen words</small>
- <small>Applying the unseen portion to 3-gram model, then bi-gram and finally Uni-gram</small>

How the App Works - Demo
========================================================
left: 30%
- <small>Start writing your sentence</small>
- <small>Once you hit a 'space'</small>
- <small>The top predicted words would show in the 5 boxes below</small>
- <small>Either type the word followed by 'space' or click the box with the most suitable predicted word</small>

***  
[![demo](wordprediction.gif)] (https://ramiroz.shinyapps.io/wordprediction/)  

Acknowledgment
========================================================
Special thanks to Johns Hopkins University and the great professors Brian Caffo, Jeff Leek and Roger D. Peng  

<small>Thanks to my family and friends who supported me during the specialization</small>  

*Acknowledgements to great resources on the internet on 'Natural Language Processing'*  
- <small>[Youtube Video Estimating N-gram Probabilities - Stanford NLP - Professor Dan Jurafsky & Chris] (https://www.youtube.com/watch?v=o-CvoOkVrnY&t=66s)</small>  
- <small>[Youtube Video Markov Processes - Columbia University] (https://www.youtube.com/watch?v=ruU_Y0iCMDA)</small>  
- <small>[The great guide of Michael Szczepaniak - Predicting Next Word Using Katz Back-Off] (https://rpubs.com/mszczepaniak/predictkbo3model)</small>  

<small>And Finally Special Thanks to All colleagues who contributed strongly in the course Forum</small>  
