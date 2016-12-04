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

Another localization method uses cellular tower signals to determine the location of a device by measuring the distances to multiple towers within reach. This [triangulation method][5] is less precise because it depends on weather conditions and relies on a fairly high density of cell towers.

The third method doesn't require GPS or cell towers at all but the presence of a Wi-Fi network. This technique uses the known locations of nearby Wi-Fi access points to figure out the approximate location of the mobile device. Wi-Fi access points themselves lack GPS receivers and therefore lack knowledge of their own geographic locations, but such information can be associated with their physical [MAC (media access control) addresses][6] by third parties.

The most notorious case was [Google's now abandoned effort][7] to associate GPS coordinates with the MAC address of every wireless access point it encountered as it photographed the streets of US cities and towns with GPS-enabled vehicles for its Google Maps Street View project.

Nowadays, we're the ones who do this work for Google whenever we take an Android device for a stroll. If we have activated Google's location service by selecting Settings &mapsto; "Location services" on the main menu of our device, then by default we have agreed to "collect anonymous location data" and that "collection may occur even when no apps are running." The MAC addresses of available Wi-Fi networks are sent to Google during this collection process, along with their geographic coordinates. The next user who walks through the same geographic area can then geolocate solely via the Wi-Fi network information, even if GPS is turned off.

It takes a few seconds for the Android to narrow the location estimate and improve its accuracy, so we typically need to start ```KetaiLocation``` as soon as the app launches. With fewer than ten lines of code, ```KetaiLocation``` can provide us with our geographic coordinates and notify us of changes in our location via the ```onLocationEvent``` callback method.

For the location-based apps we'll develop in this chapter, we'll use the following Ketai library and Android classes:

[*```KetaiLocation class```*][8] <br />
A class that simplifies working with Android's Location Manager—it instantiates the Location Manager, registers for location updates, and returns geolocation data.

[*```Location```*][9]<br />
A wrapper for Android's Location Manager that provides us with many useful methods for determining our position, bearing, and speed—if we're only interested in our location, we won't need this class, but we will use some of its features for later projects in this chapter.

Now let's take a look at the ```KetaiLocation``` methods we'll be using in this chapter.

[5]: http://en.wikipedia.org/wiki/Triangulation
[6]: http://en.wikipedia.org/wiki/MAC_address
[7]: http://www.nytimes.com/2012/05/23/technology/google-privacy-inquiries-get-little-cooperation.html
[8]: http://ketai.org/reference/sensors/ketailocation
[9]: http://developer.android.com/reference/android/location/Location.html

<div class="sidebar">
<h3>Introducing GPS</h3>
<p>
The transmitters built into GPS satellites broadcast with about 50 watts, similar to the light bulb in a desk lamp, and yet the GPS module in the phone is able receive a sequence of numbers sent by all the satellites simultaneously, every microsecond. The atomic clock in each satellite takes care of that. The satellite doesn't know anything about us; it's only transmitting. The receiver in our mobile device makes sense of the transmission by deciphering the sequence of numbers the satellite sends. The GPS receiver then determines from the number sequence (which includes the time it was sent by the satellite) how far each individual radio signal has travelled, using the speed of light as its velocity. If a satellite is close by (about 20,000 kilometers), the signal would take about 67 microseconds to travel. The distance is measured by multiplying the time it has taken the radio signal to reach your phone by the speed of light.
</p><p>
We need to "see" at least four satellites to determine latitude, longitude, and altitude (or three if we assume an incorrect altitude of zero). It's clear that a 50-watt signal from 20,000 kilometers away cannot penetrate buildings. We can only "see" satellites if there are no obstructions. If the signal bounces off a building surface, the estimate is less accurate as a consequence. Because the satellite orbits are arranged so that there are at always six within the line of sight, it's fine if one or two are not "seen" or are inaccurate. Accuracy is higher for military  receivers getting a signal every tenth of a microsecond, bringing it theoretically down to 0.3 meters (or about 1 ft). High-end receivers used for survey and measurement can increase accuracy even more—to within about 2 mm.
</p>
</div>

###Working with the KetaiLocation Class

The ```KetaiLocation``` class is designed to provide us with the longitude, latitude, and altitude of the device, as well as the accuracy of that estimate. Besides the typical ```start()``` and ```stop()``` methods, ```KetaiLocation``` also provides a method to identify the location provider that has been used to calculate the estimate. Let's take a look.

<!-- CHECK FOR FORMATTING CONSISTANCY - pg 72 pdf -->

*```onLocationEvent()```* <br />
Returns the device location, including latitude, longitude, altitude, and location accuracy

*```latitude```*<br />
Describes the angular distance of a place north or south of the Earth's equator in decimal degrees—positive ```lat``` values describe points north of the equator; negative values describe points south of the equator (for example, Chicago is located at ```41.87338``` degrees latitude in the northern hemisphere; Wellington, New Zealand, is located at ```-41.29019``` degrees latitude in the southern hemisphere).

*```longitude```*<br />
Describes the angular distance of a place east or west of the meridian at Greenwich, England, in decimal degrees (for example, Chicago, which is west of the Greenwich meridian, is located at -87.648798 degrees longitude; Yanqi in the Xinjiang Province, China, is located at ```87.648798``` degrees longitude.)

*```altitude```*<br />
Returns the height of the device in relation to sea level measured in meters

*```accuracy```*<br />
Returns the accuracy of the location estimate in meters

*```getProvider()```*<br />
Returns the identity of the location provider being used to estimate the location: ```gps``` or ```network```—it does not distinguish between cellular or Wi-Fi networks.

Before we can use data from the location provider, we need to take a look at the permissions the sketch needs to access this data.

###Setting Sketch Permissions

By default, [Android denies permissions][10] to any app that requests access to private data or wants to perform privileged tasks, such as writing files, connecting to the Internet, or placing a phone call. Working with privileged information such as geolocation is [no exception.][11]

If we'd like to use the device's location data, we need to ask for permission. Android prompts the user to grant permission if an app requests permission that has not been given to the app before. The Processing IDE (PDE) helps us administer permission requests through the Android Permission Selector, which is available from the menu by selecting Android &mapsto; Sketch Permissions. There we'll find a list of all the permissions that can be requested by an app on the Android.

As illustrated in <!-- ref linkend="fig.sketch.permissions-->, the location permissions need to be set for this app. When we run the sketch on the device and Processing compiles the Android package, it generates a so-called ```AndroidManifest.xml``` file that corresponds to our permission settings. We don't need to worry much about the details of [```AndroidManifest.xml```;][12] owever, as follows, we can see how Processing's Permissions Selector translates our selection into a user-permissions list.

<!--code id="code.android.manifest" file="code/Geolocation/Geolocation/AndroidManifest.xml" language="java"/-->

<!-- IMAGE -->
#####Figure 4.1 — Sketch permissions.
######The Android Permissions Selector lists all permissions that can be requested by the Android app. The location permissions required by the first geolocation app are checked.

To make sure our location app is able to work with location data, we need to enable Google's location service on the device under Settings &mapsto; "Location" and agree to the prompt, shown here:

```
Let Google's location service help apps determine location.
This means sending anonymous location data to Google,
even when no apps are running.
```

Otherwise our app will will display the following warning:

```
Location data is unavailable. Please check your location settings.
```

We've programmed this warning into our sketch, assuming that ```getProvider()``` returns ```none```, which is also the case if Google's location service is switched off.

Let's go ahead and write our first location-based app.

[10]: http://developer.android.com/guide/topics/security/security.html#permissions
[11]: http://www.nytimes.com/2012/04/01/us/police-tracking-of-cellphones-raises-privacy-fears.html
[12]: http://developer.android.com/guide/topics/manifest/manifest-intro.html

###Determine Your Location

As our first step, let's write some code to retrieve and display your device's location, as shown in <!-- ref linkend="fig.geolocation-->.

<!--IMAGE images/Geolocation/Geolocation.png-->
#####Figure 4.2 — Displaying location data.
######The screen output shows geolocation (latitude, longitude, and altitude), estimation accuracy (in meters), and the current location provider.

This exercise will familiarize us with the kinds of values we'll use to determine our current location on the Earth's surface. Let's display the current latitude, longitude, and altitude on the screen as determined by the Location Manager, as well as display the accuracy of the values and the provider that is used for the calculation. The following example uses ```KetaiLocation``` to gather this info.

<!-- code/Geolocation/Geolocation/Geolocation.pde -->

Let's take a look at how the newly introduced class and methods are used in this example.

