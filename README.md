
# HealthCloud
##### *HealthCloud: A System for Monitoring Health Status of Heart Patients using Machine Learning and Cloud Computing*
Code for this project is accessible on [Github](https://github.com/Forum-123/Predictive-Heart-Disease-Model)

![iOS](https://img.shields.io/badge/iOS-12.1-blue) ![macOS](https://img.shields.io/badge/macOS-11.5-blue) ![XCode](https://img.shields.io/badge/XCode-12.5-blue) ![Swift](https://img.shields.io/badge/Swift-5-blue)

<img src="https://user-images.githubusercontent.com/69541616/129606144-bb46f234-082f-4806-bf48-8342bb6ec7c1.png" width=33%> <img src="https://user-images.githubusercontent.com/69541616/129606153-d3e6d68e-5f43-4736-8033-1f151082d80b.png" width=33%> <img src="https://user-images.githubusercontent.com/69541616/129606161-dc9fea7a-33f9-4333-b559-252ab24bec7b.png" width=33%>

### Features
- Prototype application for a mobile device for the user to use. This offers a visual display and automated response to the user of their chances of having heart disease. 
- Built using the Logistic Regression Machine Learning model on the Cleveland Heart Disease from the UCI Machine Learning Repository, also available in the `heart_data.csv` file.
- The user can manually enter their medical data, which must be measured externally from the app, and with the help of Machine Learning the app will provide some advice to the user according to their results. 
- Supported on iPhone, iPad and Mac devices. 

### How to use the application
1. Download or clone the repository:
```sh
git clone https://github.com/Forum-123/Predictive-Heart-Disease-Model.git
cd PredictiveHeartDiseaseApp
```
2. Open `PredictiveHeartDiseaseApp.xcworkspace` in Xcode.
3. Choose the device that you wish to run the application on.
4. Build the project & run either on a simulator or a physical device.

### View Data Analysis
1. Download or clone the repository:
```sh
git clone https://github.com/Forum-123/Predictive-Heart-Disease-Model.git
cd Data Analysis
```
2. Open `Data Exploration and Cleaning.ipynb` for the Python code for data cleaning and `Model Evaluation.ipynb` for the Python code on training and evaluating Machine Learning models  on [Google Colaboratory](https://colab.research.google.com/notebooks/intro.ipynb?utm_source=scs-index) or Anaconda (Jupyter).
3. To calculate memory usage, open `Measuring Memory Usage.py` and run `python "Measuring Memory Usage.py"`.

### Data
The original Heart Disease dataset can be downloaded from the [UCI Machine Learning Repository's Heart Disease directory](https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/) (processed.cleveland.data).
Database Donor: David W. Aha (aha@ics.uci.edu) (714) 856-8779

### Warning
The copyright of the shared work is reserved. Reference should be cite to the HealthCloud article for use in academic studies.

### To cite
Forum Desai, Deepraj Chowdhury, Rupinder Kaur, Marloes Peeters, Rajesh Chand Arya, Gurpreet Singh Wander, Sukhpal Singh Gill and Rajkumar Buyya, HealthCloud: A system for monitoring health status of heart patients using machine learning and cloud computing, Elsevier Internet of Things (2021), doi: https://doi.org/10.1016/j.iot.2021.100485.
