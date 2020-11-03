# NewYorkTimesDemo
A news demo creating berfore big election day, used to fetch updatest news.

## Following Test-Driven-Development (TDD)
Unit test procedure is deployed, to build a soild / bugless project.

First, create the test "Target", and create test cases for different cases. 

Second, to avoid data-related issues, building the test cases focusing on Models and ViewModels,
 - red: build XCTests in test cases, and run the tests
 - green: implement the feature that related the test, then run the test again
 - refactor: iterate the step of "red" and "green", to implement more features in test cases

At last, the code coverage is over 65% of the whole project.

## Using Model-View-ViewModel (MVVM) architechture design pattern
MVVM is chosen to be used into this project, in order to reduce code-coupling, and it is easier for test job.

## IDE
Xcode 12.1
Swift 5.3
Nice to fit devices later than iPhone 8

## API references
https://developer.nytimes.com/


![giphy](https://user-images.githubusercontent.com/63318597/98021781-ba3f9980-1dd2-11eb-83e9-aac3777b1ee5.gif)
