### Chapter 2: 

#Working with the Touch Screen Display

Now that we've completed our first Android app, let's explore a device feature that has become particularly popular with mobile phones and tablets—multitouch. Virtually all Android devices ship today with a capacitive touch screen panel. It's a device we've gotten so accustomed to that we hardly "see" it as the hardware sensor that it is.

User interaction (UI) with Android touch screens differs somewhat from that of a mouse on a traditional computer display. First of all, we don't have one omnipresent mouse pointer for interacting with UI elements via rollovers, clicks, right-clicks, and double-clicks. In fact, we don't have a rollover or a physical "click" on the touch screen panel at all, hence UI interactions often require adjustments for the touch screen. Typically the Android device uses audiovisual cues such as click sounds or small device vibrations for user feedback.

There are a number of advantages to the multitouch screen interface to point out. First and foremost, the capacitive touch screen panel affords us more than one mouse pointer. We can work with two, five, even ten fingers on the Android, although more than three are rarely used. [Multitouch][1] allows us a variety of distinct finger gestures compared to the mouse, which we can only use to interact with the UI elements and other components displayed on the screen. The two most common multitouch gestures are the pinch and rotate gestures, typically used for scaling and rotating objects on the screen. 

In this chapter, we'll get started by learning to use the mouse callback methods available in Processing for Android. Then we'll dive into the different color modes Processing has to offer, an essential topic that we need to address to work with graphics and images throughout the book. Building on the basic drawing sketch <!-- linkend="code.basic.drawing" -->, we'll use the mouse speed to manipulate the hues of the ellipses we draw.

Finally, we'll dedicate the second part of the chapter to the multitouch features of the Android touch screen and create a sketch that showcases the most common gestures, including the tap, double-tap, long press, flick, pinch, and rotate gestures. In the sketch we'll develop, we'll manipulate the scale, position, rotation, and color of a rectangle using multitouch gestures.

To make working with multitouch gestures easy, we'll use the [Ketai library for Processing,][2] which greatly simplifies the process. We'll work with Ketai throughout the book, as it also simplifies working with sensors, cameras, location, and networking—all the hardware features that are typically difficult to work with. We'll download and install the library step by step and take a quick look at the main Ketai classes.

Let's take a look at how the touch screen panel works.

[1]: http://en.wikipedia.org/wiki/Multi-touch
[2]: http://ketai.org

###Introducing the Android Touch Screen

The capacitive touch screen panel of an Android device consists of a glass insulator coated with a transparent conductor. When we interact with the touch screen surface, our fingertips act as electrical conductors—not very good ones, but good enough to be detected. A touch on the screen surface distorts the electrostatic field, causing a change in its electric capacitance, which can be located relative to the screen surface. The horizontal and vertical position of the fingertip relative to the screen is then made available to us through the Android OS; it is updated only when we touch or move a fingertip across the screen.

The apps we write in Processing have a flexible screen orientation by default, which means our app switches orientation automatically from portrait to landscape depending on how we are holding the phone or tablet–this is detected by the accelerometer sensor we'll get to know in <!-- linkend="sec.display.accelerometer.values" -->. We can lock the orientation using [Processing's ```orientation()``` method using either the ```PORTRAIT``` or the ```LANDSCAPE``` parameter.][3]

<!-- 
2.1 REVISION
Changed previous link (footnote 3 - old link is dead) from
http://wiki.processing.org/index.php?title=Android#Screen.2C_Orientation.2C_and_the_size.28.29_command to http://android.processing.org/reference/environment/orientation.html
-->

For compatibility, Processing uses the constants ```mouseX``` and ```mouseY``` when it's running in Android mode, corresponding in this case to the position of a user's fingertip relative to the upper left corner of the device touch screen rather than the position of the mouse cursor on a desktop screen. This allows us to use the same code across modes. When using ```mouseX``` in Android mode, we refer to the horizontal position of the fingertip on the touch screen panel, and when we use ```mouseY```, we refer the fingertip's vertical position. Both are measured relative to the [coordinate system's][4] origin in the upper left corner of the touch screen. Moving the finger to the right on the screen will increase ```mouseX``` values; moving the finger down will increase ```mouseY```.

In Android mode, we can also use the following mouse methods, which are available in all Processing modes. The Android touch screen gestures correspond to the following mouse events:

[mousePressed][5] This callback method is called every time a finger touches the screen panel. It corresponds to a mouse-pressed event on the desktop when the mouse button is pressed down.


[3]: http://android.processing.org/reference/environment/orientation.html
[4]: http://processing.org/learning/drawing/
[5]: http://processing.org/reference/mousePressed_.html
