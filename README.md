# Stocks


## Architecture

This app utilizes the MVVM approach, which I chose due to my familiarity with it from developing Android apps. I appreciate the clear division of responsibilities from UI to supporting models. This approach offers increased flexibility when modifying formatting and easier to find where changes should be made. Additionally, it simplifies the testing of code that manipulates models for user display. Another advantage is that the UI View solely focuses on layout and formatting, avoiding unnecessary code bloat and enhancing class comprehension speed.

I also attempted dependency injection for the first time in Swift. I have enjoyed the testablility of code built on this principle in Kotlin/Java and Php and thought it would be a fun challenge. While the backend code has dependency injection at the heart, I wasn't able to get a depencendy injection container working to match best practices in the front end. I studied this github repository to understand how I could create a depedency container
- https://github.com/nalexn/clean-architecture-swiftui/tree/mvvm



## Trade Offs

1. No third party libaries. Decided to build this using no 3rd party libraries. I could have used something like Alamofire for any HTTP networking requests but with only needing to get information from one endpoint, doing the extra setup and adding extra complexity to the app seemed unnecessary. This could easily be adopted into the ApiService class if further product requirements dicated it

2. MVVM vs MVC archiecture. I've traditionally built iOS apps using an MVC approach with UIKit. So adopting MVVM did slow down my development process and thinking through where everything would live and code structure. When looking for help in blogs or stackoverflow, it is also evident that the iOS community split over MVVM and MVC. Since Apple doesn't recommend a structure either way, it can be harder to find ladder solutions you're experiencing.

3. Dependency injection. After going through this work, I found the depedency injection container to bit of over-engineering for the Swift language. You can ensure all your code is still testable through mocking basic Swift protocols and ensuring initializtion of your struct/classes happens with appropriate variables to override. I also think, trying to implement this technique with those who aren't familiar with other languages and programming paradigms, it would take them longer to onboard and then implement features. It would make it easier for someone to move from Swift to Kotlin and implement features across both platforms though.


## How to run

1. Download project files
2. Open project via XCode
3. Build & run

## 3rd party libraries, copied code, and other resources used
- Clean Archiecture SwiftUI - https://nalexn.github.io/clean-architecture-swiftui/
- https://github.com/nalexn/clean-architecture-swiftui/tree/mvvm
- https://developer.apple.com/tutorials/app-dev-training/
- Stackoverflow
- Medium blogs
- Udemy courses

Two files are copied from other's code:
1. ActivityIndicator
2. ErrorView


## Other information
I was unable display the correct currency symbol given the stock's country code. I went through a lot of iterations on this and spent a lot of time on stackoverflow and in docs. I was looking for a solution that didn't require me to hardcode or maintain a data source. Trying to get a Locale or NSLocale to initialize properly was my struggle. 



