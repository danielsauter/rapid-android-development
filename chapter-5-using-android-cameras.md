###Chapter 5:
#Using Android Cameras

Now that we've learned to work with several of the most important Android sensors, let's take a look at another device that's found on every Android phone and tablet—the digital camera. Your device includes at least one and sometimes two cameras: the back-facing camera, which you commonly use to take high-resolution pictures and capture video, and the front-facing camera, designed for video calls and chat at a lower resolution. The digital camera can also be used as a sophisticated light-sensitive sensor to build a  variety of interactive applications that go beyond pictures and video clips. We'll explore each of these uses and more in this chapter.

We'll start with the back-facing camera and learn how to display what it &lquot;sees&rquot; as an image on the Android screen. Next we'll learn how to switch between the front- and back-facing cameras found on most devices and add a feature that allows us to save their images to the Android's [*external storage*][1] which is a default public location on the device that can be read by other apps. Depending on the device settings, this can be located on an SD card, in internal storage, or on media mounted over the network. To make it easier to use these features, we'll add a few UI buttons to initiate each task.

Once we have stored an image from a camera, we may want to make further use of it. Additional APIs allow us to stack stored images to create a composite image that consists of a foreground and a background. We'll put this functionality to work by building a photo booth app, where we will create a fake backdrop and superimpose a snapshot on it.

But there's more. The Processing language also provides us with APIs that we can use to analyze the content of the images that we capture at the pixel level. We'll use that capability to build a game that can detect the color of a moving object&emdash;red or blue&emdash;and display the pattern of its motion on the device screen. To make the activity into a game, two players will compete to fill the screen by waving colored objects above it. The first to fill more than 50 percent of the screen wins. In building the game, we'll get to know the Processing ```PImage``` class, which allows us to manipulate images and work directly with pixel values.

Finally, we'll end the chapter with a brief look at Android's built-in face recognizer. This lesser-known camera feature is made possible by computer vision algorithms and the increased processing power that's finding its way into Android devices. Android provides a face-finder API that uses pixel-level image analysis to make inferences about what's going in the device's field of view. We'll demonstrate its use with a brief example.

Before we get started on our first project, let's first take a look at some of the camera features and classes we'll be using throughout the chapter to build our camera apps.

[1]: http://developer.android.com/guide/topics/data/data-storage.html#filesExternal

###Introducing the Android Camera and APIs

Android phones and tablets are typically equipped with two cameras. Camera hardware varies across phones and tablets, but typically the back-facing camera is used to capture images and HD video at a resolution of 5 mega-pixels. The lower-resolution, front-facing camera is designed for video calls. The Google Nexus 6 phone, for example, features a 13-megapixel back-facing camera (4160 x 3120 pixels) with a built-in LED flash and a 2-megapixel front-facing camera.

Mobile cameras don't rely on hardware alone. The Android SDK provides a variety of features through its ```Camera``` class that make the camera more than just a [camera.][2] We can use code to work with camera metering, focus, exposure, white balance, zoom, image capture, and even face detection. Geolocation data can also be added to image metadata so that images can be organized by the location where they were taken. The Google Camera app that ships with Android devices allows users to manipulate those features in its UI. But we're going to learn how apps can use them as well.

To implement the camera features in this chapter, we'll work mainly with a single Ketai library class and a highly versatile Processing type:

[```KetaiCamera```][3]
This Ketai library class provides simplified access to the cameras on a device by making Android's ```Camera``` class available to Processing. When we work with ```KetaiCamera```, we define the width, height, and frame rate for the camera preview we'd like to work with. It provides the necessary methods to define basic camera settings (such as resolution) and camera controls. It also provides access to the camera flash and Android's built-in face recognizer. 

[```PImage```][4]
This is a Processing datatype for storing images (```gif```, ```jpg```, ```png```, ```tif```, and ```tga```). It provides a number of methods that help us load, save, and filter  images, including access to the image ```pixels[]``` array that contains information on pixel color values. The methods we are using in this chapter are described further in <!--ref linkend="sec.pimage" /-->.

Now let's take a closer look at the ```KetaiCamera``` methods we'll be using.

[2]: http://developer.android.com/guide/topics/media/camera.html
<!-- Need to reconcile second link for this 2: http://developer.android.com/reference/android/hardware/Camera.html -->
[3]: http://ketai.org/reference/camera/
[4]: http://processing.org/reference/PImage.html

###Working with the KetaiCamera Class

