###Chapter 5:
#Using Android Cameras

Now that we've learned to work with several of the most important Android sensors, let's take a look at another device that's found on every Android phone and tablet—the digital camera. Your device includes at least one and sometimes two cameras: the back-facing camera, which you commonly use to take high-resolution pictures and capture video, and the front-facing camera, designed for video calls and chat at a lower resolution. The digital camera can also be used as a sophisticated light-sensitive sensor to build a  variety of interactive applications that go beyond pictures and video clips. We'll explore each of these uses and more in this chapter.

We'll start with the back-facing camera and learn how to display what it "sees" as an image on the Android screen. Next we'll learn how to switch between the front- and back-facing cameras found on most devices and add a feature that allows us to save their images to the Android's [*external storage*][1] which is a default public location on the device that can be read by other apps. Depending on the device settings, this can be located on an SD card, in internal storage, or on media mounted over the network. To make it easier to use these features, we'll add a few UI buttons to initiate each task.

Once we have stored an image from a camera, we may want to make further use of it. Additional APIs allow us to stack stored images to create a composite image that consists of a foreground and a background. We'll put this functionality to work by building a photo booth app, where we will create a fake backdrop and superimpose a snapshot on it.

But there's more. The Processing language also provides us with APIs that we can use to analyze the content of the images that we capture at the pixel level. We'll use that capability to build a game that can detect the color of a moving object—red or blue—and display the pattern of its motion on the device screen. To make the activity into a game, two players will compete to fill the screen by waving colored objects above it. The first to fill more than 50 percent of the screen wins. In building the game, we'll get to know the Processing ```PImage``` class, which allows us to manipulate images and work directly with pixel values.

Finally, we'll end the chapter with a brief look at Android's built-in face recognizer. This lesser-known camera feature is made possible by computer vision algorithms and the increased processing power that's finding its way into Android devices. Android provides a face-finder API that uses pixel-level image analysis to make inferences about what's going in the device's field of view. We'll demonstrate its use with a brief example.

Before we get started on our first project, let's first take a look at some of the camera features and classes we'll be using throughout the chapter to build our camera apps.

[1]: http://developer.android.com/guide/topics/data/data-storage.html#filesExternal

###Introducing the Android Camera and APIs

Android phones and tablets are typically equipped with two cameras. Camera hardware varies across phones and tablets, but typically the back-facing camera is used to capture images and HD video at a resolution of 5 mega-pixels. The lower-resolution, front-facing camera is designed for video calls. The Google Nexus 6 phone, for example, features a 13-megapixel back-facing camera (4160 x 3120 pixels) with a built-in LED flash and a 2-megapixel front-facing camera.

Mobile cameras don't rely on hardware alone. The Android SDK provides a variety of features through its ```Camera``` class that make the camera more than just a [camera.][2] We can use code to work with camera metering, focus, exposure, white balance, zoom, image capture, and even face detection. Geolocation data can also be added to image metadata so that images can be organized by the location where they were taken. The Google Camera app that ships with Android devices allows users to manipulate those features in its UI. But we're going to learn how apps can use them as well.

To implement the camera features in this chapter, we'll work mainly with a single Ketai library class and a highly versatile Processing type:

* [`KetaiCamera`][3]
This Ketai library class provides simplified access to the cameras on a device by making Android's `Camera` class available to Processing. When we work with `KetaiCamera`, we define the width, height, and frame rate for the camera preview we'd like to work with. It provides the necessary methods to define basic camera settings (such as resolution) and camera controls. It also provides access to the camera flash and Android's built-in face recognizer. 

