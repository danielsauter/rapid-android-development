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

Let's get started and download the software we'll need to develop Android apps. The Processing download comes in a fairly small package of approximately 165 MB. It consists of free open source software and is available from the Processing website without prior registration. For workshops, in the lab, in an office, or in a teaching environment where multiple machines are in use, the lightweight Processing development environment (or Processing IDE) is a good alternative to a full-featured integrated development environment (IDE) such as [Eclipse.][2]

The Processing IDE supports some of the advanced syntax highlighting and autocomplete features for which [Eclipse is valued.][3] Additionally, professional programmers appreciate the Processing IDE for its quick install. It comes with all the necessary tutorials and example sketches that allow us to explore specific programming topics right away. Processing does not require installation; just extract the application file and start.

[2]: http://en.wikipedia.org/wiki/Integrated_development_environment

[3]: http://wiki.processing.org/w/Eclipse_Plug_In

###What You Need

To implement the projects in this book, you'll need the following tools:

* [Processing 3.0][4] (current pre-release is 3.0a5)
* [Java 1.7 (or Java 7)][5]
* [Android 4.0 Ice Cream Sandwich][6] (5.0 Lollipop is the current Android version, however 2.3 Gingerbread is sufficient for all projects except {{ book.chapter7 }}, and {{ book.chapter8 }}.)


[4]: http://processing.org/download/

[5]: http://java.com/en/download/

[6]: https://developer.android.com/studio/index.html#Other

<!--
#run-sketch-android-emulator
#introducing-android-touch-screen
-->
