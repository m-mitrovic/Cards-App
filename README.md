# Cards App
 Automate your day with the Cards app. Programmed in Swift using the new SwiftUI framework.

![Image of Cards App](https://i.imgur.com/2JhrIIY.png)
#### By Mihajlo Mitrovic for ICS-4U1 (Mr. Tedesco)

# Project Overview
Cards allows users to create custom “cards” to quickly get informed and perform repatative actions efficiently. The user can configure the app to show the current phase of the moon, current calendar and days left in the month, launch their favourite contacts & apps, along with other actions. I feel this is the most optimal way to demonstrate the programming and software design concepts I’ve learned in this class because each card will be utilizing different programming principles.

## [Video App Preview](https://youtu.be/_skOmWEtxfU)

# Where to Start
I recommend starting by watching the preview video attached. This will give you a visualization of what the code does. From then on, I suggest starting with the "ContentView.swift" file as it is the main app home screen. In the "Cards" folder, you can see the code behind each corresponding card.

# My Progress
Here was my progress (in chronological order) along with a summary of the challenges I faced and the timeline of my accomplishements.

## Week 1: (May 31 - June 4)
![Images of Prototypes](https://i.imgur.com/muS5O7Q.png)
The first week centered on planning the app, wireframing a prototype, and building the skeleton of the app. I branded the app and designed most of the main screens that way I can focus on strictly coding in the weeks to come.

### Challenges I've Overcame
- The main challenge I faced this week was how I would permanently save the cards a user makes for the next time they run the app. I overcame this by making a `Card` class which only utilized `Strings` & Numbers to save data. This meant saving the Color as a HEX string and converting it to SwiftUI. Since the `Card` class only uses basic Swift values, I can use Apple's UserDefaults framework to save it to a file and access it every time a user uses the app.

## Week 2: (June 7 - June 11)
<img src="https://i.imgur.com/xAZdF0d.jpg" width="300">
In week 2, I focused on building the different cards. I began with the Moon Phases cards utilizing the framework SunMoonCalc<sup>1</sup>. I then went on to complete the contacts card, along with working on the calling/messaging actions of that card. I finally ended the week by creating an intro pop-up to direct new users.

### Challenges I've Overcame
This week was littered with with smaller challenges, but the main ones were:
- During the development process of the moon phase card, I couldn't figure out how to dim the image of the moon with regards to the illumination percentage. The issue is that the moon has an ever changing shadow which is once a circle, and then an crescent. I had to get creative, so instead of overlaying an additional circle to act as the moon's shadow, I utilized SwiftUI Paths for the first time. SwiftUI Paths let me draw a custom path of my own (a circle or an crescent). I got to work, and by using the illumination percentage, I finally built a shadow that would accurately display the moon's illumination.
- Another issue that plauged me for a while was with the contact card. Since users input a phone number in many different styles, I needed my app to conform to a single style for all phone numbers included. What I found through trial and error was that if I stripped all the spaces, dashes, and parenthasis from the phone number, they could all follow the same format and work!

## Week 3: (June 14 - June 16)
<img src="https://i.imgur.com/y3v1Tzj.jpg" width="300">
In the final week, I've created a changing quotes card (parsed from an online JSON format), a digital calendar, and have finalize the app. I completed the introduction process for first time users, and fixed any withstanding bugs in the app.

### Challenges I've Overcame
- Accessing the quotes from an online database was filled with issues that I had to overcome. At first, parsing the data wasn't working because the `Quote` class was did not match with the JSON class that was provided. After adjusting the variable key names and adding an additional `CodingKeys` enum to the class, the quotes were finally parsed correctly. However, the issues didn't stop there. I then had to cache the quote on each app load becuase it would be too inefficient and unresponsive to request new ones everytime a user updates the view/cards. The solution to this issue was much more straightforward - I included a global variable called `cachedQuote` which = nil if no quotes are loaded, or returns the cached quote if it has already loaded.
- The next issue I faced was with the calendar card. I needed a way for the card text to be edited from the card hosting view and not the `CalendarGridView`. I first tried passing the `Card` property to the `CalendarGridView`, and although I was able to edit it - I still wanted to be able to style it from the card view. After spending quite some time reasearching, I solved it by utilizing a `DateView` which allowed me to pass every date of the month as a text property to be styled in the card view.

# References
Here are the third party frameworks & tutorials I've used to assist with the building of the app:
- [SunMoonCalc](https://github.com/kanchudeep/SunMoonCalculator): Using on-device calculations gets the illumination, angle, and other important datasets of the Moon.
- [SwiftUI Path](https://www.hackingwithswift.com/books/ios-swiftui/creating-custom-paths-with-swiftui): Tutorial that helped me understand SwiftUI Paths for the moon phase card.