* [`PImage`][4]
This is a Processing datatype for storing images (`gif`, `jpg`, `png`, `tif`, and `tga`). It provides a number of methods that help us load, save, and filter  images, including access to the image `pixels[]` array that contains information on pixel color values. The methods we are using in this chapter are described further in [Working with the PImage Class](../cameras.html#working-with-the-pimage-class).

Now let's take a closer look at the `KetaiCamera` methods we'll be using.

[2]: http://developer.android.com/guide/topics/media/camera.html
<!-- NOTE 5.1 http://developer.android.com/reference/android/hardware/Camera.html is deprecated; site recommends: https://developer.android.com/reference/android/hardware/camera2/package-summary.html -->
[3]: http://ketai.org/reference/camera/
[4]: http://processing.org/reference/PImage.html

###Working with the KetaiCamera Class

Besides providing the typical `start` and `stop` methods that we use to control the sensors on a device, we'll use the following more specialized `KetaiCamera` methods for the projects in this chapter:

* *`onCameraPreviewEvent()`* Returns a preview image from the camera when a new frame is available—the image can then be read into the `KetaiCamera` object using the `read()` method.

* *`addToMediaLibrary()`* Makes a picture publicly available in the default preferred media storage on the device—the method requires a picture filename or path to the picture. After using the method, pictures are also available as an album in the Gallery app.   

* *`manualSettings()` and `autoSettings()`* Toggles between manual and automatic camera settings—`manualSettings()` locks the current camera exposure, white balance, and focus. `autoSettings()` lets the device adjust exposure, white balance, and focus automatically.

* *`enableFlash()` and `disableFlash()`* Switches the built-in rear-facing camera flash on and off—this can only be used if the rear camera is on.

* *`savePhoto()`* Saves a picture in the current camera preview size to the preferred media storage.

* *`setPhotoSize()`* Sets the picture's size to be saved in a different, for example, higher, resolution.

* *`setSaveDirectory()`* Defines where to save the pictures to—by default, pictures are saved to the public media storage on the device. The path can also be set to another destination, including private folders. Requires testing whether the directory path is valid.

* *[`KetaiSimpleFace()`][5]* A Ketai wrapper for the `Face` class in [Android's `FaceDetector` package][6], which returns the midpoint location and distance between the eyes recognized by the device cameras.

* *```KetaiSimpleFace[]```* A ```PVector``` list containing the position data of detected faces within a camera image&emdash;the center point between the left and right eyes and the distance between the eyes are stored in this array.

With this brief summary of ```KetaiCamera```methods for this chapter, let's get started with our first camera app.

[5]: http://ketai.org/reference/cv/ketaisimpleface/
[6]: http://developer.android.com/reference/android/media/FaceDetector.Face.html

###Display a Back-Facing Camera Full-Screen Preview

For this initial camera app shown below, we'll display the view seen by the back-facing Android camera.

![](images/camera/GettingStarted-sm.png)
#####Figure 5.1 — Camera preview app.
######The illustration shows a camera preview image at a resolution of 1280 x 768 pixels, displayed on the touch screen of a Google Nexus 6, whose resolution is 2560 x 1440 pixels. 

We'll use the `KetaiCamera` class to connect to and start the camera. The `KetaiCamera` class streamlines this process significantly for us. For example, creating a simple camera preview app using `KetaiCamera` takes about ten lines of code, compared with about three hundred documented on the [Android developer site.][7] `KetaiCamera` helps us set up and control the camera, and it also decodes the [YUV][8] color format provided by the Android camera into the RGB format used in Processing.

`KetaiCamera` works similarly to other Ketai classes that we've explored in {{ book.chapter3 }}. First we create a `KetaiCamera` object and `start()` the camera. Then we update the screen as soon as we receive a new image from the camera via `onCameraPreviewEvent()`. And finally, we use Processing's own `image` method to display the camera preview.

The code for a basic camera sketch looks like this: 

#####code/Camera/CameraGettingStarted/CameraGettingStarted.pde
[include](code/camera/CameraGettingStarted.pde)
<!-- 5.2 ERROR - Sketch does not run. No errors shown in console. -->

Let's take a closer look at the steps you take and the methods you use to set up a camera sketch.

1. Create an instance of the `KetaiCamera` class to generate a new camera object with a preview width and height of 1280 x 768 pixels and an update rate of 30 frames per second.

2. Call `imageMode()` to tell Android to center its camera images on its screen. All images are now drawn from their center point instead of from the default upper left corner.

3. Display the camera preview using the [`image()` method][9]. It requires an image source as well as the `x` and `y` coordinates of the image to display. Optionally, the image can be rescaled using an additional parameter for the image `width` and `height`, which is what we are doing here.

4. Use the ```onCameraPreviewEvent()``` callback method for notification that a new preview image is available. This is the best time to read the new image.

5. Read the camera preview using the ```read()``` camera method.

6. Toggle the camera preview on and off when you tap the screen.

Let's try the sketch on the Android phone or tablet.

[7]: http://developer.android.com/samples/Camera2Basic/project.html
[8]: https://en.wikipedia.org/wiki/YUV#Conversion_to.2Ffrom_RGB
[9]: http://processing.org/reference/image_.html

###Run the App

Before we run the sketch, we need to give the app permission to use the camera. Here's how: On the Processing menu bar, select  Android  &mapsto;  Sketch Permissions.  In the Android Permissions Selector that appears, select Camera. As we've done already in {{ book.chapter4 }} earlier in [Setting Sketch Permissions](../geolocation.html#setting-sketch-permissions), the Android must allow the app to use the camera through a certificate, or it must prompt the user to approve the request to use the camera. If the app has permission to use the camera, the device will remember and not prompt the user anymore. For this app, we only need to check the permission for `CAMERA`.

Now run the sketch on the device. The rear-facing camera preview starts up as illustrated in Figure 5.1, in a [resolution of 1280px width and 768px height][10], known as WXGA. Android cameras are set to auto mode, so they adjust focus and exposure automatically. Depending on your phone's native screen resolution, the preview image might cover the screen only partially. You can certainly scale and stretch the preview image, which also changes the image aspect ratio and distorts the image. For instance, if you set the width and height parameters in the `image()` method to `screenWidth` and `screenHeight` as in the following code, the camera preview will always stretch full screen independent of the screen's size and resolution. 

```
image(cam, width/2, height/2, width, height);
```

Go ahead and try the fullscreen mode on your device. For a preview image in a camera app, it doesn't seem like a good idea to stretch the image, though. When we write apps that scale seamlessly across devices, we typically lock and maintain aspect ratios for images and UIs.

<!-- 5.3 EDIT - light revision - link removed since code is directly above / presumably currently open in their Processing console -->
As we can see in CameraGettingStarted.pde, the steps we take to get the camera started are like the steps we took working with other sensors ({{ book.chapter3 }}). First we instantiate a `KetaiCamera` object using a defined `width`, `height`, and `frameRate`. Then we start the camera. And finally, we read new images from the camera using `onCameraPreviewEvent()` and display them. The frame rate in this sketch is set to 30 frames per second, which is the typical playback speed for digital video, giving the appearance of seamless movement. Depending on your device and image conversion performance, the image preview might not be able to keep up with the designated thirty previews per second. In that case, the sketch will try to approach the set frame rate as best it can. 

With less than ten lines of code added to the typical processing sketch methods, we've completed our first camera app. The `onPause()` and `exit()` methods are responsible for releasing the camera properly when we pause or exit the app. The methods make sure that other apps can use the cameras and that we don't keep them locked down for our app alone. You can only have one active connection to the cameras at a time.

[10]: http://en.wikipedia.org/wiki/Display_resolution

###Toggle Between the Front- and Back-Facing Cameras

Most mobile Android devices come with both the front-facing and back-facing cameras. We need a UI button that toggles between the front and back camera. Let's also activate the flash that's built into most back-facing cameras and add an additional pair of button controls to start and stop the camera. The final app then looks like this:

![](images/camera/FrontBack-sm.jpg)
#####Figure 5.2 — Camera preview app with UI.
######The UI added to the Preview app allows users to start and stop the cameras, toggle between the front- and back-facing cameras, and activate the built-in flash.

Android lists all built-in device cameras and allows us to pick the one we'd like to work with. For instance, the Nexus 6 uses the camera index ID `0` for the back-facing camera and  `1` for the front-facing camera. Future Android devices might add more cameras to the device, potentially for 3D applications, so having an enumerated list enables Android OS to incorporate them.

Let's build on the previous sketch CameraGettingStarted.pde, adding some camera controls that will remain pretty much the same throughout the chapter. Because this sketch is longer than the previous one, we'll separate it into two tabs: a main tab containing the essential `setup()` and `draw()` methods, which we'll name `CameraFrontBack` (identical to the sketch folder), and a second tab, which we'll call `CameraControls` and will contain the methods we need to `read()` the camera preview,  the methods to `start()` and `stop()` the camera, and the UI buttons we'll use to control the camera via the touch screen.

Separating the code this way helps us reduce complexity within the main tab and focus on relevant code for the projects we are working on. We'll store each tab in its own Processing source file, or `pde` file, inside the sketch folder. You can always check what's inside your sketch folder using the menu  Sketch  &mapsto;  Show Sketch Folder, or the shortcut *`K`*. 

Let's first take a look at the main tab:

#####code/Camera/CameraFrontBack/CameraFrontBack.pde
[include](code/camera/camera-front-back/camera-front-back.pde)

In the main `CameraFrontBack` tab, we've added new features.

1. Print all available device cameras to the Processing console using the `list()` method included in `KetaiCamera`.
2. Set the back-facing camera ID to `0` via `setCameraID()`.
3. Increase the `textSize()` for the UI buttons to `24` pixels.
4. Call the custom `drawUI()` method, taking care of drawing UI buttons.
5. The `draw()` method contains only a call to the `image()` method, used for displaying the camera preview, and a call to the custom `drawUI()` method we defined for our UI elements.

Now let's explore the second sketch tab called ```CameraControls```, where we'll keep all the code that controls the camera.

#####code/Camera/CameraFrontBack/CameraControls.pde
[include](code/camera/camera-front-back/camera-controls.pde)

In this ```CameraControls``` tab, we use the following UI elements and camera methods to complete these steps.

1. Display the UI on the screen using a custom ```void``` function called ```drawUI()```. Void functions execute but don't return a value. The UI in this example consists of buttons that use half-transparent rectangles for their backgrounds and text labels for their names.
2. Check if the camera is running using the boolean method ```isStarted()```. If the method returns ```TRUE```, we display "stop"; otherwise show "start."
3. Capture touch screen input for camera controls using ```mousePressed()```.
4. Check if the user is interacting with the UI at the top of the screen using the ```mouseY``` constant. If we receive user input within the top ```40``` pixels of the screen, we continue checking the horizontal position via ```mouseX```.
5. Check if the user presses the leftmost button to start and stop the camera. Each button occupies one-fourth of the screen width, so we check if the horizontal tap position is within the range ```(0..width)/4```. We take the same approach for the other buttons.
6. Check if the user taps the second button, which is responsible for toggling between the rear and the front cameras. We acquire the current camera ID using ```getCameraID()``` and toggle using ```setCameraID()```.
7. Check if the user taps the third button, which is responsible for toggling the camera flash on and off.
8. Check the camera's flash status using the ```isFlashEnabled()``` method and toggle the flash by calling ```enableFlash()``` or ```disableFlash()```, depending on the returned boolean value.

Let's go ahead and test the app now.

###Run the App

Load or enter the two tabs of the sketch, run it on your device, and take a look at the Processing console. You should see a list of all the built-in cameras on your device with their respective IDs, as shown below. 

```
[camera id [0] facing:backfacing, camera id [1] facing:frontfacing]
```

When the app launches, the rear-facing camera becomes the default camera, but it remains paused until we start it up. Press the Start button now. The camera preview should appear on the screen at the defined resolution of 1280 x 768 pixels. Toggle the camera from the front to the back using the Camera button. Start and stop the flash. The camera flash belongs to the back-facing camera and works only when the rear camera is active.

Now that we know how to preview and control the camera, it's time to put it to work—let's snap some pictures. In our next project, we'll learn how to store images on the device.

To snap pictures and save them to the external storage of our device, we'll first need to add a ```savePhoto()``` method to the previous sketch <!-- ref linkend="sec.camera.front.back" -->. The method takes care of capturing the image and writing it to the device's external storage in a folder that bears the app's name. When the photo is written to this public directory on the SD card, we receive a callback from ```onSavePhotoEvent()``` notifying us that the writing process is complete. This callback method is also useful if we'd like to notify the device's media library to make the photos available to other applications, which we accomplish with a call to the ```addToMediaLibrary()``` method. Once we've added photos to the media library, we can browse them in the Gallery—Android's preinstalled app for organizing pictures and video clips shown in <!-- ref linkend="fig.android.gallery" thispage="yes" -->. The larger the captured photo size, the longer it takes to transfer the image buffer and store it on the disk.

![](images/camera/GalleryAlbum-sm.jpg)
#####Figure 5.3 — Android gallery.
######When we take pictures with our camera app and add them to the public external storage, they are available in an album within Android's Gallery.

To refine the camera app UI, let's also add a Save button that allows us to save the image by tapping the touch screen. Some status info on the current camera settings also seems useful.

For the Save feature, we need to modify the ```draw()``` method in the main ```CameraSavingImages``` tab and make some adjustments to ```CameraControls```. The following code snippets show only the modifications to the previous code in <!-- ref linkend="code.camera.front.back" -->CameraFrontBack.pde<!--/xref--> and <!-- xref linkend="code.camera.front.back.controls" -->CameraControls.pde<!--/xref-->. You can also download the complete ```pde``` source files from the book's website, and if you’re reading the ebook, just click the green rectangle before the code listings. 

Let's take a look.

#####code/Camera/CameraSavingImages/CameraSavingImages.pde
[include](code/camera/CameraSavingImages/CameraSavingImages.pde)

Now let's take a look at the new code we've added to ```draw()``` and what it does.

1. Check the status through the boolean method ```isStarted()```. Returns ```TRUE``` if the camera is on and ```FALSE``` if it's off.
2. Save the current style settings using ```pushStyle()``` to preserve the ```stroke()```, ```textSize()```, and default ```textAlign(LEFT, TOP)``` for the UI elements, and add a new ```textAlign(CENTER, CENTER)``` style using [```pushStyle()```][11]. Requires ```popStyle()``` to restore previous style settings.
3. Get the index number of the currently chosen camera using ```getCameraID()```.
4. Get the preview image width (in pixels) of the current camera using ```getImageWidth()```.
5. Get the preview image height (in pixels) of the current camera using ```getImageHeight()```.
6. Get the image width (pixels) of a photo taken by the current camera using ```getPhotoWidth()```. The photo size is separate from the camera preview size.
7. Get the image height (pixels) of a photo taken by the current camera using ```getPhotoHeight()```.
8. Inquire about the status of the flash using the boolean method ```isFlashEnabled()```. (The flash belongs to the rear camera and can only be used if the back-facing camera is on.)
9. Restore the previous style settings using ```popStyle()```.

Changes to ```draw()``` mostly concern the text output that gives us some feedback on the camera settings. Next let's examine the modifications to the camera controls.

#####code/Camera/CameraSavingImages/CameraControls.pde
[include](code/camera/CameraSavingImages/CameraControls.pde)

Take a look at how the code adds the following features.

1. Add a UI button ```text()``` label for saving images.
2. Add a condition to check if the user taps the added Save button.
3. Save the photo to the device's external storage using ```savePhoto()```. The method can also take a parameter for a custom file name.
4. Receive notification from the ```onSavePhotoEvent()``` callback method when a picture is saved to external storage.
5. Add the picture to the device's public preferred media directory on the external storage using ```addToMediaLibrary()```.

With the addition of the ```savePhoto()``` and ```addToMediaLibrary()```, the app is now ready to store pictures in external storage, which makes the images public and available for other apps, such as the Android Gallery app. Once again, let's make sure we've set the permissions we need to write to external storage (see also <!-- titleref linkend="sec.sketch.permissions" -->). In the Android Permissions Selector, check the boxes next to Write_External_Storage in addition to Camera. This time, we need both to run this sketch successfully.

[11]: http://processing.org/reference/pushStyle_.html

###Run the App

Run the modified sketch on an Android device and tap Save to save the picture.

Now let's take a look at the Gallery and see if the photos we took show up there properly. Press the  Home  button on the device and launch the  Gallery  app, which comes preinstalled with the Android OS. The images you took will appear in the ```CameraSavingImages``` album that bears the same name as the app. Making the images available publicly allows us to share them with other apps. The use of ```addToMediaLibrary()``` is certainly optional. If we use only the ```savePhoto()``` method, the images are still saved to the publicly available external storage, but they won't be visible to other apps using the external storage.

We've now learned how to save images to the external storage of an Android device. In the next project, we'll create a photo booth app that allows us to blend and superimpose the images we capture. To accomplish this task, we'll blend multiple image sources into one. Let's take a look.

###Superimpose and Combine Images

In this project, we'll superimpose a snapshot on a background image, as we might do with a friend in a photo booth at a carnival. Using the Android's front-facing camera, we'll create an app that works like a photo booth, with the small twist that we use scenery loaded from a still resource image as the image's background instead of the physical backdrop we might find in an actual photo booth. We want to be able to use the app anywhere, independent of our current surroundings or lighting level. This is why we need to separate the foreground image from its background. Using color pixel calculations, we can erase a background image and superimpose a snapshot onto a scene loaded from an image in a resource file, as shown in <!-- ref linkend="fig.photo.booth" -->.

The photo booth app combines images from two sources: the preview image acquired by the front-facing camera and an image loaded from a file that will be included with the app.


![](images/camera/Photobooth-sm.jpg)
#####Figure 5.4 — Photo booth app.
######The image shows the photo booth app using the rover background image we've chosen.

First, take a snapshot with the device sitting still on the table. When you take the snapshot, be sure to stay out of the camera's field of view. We'll use this snapshot as a reference image, which we'll subtract from the camera's preview image. If we've held the camera steady, this subtraction will leave behind an empty, black image by eliminating all the pixels that have not changed. For example, if the live camera and the snapshot images are identical, any ```pixel[n]``` that we choose at random will have the identical value in both images. Let's say, for the sake of argument, that the color of a particular pixel is ```color(135, 23, 245)```. If we subtract the color value of the pixel in one image from the corresponding pixel in the other&emdash;```color(135, 23, 245)``` minus ```color(135, 23, 245)```&emdash;the result is ```color(0, 0, 0)```.

When this subtraction of color values is performed for all of the pixels in an image pair, the resulting effect is that when someone enters the frame of the camera again, the image of the subject will appear to be &lquot;floating&rquot; in front of the background image of our choosing: the landscape of Mars or a view of Lake Michigan from the grounds of the World's Fair. The result: a portable photo booth that we can use to transport ourselves into any scene we'd like.

Let's start by looking in more detail at some of the ```PImage``` features we'll use.

###Working with the PImage Class

[```PImage```][12] is a datatype for storing images that supports ```.tif```, ```.tga```, ```.gif```, ```.png```, and ```.jpg``` image formats. Listed below are some of the ```PImage``` methods that we'll be using for this project:

* *[```loadImage()```][13]* Loads the pixel data for the image into its ```pixels[]``` array
* *[```loadPixels()```][14]* Loads the pixel data for the image into its ```pixels[]``` array&emdash;this function must always be called before reading from or writing to ```pixels[]```.
* *[```updatePixels()```][15]* Updates the image with the data in the ```pixels[]``` array&emdash;the method is used in conjunction with ```loadPixels```.
* *[```pixels[]```][16]* Array containing the color of every pixel in the image
* *[```get()```][17]* Reads the color of any pixel or grabs a rectangle of pixels
* *[```set()```][18]* Writes a color to any pixel or writes an image into another
* *[```copy()```][19]* Copies the entire image
* *[```resize()```][20]* Resizes an image to a new width and height&emdash;to resize proportionally, use ```0``` as the value for the width or height parameter.
* *[```save()```][21]* Saves the image to a TIFF, TARGA, GIF, PNG, or JPEG file

[12]: http://processing.org/reference/PImage.html
[13]: http://processing.org/reference/loadImage_.html
[14]: http://processing.org/reference/loadPixels_.html
[15]: http://processing.org/reference/PImage_updatePixels_.html
[16]: http://processing.org/reference/pixels.html
[17]: http://processing.org/reference/PImage_get_.html
[18]: http://processing.org/reference/set_.html
[19]: http://processing.org/reference/copy_.html
[20]: http://processing.org/reference/PImage_resize_.html
[21]: http://processing.org/reference/save_.html

Now let's write some code.

For this project, we'll create a new sketch, again with two tabs, and copy the code into each tab individually. We'll call the main tab ```CameraPhotoBooth``` and the second tab ```CameraControls```, which we'll reuse from the previous sketch <!--ref linkend="code.camera.saving.images.camera.controls" /-->.

Let's first take a look at the main tab.

#####code/Camera/CameraPhotoBooth/CameraPhotoBooth.pde
[include](code/camera/CameraPhotoBooth/CameraPhotoBooth.pde)

Here are the steps we need to take in the main tab.

1. Set the camera ID to the front-facing camera using ```setCameraID()```, which has the index number ```1```.
2. Load the ```rover.jpg``` resource image from the data folder using ```loadImage()```, which will serve as a replacement for the background.
3. Load the camera pixel array using ```loadPixels()```.
4. Load the snapshot picture pixel array using ```loadPixels()```.
5. Load the ```mux``` pixel array using ```loadPixels()``` to store the composite photo booth image.
6. Parse the ```pixels``` array and get the current screen pixel color at array position ```i```.
7. Calculate the ```red()``` difference between the individual camera and snapshot pixel values. Convert the result into an absolute, always positive number using [```abs()```][22]. Make the same calculation for the green and blue pixel values.
8. Add the differences for the red, green, and blue values to calculate the ```total``` difference in color, which will be used as a threshold for the composite image. Values can range from ```0``` (no change) to ```255``` (maximum change) for ```total```. Use ```128``` (50 percent change) as the threshold to choose between the live camera or the background image.
9. Set the composite ```mux``` image to the background image ```bg``` pixel for small changes in the camera image.
10. Set ```mux``` to the camera pixel if the camera preview changed a lot.
11. Update the composite ```mux``` pixels used to display the calculated result using ```updatePixels()```.
12. Display the composite image ```mux``` on the screen using the ```image()``` method, which now contains the combined pixel data from the live camera and the background image.

[22]: http://processing.org/reference/abs_.html

In this app, we've changed the ```draw``` method from our previous camera app <!--ref linkend="code.camera.saving.images" -->. We focus on combining images in ```draw```, where we use a background image&emdash;a snapshot taken from the camera preview&emdash;and the current camera preview taken in the same location. We calculate the difference between this current camera preview and the snapshot to determine which pixels changed. Then we display the stored background image in all the pixels that did not change and display the live camera pixels where the preview changed. When a person enters the scene after taking the snapshot, those changed pixels function as a mask for the background image. This is why it's also important that the camera doesn't move during the process.

###Adding Media Assets to a Sketch

The ```setup``` method contains a reference to a &lquot;canned&rquot; image called ```rover.jpg```. The image is stored in the sketch's ```data``` folder. We load the image into the ```PImage``` variable ```bg``` at the beginning, when the app starts up. Here we use ```PImage``` only to store the image. We'll discuss this datatype further in the next project, <!-- ref linkend="sec.pimage" -->, where we rely on some useful ```PImage``` methods to work with pixel values.

The sole purpose of the sketch's ```data``` folder is to host all necessary media assets and resource files for our sketch, such as images, movie clips, sounds, or data files. If a resource file is outside the sketch's ```data```, we must provide an absolute path within the file system to the file. If the file is online, we need to provide a URL. There are three ways to add a media asset to a sketch:

* Drag and drop the file you want to add onto the sketch window from your file system (for example, from the desktop) onto the Processing sketch window you want to add the file to. Processing will create the ```data``` folder for you in that sketch and place the resource file inside it.

* Choose  Sketch  &mapsto;  Add File...  from the Processing menu, and browse to the asset.

* Browse to the sketch folder (choose  Sketch  &mapsto;  Show Sketch Folder).

Now let's check what's changed in ```CameraControls```.

#####code/Camera/CameraPhotoBooth/CameraControls.pde
[include](code/camera/CameraPhotoBooth/CameraControls.pde)

In the Camera Controls tab, we reuse the UI button for the flash from the previous code <!--ref linkend="code.camera.saving.images.camera.controls" /--> and label it &lquot;Snapshot.&rquot; Because the flash belongs to the back-facing camera and it's much easier for us to use the front camera here, we don't need the flash any more for this project. The Snapshot button is now responsible for copying the pixels from ```cam``` to ```snapshot```, as shown below.

1. Set the camera to manual mode using the ```manualSettings()``` method, locking the current camera exposure, white balance, and focus.
2. Use the ```copy()``` method to take the snapshot. Use the snapshot image to subtract from the camera preview, erasing the background, and extracting the image foreground of the camera.

###Run the App

Now lean the Android upright against something solid so it can remain static, and run the app. When it starts up, press the Snapshot button, capturing a ```snapshot``` image from the camera preview. Make sure you are out of the camera field of view; if not, you can always retake the snapshot. Now, reenter the scene and see yourself superimposed on the landscape of Mars. Adjust the threshold value of ```128``` to be higher or lower to best match your lighting situation. You can use any resource image stored in ```CameraPhotoBooth/data```, so go ahead and swap it with another image resource of your choice.

This project showed us how to take control of two different image sources and combine them in creative ways. The project can easily be expanded to create a [chroma-key TV studio][23], in which we could superimpose live video of a TV show host onto a studio green screen. But we'll leave that as an exercise for the reader.

Now that we've gained some experience in manipulating images, let's use our ability to process information about pixels to create a two-person drawing game.

[23]: http://en.wikipedia.org/wiki/Chroma_key

###Detect and Trace the Motion of Colored Objects

In the drawing game that we'll build in this section, two players will compete to see who can  fill the screen of an Android device with the color of a red or blue object first. Without touching the device screen, each player scribbles in the air above it with a blue or red object in an attempt to fill as much space as possible with the object's color. When more than 50 percent of the screen is filled, the player that filled in the most pixels wins. We'll use the front-facing camera as the interactive interface for this game. It's job is to detect the presence of the colors blue or red within its field of vision and capture them each time it records a frame. The game code will increase the score of each player who succeeds in leaving a mark on the screen.

The camera remains static during the game. As <!--ref linkend="fig.magic.marker" thispage="yes" -->, illustrates, only the primary colors red and blue leave traces and count toward the score. If the red player succeeds in covering more pixel real estate than the blue, red wins. If blue dominates the screen, blue wins. If you are using an Android tablet you can step a little bit further away from the device than is the case for a phone, where the players are more likely to get in each other's way, making the game more competitive and intimate.

![](images/camera/MagicMarker-sm.png)
#####Figure 5.5 – Magic marker drawing game.
######Red- and blue-colored objects leave color marks, gradually covering  the camera preview. The color that dominates wins the game.

The magic marker drawing game uses color tracking as its main feature. As we implement this game, we put Processing's image class, called ```PImage```, to use. The main purpose of this datatype is to store images, but it also contains a number of very useful methods that help us manipulate digital images. In the context of this game, we'll use ```PImage``` methods again to retrieve pixel color values and to set pixel values based on some conditions we implement in our sketch.

###Manipulating Pixel Color Values

To create this magic marker drawing game, we need to extract individual pixel colors and decide whether a pixel matches the particular colors (blue and red) we are looking for. A color value is only considered blue if it is within a range of &lquot;blueish&rquot; colors we consider blue enough to pass the test, and the same is true for red. Once we detect a dominant color between the two, we need to call a winner.

For an RGB color to be considered blue, the [```blue()``` value][24] of the pixel color needs to be relatively high, while at the same time the [```red()```][25] and [```green()```][26] values must be relatively low. Only then does the color appear blue. We are using the Processing color methods ```red()```, ```green()```, and ```blue()``` to extract *R*, *G*, and *B* values from each camera pixel. Then we determine whether we have a blue pixel, for instance, using a condition that checks if ```blue()``` is high (let's say ```200```) and at the same time ```red()``` and ```green()``` are low (let's say ```30```) on a scale of ```0..255```. To make these relative thresholds adjustable, let's introduce variables called ```high``` and ```low``` for this purpose.

Let's take a look. The sketch again contains ```CameraControls```, which we don't discuss here because we already know the method to ```start``` and ```stop``` the camera.

[24]: http://processing.org/reference/blue_.html
[25]: http://processing.org/reference/red_.html
[26]: http://processing.org/reference/green_.html

#####code/Camera/CameraMagicMarker/CameraMagicMarker.pde
[include](code/camera/CameraMagicMarker/CameraMagicMarker.pde)

There are a couple of new methods for us to look at.

1. Create an empty ```PImage``` called ```container``` using the ```createImage()``` method to hold red and blue color pixels that have been detected in the camera preview image. The empty RGB image container matches the size of the camera preview image.
2. Calculate the fullscreen camera preview image width ```propWidth``` proportional to the camera preview aspect ratio. We get the ratio by dividing the screen ```height``` by the camera preview height ```camHeight``` and multiplying that with the ```camWidth```.
3. Draw the camera preview image in fullscreen size using ```image()``` if no player has won the game yet (```win``` equals ```0```). Match the image height with the screen height and scale the image width proportionately.
4. Get the color value at the image pixel location ```x``` and ```y``` using the ```PImage``` method ```get()```. Store the value in the ```color``` variable ```pixelColor```.
5. heck for reddish pixel values within the camera preview using the ```red()```, ```green()```, and ```blue()``` ```PImage``` methods to extract individual color values from the ```color``` datatype. Consider only pixel values with a red content greater than the ```high``` threshold and ```low``` green and blue values. Use the globals ```high``` and ```low``` for the upper and lower limits of this condition.
6. Check if the pixel is already taken by a color using ```brightness```. If the ```container``` is empty and not set yet, it has a brightness value of ```0```.
7. Check for blueish pixel value in the camera image. It requires a color with a high blue content, while the red and green values are ```low```.
8. Draw the ```container``` using the ```image()``` method. This ```PImage``` contains all the red and blue pixels we grabbed from the camera's preview image.
9. Check for the winner when at least 50 percent of the image is covered, comparing the combined ```redScore``` and ```blueScore``` values against ```0.50``` of all camera preview pixels.
10. Fade to the winning color by changing the ```fill``` opacity of a colored rectangle covering the screen. To achieve a continuous fade, use the ```win``` variable for the alpha parameter so that the following rectangle is drawn with decreasing opacity (```0```: fully opaque, ```255``` fully transparent).
11. Load the pixel data from the container ```PImage``` into the pixels[] array. The function must be called before writing to (or reading from) ```pixels[]```.
12. Empty all ```pixels[]``` in the container image pixel array. Set all pixels to the ```color(0, 0, 0, 0)```, which is a fully transparent black color. The Processing rule is that you must call ```loadPixels()``` before you read from or write to ```pixels[]```, even if some renderers seem not to require this call.

Now let's test the game using some blueish and reddish objects and test how well the camera picks up their colors. Any kind of object will do as long as its color is a vibrant red or blue&emdash;the more intense its hue and brightness the better.

###Run the App

Grab a friend and a few blueish and reddish objects, and get ready to scribble madly mid-air and fight for pixel real estate on the Android device. Run the sketch on the device. When the game starts up, the camera preview will appear centered on the screen, stretched to fullscreen size. Reddish and blueish colors are instantly picked up and drawn on top of the preview image. This immediate feedback lets us play with different objects and quickly get an idea about which objects have the greatest color impact as we try to cover the screen.

Try it. The status bar on either side of the screen grows as colors are picked up, showing us how much pixel real estate each player owns. Individual scores are compared with the total number of available pixels. If 50 percent of all pixels are grabbed by the red player, for instance, the red progress bar covers half of the screen height. Once more than 50 percent of all available pixels are taken, the sketch calls a winner and fades to the winning color. It resets the game to start over.

This game has taken us deep into the world of pixels using all the prior color knowledge we've acquired in <!-- ref linkend="sec.color.mixer" -->. The ```PImage``` datatype is a convenient way to work with images, which are in principle &lquot;just&rquot; lists of colors containing red, green, blue, and alpha (transparency) values that we can use for our own purposes, such as our magic marker drawing game.

If your device is up to the challenge, feel free to double the camera resolution via ```camWidth``` and ```camHeight``` for better image quality, but consequently you'll have to lower the frame rate. We've discussed that pixel-level calculations are computationally expensive and hence require a speedy Android device to run smoothly. In <ref linkend="chp.mobile.3d" />, we will learn a few tricks that help us put the graphics processing unit (GPU) to use, keeping the central processing unit (CPU) free for other tasks.

Since you've successfully interpreted images on a pixel level, let's take it a step further now and explore how pixel-level image algorithms are used for advanced image processing and computer vision purposes, specifically for Android's face detection API.

###Detect Faces

One of the most amazing hidden features of the camera software is the ability to detect faces. We've seen that access to the pixel values enables us to interpret images and make inferences about their content. Such computer vision algorithms have many applications in robotics, automation, and security. The [Android face detection API][27] is designed to trigger an event when one or more faces are detected.

Facial recognition is an Android feature that uses complex computer vision algorithms to detect typical facial features, which are recognized by their shape and the position of a person's eyes within the camera's field of view. The Android device uses so-called [Haar cascades][28] for face recognition.

The Camera app, for instance, uses this feature to set the focus of the camera on the eyes of a person when taking a photo. Face Unlock added to Ice Cream Sandwich uses face recognition to unlock your device. When you first activate Face Unlock (Security Settings  &mapsto;  Face Unlock), you provide an image of your face and a PIN. The device remembers the shape and other characteristics of your face and uses those metrics to compare it to a live camera image when you unlock the screen. Depending on the amount of available light, this feature works uncannily well.

```Face``` detection is part of Android's ```Camera``` class, exposed by ```KetaiCamera``` so we can use it within the camera apps we develop using the Ketai library. The information we receive about facial features includes the location of the ```leftEye()```, the ```rightEye()```, the ```mouth()```, an individual  ```id``` for each detected face, and a ```score``` of the confidence level for the detection of the face, with a range of ```1..100```. The ability to detect facial features might come as a surprise when we use and expose it. However, modern digital cameras use similar algorithms to auto-set the focus and auto-correct red-eye effects.

The face finder sketch we are writing is based on Android's ```Face``` detection API. For the sketch, we use the camera's preview image and send it to the face detector. It returns an array of faces to us that contains the metrics of individual facial features that we can use to draw a rectangle where a face is detected. We test the app on the device, point the Android camera to a web page that displays the results of a Google Image search on the term &lquot;faces.&rquot; This way we can see how well the detection works when it has to respond to a variety of faces of different scales and quality. Let's take a look.

[27]: http://developer.android.com/reference/android/hardware/Camera.Face.html
[28]: http://en.wikipedia.org/wiki/Haar-like_features

<!-- images/Camera/FaceFinder.png -->

#####Figure 5.7 — Face Finder app.
######The image illustrates Android's Face Detector API, which here displays fourteen faces found by an image search engine. The API does not recognize faces shown in side profiles or cropped portraits.

######code/Camera/CameraFaceFinder/CameraFaceFinder.pde
[include](code/camera/CameraFaceFinder/CameraFaceFinder.pde)

Let's take a look at the face finder methods used by the sketch.

1. Create an array to store the list of faces found. It contains the *x* and *y* location of each face and the distance between the eyes.
2. Center the rectangles that mark found faces around their center points.
3. Turn off the fill color for the green rectangle markers so we can see though them.
4. Check the boolean that lets us turn the face finder on and off.
5. Call the ```findFaces()``` method in the ```FaceFinder``` class with the two parameters for the image input (```cam```) and the maximum number of faces to be found (```20```).
6. Parse the results returned from the ```faces``` array. The array length varies by the number of faces that are found, so we check how often to iterate through the array by testing ```faces.length``` with the *for* loop.
7. Draw a rectangle based on the returned face ```location``` ```PVector```. Use ```.x()``` and ```.y()``` to access the horizontal and vertical positions of the face location.
8. Use twice the ```distance``` between the eyes to draw an approximate rectangle marking the detected face.
9. Display the total number of faces found; a maximum of ```20``` can be found based on our ```findFaces()``` settings.

Let's give it a try.

###Run the App

Run the app and set the device aside. Now go to your PC and do a Google image search on the word &lquot;face.&rquot; Pick up the Android and aim the camera at the PC display. Google displays a grid of images showing a wide range of faces at different exposures and angles. Now tap the screen to start face detection. You immediately experience a performance hit caused by the face detection algorithm. We've instructed ```findFaces``` to extract up to twenty faces from the camera's preview.

Once the camera has a clear and steady shot of the faces on the PC display, you can see on the Android screen where green rectangles are overlaid onto the detected areas, as illustrated in <!-- ref linkend="fig.face.detection" -->. Overall it does a pretty good job. When portraits are cropped or only show faces in profile, the algorithm doesn't consider it a face. To confirm this rule, do a Google search on the term &lquot;face profile&rquot; and see what happens. Finally, see what &lquot;cartoon face&rquot; will produce. Using these different search strings helps us to understand what the algorithm requires to interpret a certain pixel area as a face.

Let's move on to the detection of moving human subjects. Use ```setCameraID(1)``` just before ```cam.start();``` in ```setup``` to switch to the front-facing camera. Run the app again, and test the face detection algorithm on your own face. You should observe that the face detection feature begins to work as soon as you face the camera. You need to keep enough distance so your face doesn't appear cropped in the camera preview. If you turn your head to present a profile to the camera, your face won't be detected anymore because the camera can't &lquot;see&rquot; both of your eyes.

We haven't looked deeply into what the Face API does exactly to extract faces from a list of pixel values, and in this case, we don't need to. Android provides us with a list of faces, the midpoint between the eyes, and their distance. Edge detection and decision trees are the concern of the API. Clearly, this feature, which ships with all current Android devices, can be used for different purposes.

Unlike social media sites that employ face detection algorithms to match a person or identity with an image, the Android is not concerned about that. If we start up face detection in our app, the Android OS will trigger a face event when it &lquot;sees&rquot; a face, whether or not it knows the identity of that person. For some of your apps, it can be relevant to know whether a person is looking at the screen or not.

Now that you are aware of this feature, it's up to you to use it or look at your device from now on with the level of scrutiny this feature calls for. The face detection project is a good example of why we need to ask for permission to use the ```CAMERA``` (<!-- ref linkend="sec.sketch.permissions" / -->). If we do, the user is prompted to grant or deny this request. Once granted, the app will retain the permission certificate to use the camera, and we won't be prompted any more. In <!-- ref linkend="sec.gaze.rotation" / -->, we'll use the face detection feature to rotate a 3D object based on how we look at the screen. It is one example of where the face detection API serves as an interactive user interface within a 3D environment.

###Wrapping Up

In this chapter, you've learned how to work with the cameras on Android devices. You've also learned how to display the images the cameras acquire, how to save them, and how to work with them when they're stored in memory. You're now able to manipulate images down to the pixel level, use the camera to detect colored objects in motion, and display their paths on the screen. You've also learned how to activate and use Android's face recognition feature.

This completes our investigation of a diverse range of sensors found on Android devices. You know how to interact with their touch screens and how to determine their orientation and bearing as well as their motion and geographic location. You can also take pictures with the Android and start to make sense of what the device is seeing. You're ready now to move on to the second part of this book, where we'll learn how to network the Android with PCs and other mobile devices and work with large amounts of data.