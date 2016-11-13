### Chapter 3 

#Using Motion and Position Sensors

This chapter is about how to interact with sensors on an Android device using the Ketai library. Android devices come packed with sensors that allow us to write mobile apps that react to how we position and move the Android device to make them more engaging, useful, and interactive. Android sensors provide us with information about device motion, position, and environment. We'll focus on motion sensors in this chapter and take a look at some position sensors.

Motion sensors allow us to measure how the device is oriented in space and how it accelerates when we move it. The typical accelerometer sensor found on Android devices triggers screen rotations and is used for a wide range of apps to detect shakes, fist bumps, hand gestures, bumpy roads, and other features. Using Ketai, we'll list all the available sensors built into the Android and work with multiple sensors combined in an app that displays values for the magnetic field, light, proximity, and accelerometer sensors.

We'll work with the orientation of an Android device to create an interactive color mixer app. Step by step, we'll start by learning to display raw data from the accelerometer sensor, and then we'll use those values to generate the entire spectrum of color that the Android can generate. Next we'll learn how to store data in an array and how to use the array to display a palette of eight colors that we've created. Finally, we'll use the accelerometer to clear the color palette by shaking the device, and we'll detect that motion in our program. In the process, we'll acquire a sense for the accelerometer sensor, its value range, and its accuracy, and we'll learn to integrate it into the app's user interface. By the end of the chapter, you will know this sensor well enough to transpose this knowledge to other applications.

###Introducing the Device Hardware and Software Layers

Writing sensor-based Android apps in Processing involves a series of software layers that build on each other. The list below describes the software stack running on the device hardware, all of which we put to use when we run our sketches—starting with the bottommost hardware layer.

**Hardware**
Besides the central (CPU) and graphics (GPU) processing unit, hardware devices built in the Android include: GSM/3G/4G antennas, digital cameras, an accelerometer sensor, a light sensor, a gyroscope, a geomagnetic field sensor, a capacitive touch screen panel, an audio interface, a speaker, a vibration motor, a battery, a Flash memory interface, and perhaps a hardware keyboard and a temperature sensor.

**Linux kernel**
The bottommost software layer running on the hardware is the [Linux kernel,][1] a Unix-like operating system initially developed by Linus Torvalds in 1991. We access all the hardware resources of the device through this layer, which contains drivers for the display, cameras, Bluetooth, Flash memory, Binder (PC), USB, keypad, Wi-Fi, audio, and power.

**Android and Java Core Libraries**
Above the Linux kernel sit the Android native libraries written in C/C++, including  Surface Manager, Media Framework,  SQLite ,  OpenGL/ES , FreeType, WebKit,  SGL,  SSL, and  libc. This layer also includes Android Runtime, which contains the core Java libraries and the [Dalvik virtual machine.][2] The Dalvik virtual machine creates compact executable files that are optimized for memory and processor speed. The virtual machine allows a high level of control over the actions an app is permitted to take within the operating system. Android applications are typically written in Java using the Java core libraries and compiled to bytecode, which is the format executed by a Java virtual machine. In the Android OS, bytecode is converted into a Dalvik executable (***dex***) before an app is installed on the Android device.

**Processing**
The language itself is the next layer in our software stack that builds on the Java core libraries. The Android mode in Processing works with the Android libraries in the Android layer. Processing's software architecture allows us to use Java and Android classes directly within the Processing code.

**Ketai**
The library builds on the Processing for Android layer, taking advantage of the Processing, Java, and Android libraries. It's the highest layer in the software stack we'll be working with in projects, besides using a few other libraries that sit on the same level in the hierarchy. Ketai focuses specifically on the hardware features built into Android devices, including the multitouch screen panel, sensors, cameras, and networking devices.

Now that we are aware of the different hardware components and the software layers stacked on top of the hardware layer, let's start with the bottommost hardware layer and take a look at the most common sensors built into our Android device.

[1]: http://en.wikipedia.org/wiki/Linux_kernel
[2]: https://en.wikipedia.org/wiki/Dalvik_(software)

###Introducing Common Android Sensors

In this chapter, we will work mostly with the accelerometer sensor and use the ***KetaiSensor*** class to access it. ***KetaiSensor*** is capable of working with all sensors. Some sensors found on the Android device are based on hardware; others are software-based and provided by the Android SDK. For the projects in this chapter, we'll focus on actual electronic hardware sensors built into the Android phone or tablet. Android distinguishes three different sensor-type categories: [motion sensors,][3] [position sensors,][4] [and environment sensors.][5] Most environment sensors have been added to the Android SDK recently (Android 4.0 Ice Cream Sandwich), so they are not typically found in devices yet. Let's take a look at the different sensors Android supports. 

