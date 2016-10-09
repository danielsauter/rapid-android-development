###Chapter 1

#Getting Started

This book explores the cutting-edge hardware and software features that are built into Android phones and tablets today. You'll create sophisticated graphics and user interfaces in no time, and you'll develop a range of projects that build on the hardware sensors, cameras, and networking capabilities of your Android device. You'll put them to work creatively to make your Android apps more useful, usable, and exciting. We'll consider Android phones and tablets as universal sensors, processors, and remote controls in the context of this book, and we'll create projects that go beyond the typical app. Along the way, we'll spark new app ideas for you to explore in the future.

You'll learn how to create advanced Android apps using Processing, a widely popular open source programming language and environment that is free to use and was designed for learning the fundamentals of programming. With more than 130 libraries expanding the Processing core, as well as the possibility to extend it with Java and Android classes and methods, it is a simple yet powerful language to work with. Processing comes with three modes that let you create applications for different devices and operating systems:  Java mode lets us create standalone applications for GNU/Linux, Mac OS X, and Windows.  Android mode in Processing enables us to create apps for Android phones and tablets---we'll use this mode throughout the book. And finally, JavaScript mode enables us to create web apps, and those will run in all HTML5-enabled web browsers installed on smart phones, tablets, and desktop computers.

Processing's simple syntax lets you write apps whose sophisticated displays belie the straightforward, readable code in which they're written. Initially developed to serve as a software sketchbook for artists, designers, and hobbyists and to teach the fundamentals of computer programming in a more visual way, Processing is one of the most versatile production environments on the market today.

In 2010, the case for programming with Processing became even stronger with the addition of the Android mode to the Processing environment, whose intent, in the words of the Processing all-volunteer team, is to make it foolishly easy to create Android apps using the [Processing API.][1]

In this chapter, we'll begin by installing the software tools we'll need, and then we'll take a look at the basic structure of a typical Processing program, known as a sketch. We'll write our first Android sketch, one that draws figures on our desktop screen. Then we'll switch to [Android mode](#run-sketch-android-emulator) without leaving the Processing IDE and run that same app on the built-in Android emulator. Finally, we'll load the sketch onto an actual Android device and run it there.

With an understanding of the basic development cycle in hand, we'll learn [how to use the touch screen interface](#introducing-android-touch-screen) to add some interactivity to our sketch. We'll explore how it differs from a mouse pointer and make use of touch screen values to change the visual properties of the app, first with gradations of gray and then with color.

In addition to the traditional RGB (red, green, and blue) values that most programmers are familiar with, Processing provides additional color modes that provide greater control over hue, saturation, and brightness (HSB). As we work on our first apps, we'll take a closer look in particular at the HSB mode, which delivers all three.

Throughout the chapter we'll work with simple code that uses the Android touch screen sensor interface to change the position, color, and opacity of the 2D graphics it displays. Let's jump right in and install the software we need to develop Android apps in Processing.

[1]: http://wiki.processing.org/w/Android

###Install the Required Software

Let's get started and download the software we'll need to develop Android apps. The Processing download comes in a fairly small package of approximately 165 MB. It consists of free open source software and is available from the Processing website without prior registration. For workshops, in the lab, in an office, or in a teaching environment where multiple machines are in use, the lightweight Processing development environment (or "Processing IDE") is a good alternative to a full-featured integrated development environment (IDE) such as [Eclipse.][2]

The Processing IDE supports some of the advanced syntax highlighting and autocomplete features for which [Eclipse is valued.][3] Additionally, professional programmers appreciate the Processing IDE for its quick install. It comes with all the necessary tutorials and example sketches that allow us to explore specific programming topics right away. Processing does not require installation; just extract the application file and start.

[2]: http://en.wikipedia.org/wiki/Integrated_development_environment

[3]: http://wiki.processing.org/w/Eclipse_Plug_In

###What You Need

To implement the projects in this book, you'll need the following tools:

* [Processing 3.0][4] (current pre-release is 3.0a5)
* [Java 1.7 (or "Java 7")][5]
* [Android 4.0 Ice Cream Sandwich][6] (5.0 Lollipop is the current Android version, however 2.3 Gingerbread is sufficient for all projects except {{ book.chapter7 }}, and {{ book.chapter8 }}.)

*These are the minimum software requirements. If you have a newer version, you'll be just fine*. Later we'll install some additional libraries that give us easier access to the features of an Android device. For now, use the following steps to build the core Processing environment we'll use throughout this book.

[4]: http://processing.org/download/

[5]: http://java.com/en/download/

[6]: https://developer.android.com/studio/index.html#Other

