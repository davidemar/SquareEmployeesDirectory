## Build tools & versions used
This application was built using Xcode version 13.4.1 and Swift 5

## Steps to run the app
- Clone the repository
- Run the application
- The application was designed on an iPhone using iOS 15.5, but it supports iPad and changing the device orientation

## What areas of the app did you focus on?
- Since the requirement is to have a production ready I focused in:
    - MVVM and classes depending in abstractions and not in implementations.
    - Testing failing the first time to get employees with 0 employees but after pulling to reload display the employees(attached video)
    - I added a Logger so that later we can add telemetry libraries like Crashlytics, Kochava, Firebase Analytics, Facebook Analytics, to get important information of errors and user data.
    - I added important unit tests in the view model and storing images, the the development was done thinking about the importance of testing and having protocols to make easy to test classes without having the dependency of the implementation of a class, the unit tests added right now are: 
            - saving images
            - reading images
            - if getting 0 employees display the empty view
            - if getting more than 0 employees succesfully reload the tableview 
    - Since storing in disk is critical for the application, I saved the images by using Core data but instead of saving the data in the table what I am doing is storing the url as a key and getting the image from file systems, also before saving and downloading the image, we check if the image is already saved.
        I choose core data and File systems because we know that the images are not going to change frequently and we have the url as a key to get it.
    - The saved image is also lowered in quality since we are just using them right now in a small frame and we don't need to store big quality images, to be prepared for having a lot of users in the response and having to store a lot of images.
    - Saving and downloading just images that are in the actual scope vision of the user instead of downloading all the images at once to be prepared for the scenario where the user is getting a lot of employees.

## What was the reason for your focus? What problems were you trying to solve?
    - Having a large list of employees.
    - The main user flow being break by future development
    - Knowing when the saving images flow breaks in future development.
    - Storing performance and not downloading or save images that we already have.
    - Knowing with telemetry crashes, errors and events.

## How long did you spend on this project?
    5 hours

## Did you make any trade-offs for this project? What would you have done differently with more time?
    I think that with more time I can add more UI detailes like a button to reload in the empty view, a frame for the photos, a local search for the employees.
    Also in the SquareEmployeesAPIClient implementation the endpoint can be changed between the empty, the malformed and the success API I think that with this endpoints a dev tool can be developed that activates with a shake and can let the developer to choose an endpoint to see every response.

## What do you think is the weakest part of your project?
I think the UI is the weakes part of the project since I focused more in performance and architecture.

## Did you copy any code or dependencies? Please make sure to attribute them here!
Yes I ussed this implementation to decode just one object failing to parse in the employees list instead of not showing the whole list
https://medium.com/@michaeldouglascs/how-to-safely-decode-arrays-using-decodable-result-type-in-swift-5b975ea11ff5

## Is there any other information you’d like us to know?
Before the actual development I designed the architecture in this diagram to help me have a clear idea of what I am working on.