[3]: http://developer.android.com/guide/topics/sensors/sensors_motion.html
[4]: http://developer.android.com/guide/topics/sensors/sensors_position.html
[5]: http://developer.android.com/guide/topics/sensors/sensors_environment.html

####Motion Sensors

The following sensors let you monitor the motion of the device:

* **Accelerometer (hardware)** Determines the orientation of the device as well as its acceleration in three-dimensional space, which we'll use to detect shakes
* **Gravity (software-based)** Calculates the orientation of the device, returning a three-dimensional vector indicating the direction and magnitude of gravity
* **Gyroscope (hardware)** Measures the movement of the device, returning the rate of rotation around each device axis—if available, this sensor is often used for games that rely on immediate and precise responses to device movement.
* **Linear Acceleration (software-based)** Calculates the movement of the device, returning a three-dimensional vector that indicates the acceleration of each device axis, excluding gravity
* **Rotation Vector (software-based)** Calculates the orientation of the device, returning an angle and an axis—it can simplify calculations for 3D apps, providing a rotation angle combined with a rotation axis around which the device rotated.

Now let's take a look at the sensors that deal with the device's position.

####Position Sensors

The following sensors let you to determine the location or position of the device:

* **Magnetic Field** A three-axis digital compass that senses the bearing of the device relative to magnetic north

* **Proximity** Senses the distance to an object measured from the sensor that is mounted in close proximity to the device speaker&emdash;this is commonly used to determine if the device is held toward, or removed from, the ear.

Now let's take a look at the sensors that measure the device's environment.

####Environment Sensors

The following sensors let you monitor environmental properties or measure the device context:

* **Light** Senses the ambient light level
* **Pressure** Senses the air pressure (the atmospheric pressure)
* **Relative Humidity** Senses the humidity of the air (in percent)
* **Temperature** Senses the ambient air temperature

Since this list will grow and remain a moving target as new generations of devices and APIs are released, the [Android Sensor website][6] is the best source for keeping an eye on changes and additions.

Let's start by looking at the ```KetaiSensor``` class, which we'll use when we work with sensors throughout the book.

[6]: http://developer.android.com/reference/android/hardware/Sensor.html

####Working with the KetaiSensor Class

For the sketches we'll write in this chapter, the following ```KetaiSensor``` methods are the most relevant:

* *```list()```* Returns a list of available sensors on the device

* *```onAccelerometerEvent()```* Returns *x*-, *y*-, and *z*-axis acceleration minus g-force in meters per second squared (m/s<sup>2</sup>)

* *```onMagneticFieldEvent()```* Returns the *x*, *y*, and *z* values for the ambient magnetic field in units of microtesla

* *```onLightEvent()```* Returns the light level in SI units of lux

* *```onProximityEvent()```* Returns the distance to an object measured from the device surface in centimeters&emdash;depending on the device, a typical output is ```0/1``` or ```0/5```—the sensor is typically located next to the speaker on the device. 

* *```onGyroscopeEvent()```* Returns the *x*, *y*, and *z* rates of rotation around the *x*-, *y*-, and *z*-axes in degrees

Because a multitude of devices on the market exist, it's important that we start by checking the sensors that are built into our Android device. Let's use the ```KetaiSensor``` class to see what sensors are built into our Android device. 

###List the Built-In Sensors on an Android Device

Let's find out what sensors are built into our device and available for us to work with. The ```KetaiSensor``` class offers a ```list()``` method that enumerates all Android sensors available in the device and lists them for us in the Processing console.

Open a new sketch window in Android mode and type or copy the following four lines of code; click on the green bar to download the ```SensorList.pde``` source file if you are reading the ebook.

<!-- code id="code.sensor.list" file="code/Sensors/SensorList/SensorList.pde"/ -->

Take a look at the code. First we import the Ketai sensor package, then we create a  ```sensor``` variable of the type ```KetaiSensor```, and finally we create a ```sensor``` object containing all the ```KetaiSensor``` methods we need. As the last step, we print the sensor ```list()``` to the console.

####Run the App

Run this code on your Android device and take a look at the Processing console. For example, the Google Nexus S reports the following list of sensors:

```
KetaiSensor sensor: KR3DM 3-axis Accelerometer:1
KetaiSensor sensor: AK8973 3-axis Magnetic field sensor:2
KetaiSensor sensor: GP2A Light sensor:5
KetaiSensor sensor: GP2A Proximity sensor:8
KetaiSensor sensor: K3G Gyroscope sensor:4
KetaiSensor sensor: Rotation Vector Sensor:11
KetaiSensor sensor: Gravity Sensor:9
KetaiSensor sensor: Linear Acceleration Sensor:10
KetaiSensor sensor: Orientation Sensor:3
KetaiSensor sensor: Corrected Gyroscope Sensor:4
```

The Asus Transformer Prime tablet reports the following sensors: 