###Install Processing for Android

Here are the steps to install Processing for the Android.

1. Download Processing 3.0 for your operating system (OSX, Windows, or Linux) at [Processing.org/download][4]. The Processing download includes the Processing IDE, a comprehensive set of examples and tutorials, and a language reference. The Processing package does not include the Android software development kit, which you'll need to download separately.

2. [Extract the Processing][7] application from the ```.zip```file on Windows, ```.dmg``` file on Mac OS, or ```.tar.gz``` file on Linux, and move it to your preferred program folder (for example, Applications if you are developing on OSX, ```Program Files``` on Windows, or your preferred ```/bin``` folder on Linux).

[7]: http://processing.org/learning/gettingstarted/

###Install the Android SDK

1. Find and download the  Android SDK by going to http://developer.android.com/sdk/. Choose the package that's right for your operating system and complete the [installation of the Android SDK.][8] On Windows, you may wish to download and use the installer that Android provides to guide your setup. If Java JDK is not present on your system, you will be prompted to [download and install it.][9]

[8]: http://developer.android.com/sdk/installing.html

[9]: http://docs.oracle.com/javase/7/docs/webnotes/install/

2. When the Android SDK download is complete, go to the Processing wiki at http://wiki.processing.org/w/Android#Instructions and open the Android installation instructions you'll find there. Follow the instructions for your OS step by step. The wiki lists which components are required to configure Processing for Android on your operating system and tells you how to get Android installed properly. Android may have dependencies that are specific to your operating system, such as additional device drivers. If you are developing on Windows, follow the USB driver installation instructions available at http://developer.android.com/tools/extras/oem-usb.html. If you are developing on Linux, follow the instructions for setting up your device for development at http://developer.android.com/tools/device.html#setting-up.

Now that you have installed all the necessary components to develop Android apps on your own system, let's jump right into Processing and write our first sketch.

###Write Your First Android Sketch

Go ahead and launch Processing from the applications directory. The Processing IDE launches, opening an empty sketch window, as shown in Figure 1, The Processing IDE, below.

<!-- MISSING IMAGE HERE -->

#####We edit Processing code directly within the Processing IDE sketch window, as shown here.

Since you've launched the application for the first time, Processing has just created a sketchbook folder for you, which is located in ```Documents``` on the hard drive, independent of the OS you are developing on. I recommend you save all your sketches to this location. Then Processing can list them for you within the IDE (click the "Open..." toolbar button). Also, when you update to future versions of Processing, the sketchbook loads up exactly the same way as before.

###Explore the Processing IDE

The toolbar on top of the sketch window contains the key features of the IDE, with a Run button to launch and a Stop button to stop your apps. You can find a more detailed description of the sketchbook and the IDE in the [Processing Development Environment tutorial][10] on the Processing website.

* *Java mode* Run button in sketch window
* *Android mode* Run button in sketch window
* *Android mode* Export button in sketch window
* *JavaScript mode* Export button in sketch window
* *JavaScript mode* Run button in sketch window

When you start Processing for the first time, it defaults to Java mode, as indicated on the right side of the toolbar. This area also functions as a drop-down menu, allowing us to switch between the different modes the Processing IDE provides. You'll need to add the Android mode, choosing "Add mode…" from the menu. Depending on which mode you’ve selected, the Run button on the toolbar produce different results, which are listed next.

* *Java mode* "Run" displays a program window to view the sketch running on the desktop computer.
* *Android mode* "Run" launches the app on the Android device. "Export" creates a signed Android package for Google Play.
* *[JavaScript mode][11]* "Run" launches a web page in the default browser, with a Processing JavaScript canvas showing the sketch. "Export" creates a web package, including all dependent files for uploading to a web server.

A tab below the toolbar shows the current sketch name, which defaults to one containing the current date if the sketch has not been saved yet. Processing prompts us to provide another filename as soon as we save the sketch. The right-arrow button to the right of the tab allows us to add more tabs if we'd like to split the code into separate sections. As sketches grow in scope and complexity, the use of tabs can be a great way to reduce clutter by separating classes and methods for different purposes into distinct tabs. Each tab is saved as a separate Processing source file, or ```pde```, in the sketch folder.

The text editor, shown in white below the tab in the image above, is the actual area where we write and edit code. The line number of our current cursor location within the code is shown at the very bottom of the sketch window.

The message area and console below the text editor provide us with valuable feedback as we develop and debug.

You can always find more information on the key IDE features discussed here, as well as a summary of the installation, on the Learning page of the [Processing website.][7]

[10]: http://processing.org/reference/environment/

[11]: http://processing.org/learning/javascript/
