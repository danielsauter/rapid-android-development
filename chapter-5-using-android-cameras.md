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

Let's build on the previous sketch <!-- ref linkend="code.camera.getting.started" -->, adding some camera controls that will remain pretty much the same throughout the chapter. Because this sketch is longer than the previous one, we'll separate it into two tabs: a main tab containing the essential ```setup()``` and ```draw()``` methods, which we'll name ```CameraFrontBack``` (identical to the sketch folder), and a second tab, which we'll call ```CameraControls``` and will contain the methods we need to ```read()``` the camera preview,  the methods to ```start()``` and ```stop()``` the camera, and the UI buttons we'll use to control the camera via the touch screen.

Separating the code this way helps us reduce complexity within the main tab and focus on relevant code for the projects we are working on. We'll store each tab in its own Processing source file, or ```pde``` file, inside the sketch folder. You can always check what's inside your sketch folder using the menu  Sketch  &mapsto;  Show Sketch Folder, or the shortcut *```K```*. 

Let's first take a look at the main tab:

#####code/Camera/CameraFrontBack/CameraFrontBack.pde

In the main ```CameraFrontBack``` tab, we've added new features.

1. Print all available device cameras to the Processing console using the ```list()``` method included in ```KetaiCamera```.
2. Set the back-facing camera ID to ```0``` via ```setCameraID()```.
3. Increase the ```textSize()``` for the UI buttons to ```24``` pixels.
4. Call the custom ```drawUI()``` method, taking care of drawing UI buttons.
5. The ```draw()``` method contains only a call to the ```image()``` method, used for displaying the camera preview, and a call to the custom ```drawUI()``` method we defined for our UI elements.

Now let's explore the second sketch tab called ```CameraControls```, where we'll keep all the code that controls the camera.

#####code/Camera/CameraFrontBack/CameraControls.pde

In this ```CameraControls``` tab, we use the following UI elements and camera methods to complete these steps.

1. Display the UI on the screen using a custom ```void``` function called ```drawUI()```. Void functions execute but don't return a value. The UI in this example consists of buttons that use half-transparent rectangles for their backgrounds and text labels for their names.
2. Check if the camera is running using the boolean method ```isStarted()```. If the method returns ```TRUE```, we display &lquot;stop&rquot;; otherwise show &lquot;start.&rquot;
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

Now that we know how to preview and control the camera, it's time to put it to work&emdash;let's snap some pictures. In our next project, we'll learn how to store images on the device.

To snap pictures and save them to the external storage of our device, we'll first need to add a ```savePhoto()``` method to the previous sketch <!-- ref linkend="sec.camera.front.back" -->. The method takes care of capturing the image and writing it to the device's external storage in a folder that bears the app's name. When the photo is written to this public directory on the SD card, we receive a callback from ```onSavePhotoEvent()``` notifying us that the writing process is complete. This callback method is also useful if we'd like to notify the device's media library to make the photos available to other applications, which we accomplish with a call to the ```addToMediaLibrary()``` method. Once we've added photos to the media library, we can browse them in the Gallery&emdash;Android's preinstalled app for organizing pictures and video clips shown in <!-- ref linkend="fig.android.gallery" thispage="yes" -->. The larger the captured photo size, the longer it takes to transfer the image buffer and store it on the disk.

<!-- images/Camera/GalleryAlbum.png -->

#####Figure 5.3 — Android gallery.
######When we take pictures with our camera app and add them to the public external storage, they are available in an album within Android's Gallery.

To refine the camera app UI, let's also add a Save button that allows us to save the image by tapping the touch screen. Some status info on the current camera settings also seems useful.

For the Save feature, we need to modify the ```draw()``` method in the main ```CameraSavingImages``` tab and make some adjustments to ```CameraControls```. The following code snippets show only the modifications to the previous code in <!-- ref linkend="code.camera.front.back" -->CameraFrontBack.pde<!--/xref--> and <!-- xref linkend="code.camera.front.back.controls" -->CameraControls.pde<!--/xref-->. You can also download the complete ```pde``` source files from the book's website, and if you’re reading the ebook, just click the green rectangle before the code listings. 

Let's take a look.

#####code/Camera/CameraSavingImages/CameraSavingImages.pde

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