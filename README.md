# Cards App
 Automate your day with the Cards app. Programmed in Swift using the new SwiftUI framework.

![Image of Cards App](https://i.imgur.com/2JhrIIY.png)
#### By Mihajlo Mitrovic for ICS-4U1 (Mr. Tedesco)

# Project Overview
Cards allows users to create custom “cards” to quickly get informed and perform repetitive actions efficiently. The user can configure the app to show the current phase of the moon, current monthly calendar, launch their favourite contacts & apps, along with view a changing motivational quote. I feel this is the most optimal way to demonstrate the programming and software design concepts I’ve learned in this class because each card will be utilizing different programming principles.

## [Video App Preview](https://youtu.be/_skOmWEtxfU)

# Where to Start
I recommend starting by watching the preview video attached. This will give you a visualization of what the code does. From then on in the [CustomCardsApp](https://github.com/m-mitrovic/Cards-App/tree/main/CustomCardsApp) folder, I suggest starting with the "ContentView.swift" file as it is the main app home screen. In the "Cards" folder, you can see the code behind each corresponding card. After, come back to the Github README.md to read the closing remarks under the "My Progress" section.

# My Progress
Here was my progress (in chronological order) along with a summary of the challenges I faced and the timeline of my accomplishments.

## Week 1: (May 31 - June 4)
![Images of Prototypes](https://i.imgur.com/muS5O7Q.png)
The first week centered on planning the app, wireframing a prototype, and building the skeleton of the app. I branded the app and designed most of the main screens that way I can focus on strictly coding in the weeks to come.

### Challenges I've Overcame
- The main challenge I faced this week was how I would permanently save the cards a user makes for the next time they run the app. I overcame this by making a `Card` class that only utilized `Strings` & Numbers to save data. This meant saving the Color as a HEX string and converting it to SwiftUI. Since the `Card` class only uses basic Swift values, I can use Apple's UserDefaults framework to save it to a file and access it every time a user uses the app.

## Week 2: (June 7 - June 11)
<img src="https://i.imgur.com/xAZdF0d.jpg" width="300">
In week 2, I focused on building the different cards. I began with the Moon Phases cards utilizing the framework SunMoonCalc<sup>1</sup>. I then went on to complete the contacts card, along with working on the calling/messaging actions of that card. I finally ended the week by creating an intro pop-up to direct new users.

### Challenges I've Overcame
This week was littered with smaller challenges, but the main ones were:
- During the development process of the moon phase card, I couldn't figure out how to dim the image of the moon with regards to the illumination percentage. The issue is that the moon has an ever changing-shadow which is once a circle, and then a crescent. I had to get creative, so instead of overlaying an additional circle to act as the moon's shadow, I utilized SwiftUI Paths for the first time. SwiftUI Paths let me draw a custom path of my own (a circle or a crescent). I got to work, and by using the illumination percentage, I finally built a shadow that would accurately display the moon's illumination.
- Another issue that plaugued me for a while was with the contact card. Since users input a phone number in many different styles, I needed my app to conform to a single style for all phone numbers included. What I found through trial and error was that if I stripped all the spaces, dashes, and parentheses from the phone number, they could all follow the same format and work!

## Week 3: (June 14 - June 16)
<img src="https://i.imgur.com/y3v1Tzj.jpg" width="300">
In the final week, I've created a changing quotes card (parsed from an online JSON format), a digital calendar, and have finalized the app. I completed the introduction process for first-time users and fixed any withstanding bugs in the app.

### Challenges I've Overcame
- Accessing the quotes from an online database<sup>3</sup> was filled with issues that I had to overcome. At first, parsing the data wasn't working because the `Quote` class did not match with the JSON class that was provided. After adjusting the variable key names and adding an additional `CodingKeys` enum to the class, the quotes were finally parsed correctly. However, the issues didn't stop there. I then had to cache the quote on each app load because it would be too inefficient and unresponsive to request new ones every time a user updates the view/cards. The solution to this issue was much more straightforward - I included a global variable called `cachedQuote` which = nil if no quotes are loaded, or returns the cached quote if it has already loaded.
- The next issue I faced was with the calendar card. I needed a way for the card text to be edited from the card hosting view and not the `CalendarGridView`. I first tried passing the `Card` property to the `CalendarGridView`, and although I was able to edit it - I still wanted to be able to style it from the card view. After spending quite some time researching, I solved it by utilizing a `DateView` which allowed me to pass every date of the month as a text property to be styled in the card view.

# What I've Learned
Throughout this process, I pushed my programming knowledge and learning abilities to complete the first version of the Cards app. Throughout the process, I expanded my new SwiftUI skills by creating multiple cards. With the moon phase widget, I learned more about error handling on a do-catch statement, and how to handle a failure. With the contacts widget, I learned how to better integrate the app with Apple's frameworks to make apps more convenient for users - and to harness Apple's efficient frameworks. With the quotes widget, I learned how to parse JSON data from the web - which was really exciting for me and opens the future for endless possibilities! Also, with the calendar widget, I learned how to efficiently loop and add multiple text views. Overall, it was a project that substantially boosted my computer science knowledge.

It wasn't only computer science knowledge that was boosted. This project enhanced my problem-solving skills, which is something I find very valuable. The countless obstacles I faced with this project - both big and small - increased my ability and methods of problem-solving. Compared to just 1 year ago where I would randomly update values until the issue resolves with practically no strategic plan for solving issues, to today where I quickly locate the issue, and find the root of the problem by utilizing print statements that show which aspect failed. Also, my tolerance to challenges has increased where prior to this project creating an app in a new framework was daunting, but now it is not so much. These problem solving-skills have been useful to me for aspects far beyond computer science - such as time management & priority shuffling.

This project blessed me with an invaluable amount of lessons that push my capabilities further than I thought possible!

# Where Will I Take It From Here?
When I began this course, my main goal was to create projects that could have a real-world impact. Instead of theorizing, I realized that taking a hands-on approach would be the most effective towards my long-term aspirations of completing higher education in Computer Science, and potentially starting my own software company. I plan on expanding this project during the summer break, along with integrating some of the cards into an app that I've already committed to the App Store - [Color Widgets](https://apps.apple.com/us/app/color-widgets/id1531594277). Computer Science is a subject I have profound compassion for, and I dream of harnessing this superpower to add some more positivity into this world.

# References
Here are the third-party frameworks & tutorials I've used to assist with the building of the app:
1. [SunMoonCalc](https://github.com/kanchudeep/SunMoonCalculator): Using on-device calculations gets the illumination, angle, and other important datasets of the Moon.
2. [SwiftUI Path](https://www.hackingwithswift.com/books/ios-swiftui/creating-custom-paths-with-swiftui): Tutorial that helped me understand SwiftUI Paths for the moon phase card.
3. [Random Quote Database](https://quote-garden.herokuapp.com/api/v3/quotes/random): Returns a random JSON-encoded quote from a collection of current 80,000+ quotes.

## That's All. Thanks for viewing!
