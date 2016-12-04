###Chapter 4:
#Using Geolocation and Compass


Location-based services have changed the way  we navigate, share, and shop. Since the FCC ruling in 1996 requiring all US mobile operators to be able to locate emergency callers, location has become embedded in the images we take, the articles we blog, the commercials we watch, and the places we check into. These services rely on location information using latitude and longitude—and sometimes altitude—to describe a north-south and east-west position on the Earth's surface.

When we search for local information, get directions to public transportation, or find the nearest bar or bargain, the Android enables us to zero in on the information that is relevant to us at a particular geographic location. Because the device is aware of its own geolocation, we can navigate, detect where we are heading, and know how we are holding the device in relation to magnetic north. A built-in Global Positioning System (GPS) receiver, accelerometer, and digital compass allow the Android to have a full picture about its location and orientation, which plays an important role for navigation apps and [location-based services.][1] 

Android apps make use of the [Android's Location Manager][2] to calculate a location estimate for the device. Its purpose is to negotiate the best location source for us and to keep the location up-to-date while we are on the move. Updates typically occur when the device detects that we've changed location or when a more accurate location becomes available. An Android device uses two different [location providers][3] to estimate its current geographic coordinates: ```gps``` on the one hand and ```network``` on the other, the latter based either on the calculated distance to multiple cell towers or on the known location of the Wi-Fi network provider to which we are connected. [A special ```passive``` provider][4] receives location updates from other apps or services that request a location.

Compared with the Global System for Mobile Communications (GSM) and Wi-Fi network localization, GPS is the most well-known and accurate method for determining the location of a device. With thirty-one GPS satellites orbiting about 20,000 kilometers above any spot on the Earth's surface twice a day (every 11 hours, 58 minutes), it's just fantastic how the fingertip-sized GPS receivers built into our smart phones are able to determine the device's latitude, longitude, and altitude at a theoretical accuracy of about three meters.

In this chapter, we'll build a series of navigation apps. We'll start by working with the Android's current geolocation. We'll continue by measuring how far we are located from a predefined destination. Finally, we'll build an app that helps us navigate toward another mobile device.

Let's first take a look at how the Android device estimates its location.

[1]:http://en.wikipedia.org/wiki/Location-based_service
[2]: http://developer.android.com/reference/android/location/LocationManager.html
[3]: http://en.wikipedia.org/wiki/GSM_localization
[4]: http://developer.android.com/guide/topics/location/obtaining-user-location.html

###Introducing the Location Manager

Given its ubiquitous use, working with geolocation data should be simple. In the end, it's just the latitude, longitude, and maybe altitude we are looking to incorporate into our apps. Because there are various location techniques, however, we are interacting with a fairly complicated system and continuously negotiating the best and most accurate method to localize the device. The Location Manager that does that work for us is a software class that obtains periodic updates of the device's geographic location from three sensors available on an Android phone or tablet, including a built-in GPS receiver, a cellular radio, and a Wi-Fi radio. Both the ```KetaiLocation``` and Android ```Location``` classes draw their data from the Location Manager, which in turn gets its information from the onboard devices.