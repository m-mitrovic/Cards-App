# Cards App
 Automate your day with the Cards app. Programmed in Swift using the new SwiftUI framework.
 
 #### By Mihajlo Mitrovic for ICS4U1 (Mr. Tedesco)
 
# Project Overview
Cards allows users to create custom “cards” to quickly get informed and perform repatative actions efficiently. The user can configure the app to show the current phase of the moon, current calendar and days left in the month, launch their favourite contacts & apps, along with other actions. I feel this is the most optimal way to demonstrate the programming and software design concepts I’ve learned in this class (each card will be utilizing different programming principles).

# Updates
Here I will update my progress (in chronological order) throughout the week with a summary of my challenges and what I've accomplished.

## Week 1: (May 31 - June 4)
![Images of Prototypes](https://i.imgur.com/muS5O7Q.png)
The first week centered on planning the app, wireframing a prototype, and building the skeleton of the app. I branded the app and designed most of the main screens that way I can focus on strictly coding in the weeks to come.

### Challenges I've Overcame
- The main challenge I faced this week was how I would permanently save the cards a user makes for the next time they run the app. I overcame this by making a `Card` class which only utilized `Strings` & Numbers to save data. This meant saving the Color as a HEX string and converting it to SwiftUI. Since the `Card` class only uses basic Swift values, I can use Apple's UserDefaults framework to save it to a file and access it every time a user uses the app.

## Week 2: (June 7 - June 11) - Ongoing
In week 2, I focused on building the different cards. I began with the Moon Phases cards utilizing the framework SunMoonCalc^1

## Week 3: (June 14 - June 16) - Upcoming

# References
Here are the third party frameworks I've used to assist with the building of the app:
- [SunMoonCalc](https://github.com/kanchudeep/SunMoonCalculator): Using on-device calculations gets the illumination, angle, and other important datasets of the Moon.