```
KetaiSensor sensor: MPL rotation vector:11
KetaiSensor sensor: MPL linear accel:10
KetaiSensor sensor: MPL gravity:9
KetaiSensor sensor: MPL Gyro:4
KetaiSensor sensor: MPL accel:1
KetaiSensor sensor: MPL magnetic field:2
KetaiSensor sensor: MPL Orientation:3
KetaiSensor sensor: Lite-On al3010 Ambient Light Sensor:5
KetaiSensor sensor: Intersilisl29018 Proximity sensor:8
```

The Google Nexus 6 reports a lists 32 software and hardware sensors. The list includes some hardware info, its type, and an ID. Your results, no doubt, will differ; there are a lot of Android makes and models out there today. 

The list includes more than hardware sensors. The Android SDK also includes software-based sensors, known as fused sensors. Fused sensors use multiple hardware sensors and an Android software layer to improve the readings from one individual sensor. They make it easier for us as developers to work with the resulting data. The ```Gravity```, ```Linear Acceleration```, and ```Rotation Vector``` sensors are examples of such hybrid sensors, combining gyroscope, accelerometer, and compass data to improve the results. In the list of available sensors, however, no distinction is made between hardware sensors and fused sensors.

This also means that even if you don't update your device hardware, new versions of the Android API might include fused software-based sensor types that might be easier to use or might produce better results. For example, if you browse Android's sensor hardware overview and switch the "Filter by API Level" to ```8``` (http://developer.android.com/reference/android/hardware/Sensor.html), you will see a list of the sensor types and methods that have been added to the API since the release of API ```8```.
          
As you start adding methods from the Ketai library to the sketch, note that contributed libraries are not highlighted by the Processing IDE because they are not part of the core. This is not a big deal, but it's something you should be aware of.

Here's the code we'll typically use to interact with a device using the classes and methods that the Ketai library provides:

```
import ketai.sensors.*;	// 1 id="co.import"/>
KetaiSensor sensor;	// 2

void setup()
{
sensor = new KetaiSensor(this);	// 3
sensor.start();	// 4
}

void draw()
{
}
void onAccelerometerEvent(float x, float y, float z) // 5
{
}
```

Let's take a look at the code that is specific to ```KetaiSensor```. 

1. Import the Ketai sensor library package from ```Sketchbook/libraries```.
2. Declare a ```sensor``` variable of type ```KetaiSensor```, and register it for any available Android sensors.
3. Instantiate the ```KetaiSensor``` class to create a ```sensor``` object, which makes ```KetaiSensor``` methods available.
4. Start listening for accelerometer sensor events.
5. Each time the accelerometer changes value, receive a callback for the *x*, *y*, and *z* sensor axes.

Sensor values change at a different rate than the ```draw()``` method does. By default,  ```draw()``` runs ```60``` times per second. The sensor can report much faster than that rate, which is why we work with an ```onAccelerometerEvent()``` callback method. It is called every time we receive a new value from the accelerometer.

Different devices use different accelerometers. Some contain hardware filters that stop reporting values altogether when the device is absolutely still. Others might be more accurate—or noisy—and keep reporting even when the device is seemingly still. Accelerometers are sensitive to the smallest motion. Let's take a look at the raw values such a device will display.

###Display Values from the Accelerometer

Using the Ketai library, let's see what the accelerometer has to report. The accelerometer is the most common sensor found in mobile devices and is designed to detect device acceleration and its orientation toward g-force. It returns the *x*-, *y*-, and *z*-axes of the device, measured in meters per second squared. These axes are *not* swapped when the app's screen orientation changes.

The accelerometer sensor's shortcomings are related to the fact that it cannot distinguish between rotation and movement. For instance, moving the device back and forth on a flat table and rotating it about its axes can produce identical accelerometer values. To differentiate between movement and rotation, we require an additional sensor, the gyroscope, which we'll also use in <!--ref linkend="chp.mobile.3d" /-->. When we want to find out how the device is oriented with respect to gravity, however, the accelerometer is the only sensor that can help us.

Let's add some code to output raw accelerometer values onto the screen. We're aiming for the result shown in <!--ref linkend="fig.output.accelerometer" /-->. We use the ```text()``` method and some formatting to display accelerometer values. As we move the device, it will also come in handy to lock the screen orientation so we can keep an eye on the quickly changing values. Because we only need to set the screen ```orientation(PORTRAIT)``` once at startup, the method goes into ```setup()```.

###Accelerometer output

The picture shows the acceleration of the *x*-, *y*-, and *z*-axes of the device in relation to g-force.

<!-- imagedata fileref="images/Sensors/AccelerometerOutput.png" width="40%" -->

Now let's dive into the code.

<!-- code id="code.accelerometer" file="code/Sensors/Accelerometer/Accelerometer.pde"
language="java" start="import" end="end"-->

Let's take a closer look at the Processing methods we've used for the first time.

1. Align the text to the ```CENTER``` of the screen using [```textAlign()```.][7]
2. Set the text size to ```72``` using [```textSize()```.][8] The default text size is tiny and hard to decipher in motion.
3. Display the data using [```text()```.][9] We output a series of strings tied together via the plus sign (```+```), known as the concatenation operator. This way we can use only one text method to display all the labels and reformatted values we need.

Acceleration values are measured in m/s<sup>2</sup>. If the device is sitting *flat* and *still* on the table, the accelerometer reads a magnitude of ```+9.81``` m/s<sup>2</sup>. This number represents the acceleration needed to hold the device up against  g-force and the result of the following calculation: acceleration of the device (```0``` m/s<sup>2</sup>) minus the acceleration due to gravity [(```-9.81``` m/s<sup>2</sup>).][10] If we move and rotate the device, we can observe values in the range of roughly ```-10``` to ```10``` m/s<sup>2</sup>. Shake the device and the values will surge momentarily to maybe ```+-20``` m/s<sup>2</sup>. Values beyond that become tricky to observe; feel free to try.

We format the numbers via ```nfp()```, a method that helps us to maintain two digits to the left and three digits to the right of the decimal point. This way, values we observe don't jump around as much. The "p" in ```nfp()``` puts a "+" in front of positive accelerometer values and a "-" in front of negative values, helping us to understand the device orientation better with regard to the accelerometer's nomenclature.

[7]: http://processing.org/reference/textAlign_.html
[8]: http://processing.org/reference/textSize_.html
[9]: http://processing.org/reference/text_.html
[10]: http://en.wikipedia.org/wiki/G-force

###Run the App

In case you didn't already run the sketch in anticipation, now is the time. Remember that the shortcut for Run on Device is ⌘R.

Try placing your device in different positions and observe the acceleration due to gravity reported for each axis. If you lay your Android device flat on a table, for example, the *z*-axis will report an acceleration of approximately ```+9.81``` m/s<sup>2</sup>. When you hold it vertically in a reading position, notice how the acceleration due to gravity shifts to the *y*-axis. The screen output is similar to <!--ref linkend="fig.output.accelerometer" -->. Tiny movements of the device trigger very observable changes in value, which are reported back to us via ```onAccelerometerEvent()```.

Let's now see how a sketch would look using multiple sensors.

###Display Values from Multiple Sensors

So far we've worked with the accelerometer, which is a hardware motion sensor built into the Android device. In future chapters we'll want to work with multiple sensors, so let's fire up a few simultaneously and display their values on the Android screen. For this sketch, we'll activate the accelerometer again and add two position sensors and an environment sensor. The magnetic field sensor and the proximity sensors are considered position sensors; the light sensor is an environment sensor.

We could store the three axes returned by the accelerometer and magnetometer sensors in individual floating point variables. A better solution, however, is to work with Processing's [```PVector``` class.][11]

It can store either a two- or a three-dimensional vector, which is perfect for us, since we can put any two or three values into this package, including sensor values. Instead of three variables for the *x*-, *y*-, and *z*-axes returned by the accelerometer and magnetometer, we can just use one ```PVector```, called ```accelerometer```. We refer later to an individual value or axis using the ```accelerometer.x```, ```accelerometer.y```, and ```accelerometer.z``` components of this ```PVector```. The class is equipped with a number of useful methods to simplify the vector math for us, which we'll use later in this chapter to detect a device shake.

For this sketch, let's lock the screen ```orientation()``` into ```LANDSCAPE``` mode so we can display enough digits behind the comma for the floating point values returned by the sensors.

[11]: http://processing.org/reference/PVector.html

To create a sketch using multiple sensors, we follow these steps:

<!-- code id="code.multiple.sensors" file="code/Sensors/MultipleSensors/MultipleSensors.pde"
language="java" start="import" end="end"/ -->

Let's take a closer look at the different event methods.

1. Rotate the screen [```orientation()```.][12]
2. Measure the strength of the ambient magnetic field in microteslas along the *x*-, *y*-, and *z*-axes.
3. Capture the light intensity, measured in lux ambient illumination.
4. Measure the distance between the device display and an object (ear, hand, and so on). Some proximity sensors support only near (```1```) or far (```0```) measurements.
5. Tap on the touch screen to invoke the ```start()``` and ```stop()``` methods for the sensors on the device. This will start and stop all sensors here, as all of them are registered with the same ```sensor``` object.

Let's take a look to see if all the sensors return values.

[12]: http://android.processing.org/reference/environment/orientation.html

###Run the App

Run the sketch on the device, and you should see output similar to this:

<!-- figure id="fig.output.multiple.sensors" -->

###Using multiple Android sensors

The image shows the accelerometer, magnetic field, light, and proximity sensor output.

<!-- imagedata fileref="images/Sensors/MultipleSensors.png" width="90%" -->

Move and rotate the device to see how sensor values change. The proximity sensor is located on the Android next to the speaker and is typically used to detect whether the device is held against or away from the ear. It returns values in centimeters, and you can use your hand to play with the returned proximity values. Depending on your Android make and model, you get a ```0``` if you are close to the device and either a ```1``` or a ```5``` if you are more than 1 or 5 centimeters away. Current proximity sensors are not accurate enough to use as a measuring tool just yet.

Tapping the screen calls the ```stop()``` method and stops all the sensors. If the app doesn't require sensor updates all the time, stopping sensors is a good way to save some battery power.

Your sensor list <!-- ref linkend="code.sensor.list" --> might have already shown that your Android has a gyroscope built in. If not, Ketai will report, "Disabling ```onGyroscopeSensorEvent()``` because of an error" in the console.

To work with the gyro as well, add the following code snippet to the sketch <!--ref linkend="code.multiple.sensors" -->, add a global ```rotation``` variable of type ```PVector```, and rerun the app on the device:

```
void onGyroscopeEvent(float x, float y, float z) {
rotation.x = x;
rotation.y = y;
rotation.z = z;
}
```

If you have a gyro, you are all set for <!--ref linkend="chp.mobile.3d" -->, where we use it to navigate a 3D environment. No worries though if your device doesn't support it. There are plenty of motion-based apps we'll develop based on the accelerometer, and there are numerous other projects to discover in this book that don't require the gyro.

Let's now move on to the main chapter project and use what we've learned so far to build an app that combines what we know about the accelerometer with the support the Processing language provides for working with colors.

###Simulating Sensors in the Emulator

Please keep in mind that features that rely on built-in sensor hardware cannot be emulated on the desktop computer. Because the emulator doesn't have a built-in accelerometer, for example, it can only give you a default value. The emulator does a good job of showing us whether the Processing sketch is compiling happily, but we can't get to an actual user experience. If you'd like to explore further how the emulator can be fed with "simulated" sensor values, you need to download [additional software.][13]

[13]: http://code.google.com/p/openintents/downloads/list.


###Build a Motion-Based Color Mixer and Palette

<!-- Not seeing section from PDF in the .pml
Simulating Sensors in the Emulator - p3.0.pdf page 53 -->

We're going to build a color mixer that generates hues by mapping the orientation of an Android device relative to its *x*-, *y*-, and *z*-axes to the *R*, *G*, and *B* values of a ```color``` variable. We've already discussed the Processing ```color``` type in <!--ref linkend="sec.color.type" -->. When the sketch is complete, as shown in <!--ref linkend="fig.color.mixer" -->, you'll be able to create every hue available to your device by rotating it in three-dimensional space.

In <!--ref linkend="sec.shake" -->, we'll add a feature that lets you erase the stored colors by shaking the device. The color mixer will help us to get a better sense of the Processing ```color``` type and the value ranges of the accelerometer motion sensor, and it will provide us with a good foundation for working within the device coordinate system.

###Mix a Color

Now let's move ahead and connect the accelerometer to change color hues. Since we successfully registered the accelerometer earlier, we can now take the <!--ref linkend="code.accelerometer" -->, to the next level for our color mixer project. The global variables ```accelerometerX```, ```accelerometerY```, and ```accelerometerZ``` keep track of raw values already, and it's a small step now to tie color values to device orientation. Earlier we observed magnitude values roughly in the range of ```-10``` and ```10``` for each axis. We can now map these raw values to the RGB color spectrum in the default target range of ```0..255```. For that, we use the handy ```map()``` method, which takes one number range (in this case, incoming values of ```-10..10```), and maps it onto another (our target of ```0..255```):

Here's a description of ```map()``` parameters. Once we've learned how to use it, we'll find ourselves using it all the time:

```
map(value, low1, high1, low2, high2)
```

* *```value```* Incoming value to be converted
* *```low1```* Lower bound of the value's current range
* *```high1```* Upper bound of the value's current range
* *```low2```* Lower bound of the value's target range
* *```high2```* Upper bound of the value's target range

Now let's use ```map()``` to assign accelerometer values to the three values of an RGB color, and let's use ```background()``` to display the result, as shown in <!--ref linkend="fig.accelerometer.color"-->.

###Mapping accelerometer values to RGB color

Accelerometer values for each axis in the range of ```-10..10``` are mapped to about 50 percent red, 50 percent green, and 100 percent blue values, resulting in a purple background.

<!-- imagedata fileref="images/Sensors/AccelerometerColor.png" width="40%" -->

We need to add the accelerometer bounds for each axis and ```map()``` the values to three variables, called ```r```, ```g```, and ```b```. Add the code snippet below to the <!--ref linkend="code.accelerometer"-->, at the beginning of ```draw()``` and adjust the ```background()``` method:

```
float r = map(accelerometerX, -10, 10, 0, 255);
float g = map(accelerometerY, -10, 10, 0, 255);
float b = map(accelerometerZ, -10, 10, 0, 255);
background(r, g, b);
```
The three color variables (```r```, ```g```, and ```b```) now translate sensor values in the range of ```-10..10``` to color values of ```0..255```. The sketch then looks something like <!--ref linkend="fig.accelerometer.color" -->.

<!-- code id="code.accelrometer.color" file="code/Sensors/AccelerometerColor/AccelerometerColor.pde" language="java" start="import" end="end"-->

With this small addition, let's run the sketch on the device.

###Run the App

When you run the sketch on the device, notice how the ```background()``` changes when you tilt or shake it. You are starting to use sketches and ideas from previous sections and reuse them in new contexts. The translation from raw sensor values into a color mixer project is not a big step. To understand how the accelerometer responds to your movement, it is a bit more intuitive to observe color changes displayed on the Android screen rather than fast-changing floating point values.

Now look more closely at the display as you rotate the device. Notice how the red value is linked to rotation around the *x*-axis, green to the *y*-axis, and blue to the *z*-axis. This helps us figure out how the Android coordinate system is aligned with the actual device. The coordinate system does *not* reconfigure when the screen orientation switches from ```PORTRAIT``` to ```LANDSCAPE```. This is why we locked the app into ```orientation(PORTRAIT)```. We don't have to maintain the one-to-one relationship between the device coordinate system and the Processing coordinate system, but we'd sure have a harder time learning about it.

Let's now figure out how to save the colors we generate.

###Save a Color

To save any color that we create by rotating our device about its three axes, we need a container that is good for storing color values. Processing provides us with the ```color``` type, which we looked at briefly in the previous chapter, <!--ref linkend="sec.color.type" -->.

To implement the color picker, let's rework our <!--ref linkend="code.accelerometer" -->, and add a variable named ```swatch``` to store whatever color we pick when we tap the screen. We can then display the color pick value in an area at the bottom half of the screen, as shown here:

<!-- figure id="fig.accelerometer.color.picker" -->

###Saving a color swatch

The image shows a color picked from all the possible hues Android can generate, stored in a color swatch.

<!-- imagedata fileref="images/Sensors/AccelerometerColorPicker.png" width="40%" -->

Let's also display the individual values that correspond to the red, green, and blue variables as text using the ```red()```, ```green()```, and ```blue()``` methods to extract color values from the ```swatch``` color variable.

<!-- code id="code.accelrometer.color.picker" file="code/Sensors/AccelerometerColorPicker/AccelerometerColorPicker.pde" language="java" start="import" end="end" -->

Let's take a second look at the methods we've added.

1. Declare the variable ```swatch``` to be of type ```color```.
2. Apply the swatch color to the ```fill()``` before drawing the color picker rectangle.
3. Draw the color picker rectangle.
4. Extract the red, green, and blue values individually from the ```swatch``` color.
5. Update the ```swatch``` color.

Let's test the app.

###Run the App

Tapping the top half of the screen stores the current ```swatch``` color, which appears as a strip of color on the bottom half of the screen. The numeric color values displayed as text on the bottom of the screen are taken directly from the ```swatch``` variable.

The sequence of events can be summarized as follows: We receive the accelerometer values from the hardware sensor and remap them into color values that we then display via the ```background()``` method in real time. When we tap the screen and pick a color, all three color values are stored in ```swatch```. The numeric color value displayed as text is derived directly from the ```swatch``` color by using [Processing's ```red()```][14], ```green()```, and ```blue()``` extraction methods, grabbing each value from ```swatch``` individually.

Clearly, though, storing one color is not enough. We've organized the screen and code so we can handle multiple colors, so let's take it a step further. We want to store multiple colors in such a way that we can recall them later individually. To implement this effectively, we need a color array.

[14]: http://processing.org/reference/red_.html

###Build a Palette of Colors

In this section, we'll build a palette of colors using a list of colors, or a color [array,][15] as illustrated in <!--ref linkend="fig.color.mixer" -->. When you see a color you like, you'll be able to store it as one of eight swatches on the screen. In our example, we are dealing with a color array and we want to store a list of colors in a ```palette[]``` array. Each data/color entry in the list is identified by an index number that represents the position in the array. The first element is identified by the index number, ```[0]```; the second element, ```[1]```; and the last element, ```palette.length-1```. We need to define the array ```length``` when we create the array.

ArrayList is an alternative here because it is able to store a varying number of objects. It's great, but it has a steeper learning curve. More info is available at http://processing.org/reference/ArrayList.html.

[15]: http://processing.org/reference/Array.html

###Color mixer app

The image shows the color determined by the device orientation on the top half of the screen and the palette of saved colors at the bottom.

<!-- imagedata fileref="images/Sensors/ColorPicker.png" width="40%" -->

We can create arrays of any data type, for example ```int[]```, ```String[]```, ```float[]```, and ```boolean[]```. For a color array that stores up to, let's say, eight colors, we need to change the ```swatch``` variable from the previous <!--ref linkend="code.accelrometer.color.picker" -->, into this:

```
color[] palette = new color[8];
```

As a result, we can then store eight colors sequentially within the ```palette``` array. This touches on a prime programming principle: build the code to be as adaptable and versatile as possible. In our case, we want the app to work with any number of colors, not just eight. So we need to aim at more (```n```) colors and introduce a ```num``` variable that can be set to the amount we want to work with (```8```). Sure, the UI might not adapt as neatly if we set ```num``` to ```100```, for example. But the code should be able to handle it without breaking. With adaptability in mind, we also program the GUI independent of the screen's size and resolution. In a diverse and rapidly changing device market, this approach prepares the app for a future filled with Android devices of every conceivable size.

Now that we have an array in which to store our colors, let's talk about its sidekick: [the ```for``` loop.][16]
Because arrays are equivalent to multiples, the ```for``` loop is typically used to parse the array. It's designed to iterate a defined number of times, here ```num``` times, until it reaches the end of our ```palette```. The init, test, and update conditions in a ```for``` loop are separated by semicolons, here with ```i``` serving as the counter variable.

When Processing encounters the ```for``` loop, the counter variable is set to the init condition (```i=0```) and then tested (```i<num```);  if the test passes, all statements in the loop are executed. At the end of the loop, the counter variable is updated (```i++```), which here means  incremented by one and then tested again, and if the test passes, all statements in the loop are executed. This continues until the test condition is ```false```, and Processing continues to interpret the statements following the ```for``` loop.

Let's now put this into the context of our color mixer sketch.

[16]: http://processing.org/reference/for.html

<!-- code id="code.accelrometer.color.picker.array" file="code/Sensors/AccelerometerColorPickerArray/AccelerometerColorPickerArray.pde" language="java" start="import" end="end" -->

Let's take a look at the main additions to the sketch.

1. Set the quantity of colors to be stored to ```8```.
2. Set up the color [array][15] to hold the previously defined number of colors.
3. Set an index variable that indicates the current color we are working with in the palette, represented by the index number in the color array.
4. [Round][17] the floating point value of the color value to an integer so we can read it better.
5. Iterate through the color array using a [```for```][16] loop.
6. Step through all the colors in the list using the ```for``` loop, and set the fill color for the rectangle to be drawn.
7. Display each color in the array with a rectangle set to the individual fill color in the list. Rectangles are displayed in sequence on the bottom of the screen; their width and position is defined by the number of colors in the list. The rectangle size is determined by the screen width and then divided by the total number of swatches, ```num```.
8. Assign the three color values to the palette, cast as color type.
9. Increment the index number, moving on to the next position in the list.
10. Reset the index when the ```palette``` is full.

Let's run the sketch now.

[17]: http://processing.org/reference/round_.html

###Run the App

On the device, we can tap the screen and the color swatches on the bottom of the screen update to the current color we've mixed by moving the device. If we fill all the swatches, it continues again at the beginning of the buffer. This is because we are setting  ```paletteIndex``` back to ```0``` when the array reaches its end.

Building on the code we've previously developed, we've compiled a number of features into a color mixer prototype. This iterative process is typical when building software. We take small and manageable steps, test/run frequently, and make sure we have always saved a stable version of the code we are working with. This is good practice so that we can always have a fallback version if we get stuck or called away.

Now that we've used the accelerometer to mix and save colors, we've also established that device motion is a UI feature that allows us to interact with the app. We can now continue to build on device motion and add a shake to clear all swatches in the palette. How can we detect a shake?

###Erase a Palette with a Shake

Shaking a device can be used as a deliberate gesture for controlling UI elements. On smart phones, it is typically assigned to the Undo command so that a shake can reverse or clear a prior action. Let's take a look at how this gesture can be detected and used by our color mixer.

What is a shake? When we move the device abruptly side to side, forward or backward, up or down, the idea is that our sketch triggers a "shake" event. For the color mixer, we want to use the shake for clearing out all color swatches. The shake needs to be detected no matter how we hold the device and independent of what's up or down. You might already anticipate the issue: we know well that the accelerometer is the ideal sensor for us to detect a shake, but we can't just use its *x*, *y*, or *z* values to trigger the shake when a certain threshold is reached because we can't assume our swaying gesture is aligned any of these axes. So this approach won't work and we need something else.

Any movement in space can be described with a three-dimensional vector that describes both the magnitude and the direction of the movement. You might (or might not) envision such a vector as an arrow in three-dimensional space—a visual representation of the mathematical construct from the field of trigonometry. A vector is ideal to handle all three axes from our accelerometer.

We are using the [```PVector``` class][18] again to store three variables in one package, which we are going to use to detect the shake. If we imagine how the vector would react to a shake, it would change erratically in direction and magnitude. In comparison, movement at a constant velocity causes no significant changes to the vector. Hence, if we continuously compare the movement vector of our device to the previous vector, frame by frame, we can detect changes when they reach a certain threshold.

Processing provides a few very useful vector math methods, including [```angleInBetween(vector1, vector2)```][19], to calculate the angle between two given vectors. So if we compare the current accelerometer vector with the vector of the previous frame, we can now determine their difference in angle, summarized into a single numeric value. Because this value describes angular change, we use a threshold to trigger the shake. For now, let's say this threshold angle should be ```45``` degrees. Alternatively, we could use the ```mag()``` method to detect a sudden change to the [vector's magnitude.][20] We'll work with the change to the vector angle in this example. OK, let's put it together.

<!-- code id="code.color.picker.complete" file="code/Sensors/ColorPickerComplete/ColorPickerComplete.pde" language="java" start="import" end="end"-->

Here's how we proceed to implement the shake detection using ```PVector```.

1. Create a processing vector of type ```PVector```.
2. Create a second vector as a reference to compare change.
3. Use the first ```.x``` component of the ```accelerometer``` vector. The second component can be accessed via ```.y```, and the third component via ```.z```.
4. Calculate the ```delta``` between the current and the previous vector.
5. Check the ```delta``` in radians against a threshold of ```45``` degrees.
6. Set the reference vector to the current one as the last step in ```draw()```.
7. Assign raw accelerometers to the accelerometer ```PVector```.
8. Set all palette colors in the array to the color black.

Let's run the code first and test the shake detection on the device. It helps us better understand some of the shake detection we talked about.

[18]: http://processing.org/reference/PVector.html
[19]: http://processing.org/reference/PVector_angleBetween_.html
[20]: http://processing.org/reference/PVector_mag_.html


###Run the App

If we play with the app, we can mix and pick colors as we did previously, as shown in <!--ref linkend="fig.color.mixer" -->. Small wiggles go undetected. As soon as we move the device quickly and a shake is triggered, all color swatches are erased from the palette.

Let's compare some of the small adjustments we made to the <!--ref linkend="code.color.picker.complete" -->, to the previous <!--ref linkend="code.accelrometer.color.picker.array" -->, and check what we've added. First of all, we eliminated the three floating point variables we had used globally for incoming accelerometer values. Instead, we are using the ```PVector``` variable ```accelerometer``` to do the same job. This means we need to update our ```map()``` method so it uses the vector components ```.x```, ```.y```, and ```.z``` of the ```accelerometer``` vector.

We use the same approach for the ```onAccelerometerEvent()``` method, where incoming values are now assigned to individual vector components.
To assign all three components at once to a vector, we can also use the ```set()``` method, as illustrated with ```pAccelerometer``` at the very end of ```draw()```.

In terms of additions, we've added the ```pAccelerometer``` variable so we have something to compare against. We use ```angleBetween()``` to calculate the angle difference between the current and previous frame and assign it to ```delta```. If the difference is larger than ```45``` degrees, we trigger the ```shake()``` method, resetting all ```palette``` colors to black and ```paletteIndex``` to ```0```.

The ```degrees()``` method used here converts radian values provided by the ```angleBetween()``` method into degrees. [Degrees][21] (ranging ```0```..```360```) are far more intuitive to work with than trigonometric measurements in [radians,][22] whose range is ```0```..```TWO_PI```.

When you take a second look at the app, you can also confirm that ```shake()``` is triggered consistently independent of device rotation. The shake detection feature completes our color mixer project.

[21]: http://processing.org/reference/degrees_.html
[22]: http://processing.org/reference/radians_.html

###Wrapping Up

You've completed a series of sensor-based apps in this chapter, and you've worked with motion, position, and environment sensors using the ```KetaiSensor``` class of the Ketai library. You've learned the difference between software- and hardware-based sensors and determined which sensors your device supports. You've used multiple sensors in one app, and you could go on to imagine other uses for motion-based features for your apps, such as speedometers for cars, shake detectors for putting your phone in silent mode, "breathometers" for biofeedback and analysis of breathing patterns...and the list goes on. You've also mastered working with color and learned how to mix and map it. You've learned how to work with Processing vectors to store multiple sensor values and to detect shakes.

Now that you know how the accelerometer can be used to determine the movement of an Android device, you are now ready to explore a more complex set of devices, such as GPS. Our next topic explores how to determine the device's geographic location using Android's geolocation features, which are typically used for navigation and location-based services.