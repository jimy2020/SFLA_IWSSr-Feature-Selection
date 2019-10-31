<h1> SFLA_IWSSr-Feature-Selection </h1>

 SFLA_IWSSr is hybrid method for feature selection. In this method, a hybrid method based on the IWSSr method and Shuffled Frog Leaping Algorithm (SFLA) is proposed to select effective features in a large-scale gene dataset. The proposed algorithm is implemented in two phases: filtering and wrapping. In the filter phase, the Relief method is used for weighting features. Then, in the wrapping phase, by using the SFLA and the IWSSr algorithms, the search for effective features in a feature-rich area is performed.

 <h1> Requirement: </h1> 

This program is suitable for MATLAB R2017 and above versions. <br>
The program has adopted by Colon dataset. By some little change it can be used for any input data. <br>
This program uses the SU method in the filter phase. You must use the following package to use ReliefF method.
https://in.mathworks.com/matlabcentral/fileexchange/22970-feature-selection-using-matlab?focused=5164694&tab=function <br>
This program has adopted by CLASSIFY Discriminant analysis. By some little change in the ImproweFrog_WithIwssr.m file it can be used any classifier such as SVM,KNN,Bayes and Desicion Tree. (please see classifiers folder)<br>


<h1> Running SFLA_IWSSr: </h1>
For this purpose it is only need to run Main_SFLA.m file. <br>
You can change and set the hyper parameters in the variable.m file.

<h1> Feedback: </h1>
Its pleasure for me to have your comment. j.pirgazi@znu.ac.ir

