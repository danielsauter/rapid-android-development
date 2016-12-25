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

* *

[5]: http://ketai.org/reference/cv/ketaisimpleface/
[6]: http://developer.android.com/reference/android/media/FaceDetector.Face.html