Besides providing the typical ```start``` and ```stop``` methods that we use to control the sensors on a device, we'll use the following more specialized ```KetaiCamera``` methods for the projects in this chapter:

* *```onCameraPreviewEvent()```* Returns a preview image from the camera when a new frame is available&emdash;the image can then be read into the ```KetaiCamera``` object using the ```read()``` method.

* *```addToMediaLibrary()```* Makes a picture publicly available in the default preferred media storage on the device&emdash;the method requires a picture filename or path to the picture. After using the method, pictures are also available as an album in the Gallery app.   

* *```manualSettings()``` and ```autoSettings()```* Toggles between manual and automatic camera settings&emdash;```manualSettings()``` locks the current camera exposure, white balance, and focus. ```autoSettings()``` lets the device adjust exposure, white balance, and focus automatically.

* *```enableFlash()``` and ```disableFlash()```* Switches the built-in rear-facing camera flash on and off&emdash;this can only be used if the rear camera is on.

* *```savePhoto()```* Saves a picture in the current camera preview size to the preferred media storage

* *```setPhotoSize()```* Sets the picture's size to be saved in a different, for example, higher, resolution

* *```setSaveDirectory()```* Defines where to save the pictures to&emdash;by default, pictures are saved to the public media storage on the device. The path can also be set to another destination, including private folders. Requires testing whether the directory path is valid.

* *[```KetaiSimpleFace()```][5]* A Ketai wrapper for the ```Face``` class in [Android's ```FaceDetector``` package][6], which returns the midpoint location and distance between the eyes recognized by the device cameras

* *```KetaiSimpleFace[]```* A ```PVector``` list containing the position data of detected faces within a camera image&emdash;the center point between the left and right eyes and the distance between the eyes are stored in this array.

With this brief summary of ```KetaiCamera```methods for this chapter, let's get started with our first camera app.

[5]: http://ketai.org/reference/cv/ketaisimpleface/
[6]: http://developer.android.com/reference/android/media/FaceDetector.Face.html

###Display a Back-Facing Camera Full-Screen Preview

For this initial camera app shown below, we'll display the view seen by the back-facing Android camera.

<!-- imagedata fileref="images/Camera/GettingStarted.png" width="90%" -->

#####Figure 5.1 — Camera preview app.
######The illustration shows a camera preview image at a resolution of 1280 x 768 pixels, displayed on the touch screen of a Google Nexus 6, whose resolution is 2560 x 1440 pixels. 

We'll use the ```KetaiCamera``` class to connect to and start the camera. The ```KetaiCamera``` class streamlines this process significantly for us. For example, creating a simple camera preview app using ```KetaiCamera``` takes about ten lines of code, compared with about three hundred documented on the [Android developer site.][7] ```KetaiCamera``` helps us set up and control the camera, and it also [decodes][8] the YUV color format provided by the Android camera into the RGB format used in Processing.

```KetaiCamera``` works similarly to other Ketai classes that we've explored in <!-- titleref linkend="chp.sensors" -->. First we create a ```KetaiCamera``` object and ```start()``` the camera. Then we update the screen as soon as we receive a new image from the camera via ```onCameraPreviewEvent()```. And finally, we use Processing's own ```image``` method to display the camera preview.

The code for a basic camera sketch looks like this: 

#####code/Camera/CameraGettingStarted/CameraGettingStarted.pde

<!-- CODE -->

Let's take a closer look at the steps you take and the methods you use to set up a camera sketch.

1. Create an instance of the ```KetaiCamera``` class to generate a new camera object with a preview width and height of 1280 x 768 pixels and an update rate of 30 frames per second.

2. Call ```imageMode()``` to tell Android to center its camera images on its screen. All images are now drawn from their center point instead of from the default upper left corner.

3. Display the camera preview using the [```image()``` method][9]. It requires an image source as well as the ```x``` and ```y``` coordinates of the image to display. Optionally, the image can be rescaled using an additional parameter for the image ```width``` and ```height```, which is what we are doing here.

4. Use the ```onCameraPreviewEvent()``` callback method for notification that a new preview image is available. This is the best time to read the new image.

5. Read the camera preview using the ```read()``` camera method.

6. Toggle the camera preview on and off when you tap the screen.

Let's try the sketch on the Android phone or tablet.

[7]: http://developer.android.com/samples/Camera2Basic/project.html
[8]: https://en.wikipedia.org/wiki/YUV#Conversion_to.2Ffrom_RGB
[9]: http://processing.org/reference/image_.html

###Run the App

Before we run the sketch, we need to give the app permission to use the camera. Here's how: On the Processing menu bar, select  Android  &mapsto;  Sketch Permissions.  In the Android Permissions Selector that appears, select Camera. As we've done already in <!-- titleref linkend="chp.geolocation" --> earlier in <!-- ref linkend="sec.sketch.permissions" -->, the Android must allow the app to use the camera through a certificate, or it must prompt the user to approve the request to use the camera. If the app has permission to use the camera, the device will remember and not prompt the user anymore. For this app, we only need to check the permission for ```CAMERA```.

Now run the sketch on the device. The rear-facing camera preview starts up as illustrated in <!-- ref linkend="fig.camera.getting.started" / -->, in a [resolution of 1280px width and 768px height][10], known as WXGA. Android cameras are set to auto mode, so they adjust focus and exposure automatically. Depending on your phone's native screen resolution, the preview image might cover the screen only partially. You can certainly scale and stretch the preview image, which also changes the image aspect ratio and distorts the image. For instance, if you set the width and height parameters in the ```image()``` method to ```screenWidth``` and ```screenHeight``` as in the following code, the camera preview will always stretch full screen independent of the screen's size and resolution. 

```
image(cam, width/2, height/2, width, height);
```

Go ahead and try the fullscreen mode on your device. For a preview image in a camera app, it doesn't seem like a good idea to stretch the image, though. When we write apps that scale seamlessly across devices, we typically lock and maintain aspect ratios for images and UIs.

As we can see in the code <!--xref linkend="code.camera.getting.started" -->, the steps we take to get the camera started are like the steps we took working with other sensors (<!-- titleref linkend="chp.sensors" -->). First we instantiate a ```KetaiCamera``` object using a defined ```width```, ```height```, and ```frameRate```. Then we start the camera. And finally, we read new images from the camera using ```onCameraPreviewEvent()``` and display them. The frame rate in this sketch is set to 30 frames per second, which is the typical playback speed for digital video, giving the appearance of seamless movement. Depending on your device and image conversion performance, the image preview might not be able to keep up with the designated thirty previews per second. In that case, the sketch will try to approach the set frame rate as best it can. 

With less than ten lines of code added to the typical processing sketch methods, we've completed our first camera app. The ```onPause``` and ```exit``` methods are responsible for releasing the camera properly when we pause or exit the app. The methods make sure that other apps can use the cameras and that we don't keep them locked down for our app alone. You can only have one active connection to the cameras at a time.

[10]: http://en.wikipedia.org/wiki/Display_resolution

###Toggle Between the Front- and Back-Facing Cameras

Most mobile Android devices come with both the front-facing and back-facing cameras. We need a UI button that toggles between the front and back camera. Let's also activate the flash that's built into most back-facing cameras and add an additional pair of button controls to start and stop the camera. The final app then looks like this:

<!-- images/Camera/FrontBack.png -->

#####Figure 5.2 — Camera preview app with UI.
######The UI added to the Preview app allows users to start and stop the cameras, toggle between the front- and back-facing cameras, and activate the built-in flash.

Android lists all built-in device cameras and allows us to pick the one we'd like to work with. For instance, the Nexus 6 uses the camera index ID ```0``` for the back-facing camera and  ```1``` for the front-facing camera. Future Android devices might add more cameras to the device, potentially for 3D applications, so having an enumerated list enables Android OS to incorporate them.

Let's build on the previous sketch <!-- ref linkend="code.camera.getting.started" -->, adding some camera controls that will remain pretty much the same throughout the chapter. Because this sketch is longer than the previous one, we'll separate it into two tabs: a main tab containing the essential ```setup``` and ```draw``` methods, which we'll name ```CameraFrontBack``` (identical to the sketch folder), and a second tab, which we'll call ```CameraControls``` and will contain the methods we need to ```read``` the camera preview,  the methods to ```start``` and ```stop``` the camera, and the UI buttons we'll use to control the camera via the touch screen.

Separating the code this way helps us reduce complexity within the main tab and focus on relevant code for the projects we are working on. We'll store each tab in its own Processing source file, or ```pde``` file, inside the sketch folder. You can always check what's inside your sketch folder using the menu  Sketch  &mapsto;  Show Sketch Folder, or the shortcut *```K```*. 

Let's first take a look at the main tab:

#####code/Camera/CameraFrontBack/CameraFrontBack.pde

In the main ```CameraFrontBack``` tab, we've added new features.

