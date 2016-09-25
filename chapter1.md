# Preface

[Processing][1] is a favorite among artists and designers and widely popular among developers who look for a productivity edge. The programming language and environment has developed from a sketching tool to a production environment for a range of operating systems and platforms. The Android mode, introduced to Processing with the release of version 2.0, now makes it as easy to develop Processing apps for the Android as for the desktop.

Initiators Ben Fry and Casey Reas have promoted software literacy since 2001 using Processing, a free open source tool that can be used by individuals at any level of programming experience. The Processing project thrives on the support of its generous online community, whose members encourage collaboration and code sharing and are responsible for one of Processing's most important features: its libraries.

Libraries have made Processing the versatile and capable coding environment that it is today. Members have contributed more than 130 libraries to Processing over the last decade. I have extensively used Processing in the classroom during the past eight years and have realized various projects with it, sometimes in conjunction with Processing's sister project, [Arduino][2].

In 2010, I started the [Ketai][3] (the Japanese term for cell phone culture) library with Jesus Duran, which brings Android hardware features to Processing and makes it possible to work with sensors and hardware devices using simple and easy-to-read code.

In comparison, developing Android apps in Java using the standard [Eclipse IDE][4] entails a much steeper learning curve, one that requires a programmer to master both the syntax of a modern object-oriented language and the features of a complex development environment. In Processing, we can see results immediately because we are working with a straightforward syntax and a wide range of libraries and tools designed specifically to support visually lavish and highly interactive applications.

Android users expect a rich, interactive mobile user experience from their phones and tablets, one that takes full advantage of their touch screens, networking hardware, sensors for geolocation and device orientation, built-in cameras, and more. In this book, we'll learn how to create apps for Android devices that take full advantage of their many built-in hardware affordances.

[1]: http://processing.org/
[2]: http://arduino.cc/
[3]: http://code.google.com/p/ketai/
[4]: http://developer.android.com/sdk/eclipse-adt.html

###Introducing Processing for the Android

Android is based on the Java programming language. Processing is also based on Java, making it the perfect platform for developing Android apps using Processing's straightforward syntax. The addition of the Android mode was a natural progression for Processing in order to streamline application development while targeting a broad range of operating systems and devices with one comprehensive programming language. In fact, Processing's software architecture allows us to mix in Java statements and packages, Android statements and packages, and Processing sketches and libraries wherever we feel like it.

This book focuses on Android apps developed in Processing. There are no differences between the Android mode and Processing's Java mode for desktop applications when it comes to the basic programming structure and syntax. Android-specific features that require device sensors and hardware are not available on the desktop and therefore are not usable in Processing's Java mode. They are available, however, as soon as we switch to Android mode.

In the last chapter of the book we'll discuss cross-platform challenges for mobile apps and introduce Processing's JavaScript mode. HTML5 web apps developed in Processing run on all modern browsers found on smart phones, tablets, and desktops today. While interoperability is an important factor, we will limit our discussion of web apps to the last chapter, as we can't access many of the hardware sensors and devices that make for exciting apps.

All core Processing methods are identical across modes, so when we develop Android apps we can also consider and use code examples written for Java mode. The Processing website contains a [complete reference][5] for all Processing methods. So does the IDE, which ships with a packaged reference that we can use without a connection to the Web; it's available from the Processing menu by selecting Help &mapsto; Reference.

**Let's take a look at some of the main advantages to developing Android apps in Processing:**

* If you are new to programming, Processing for Android is much easier to learn than Java. If you are an experienced Java programmer already, Processing is a great programming environment for rapid prototyping of graphics and sensor-heavy apps.

* Processing uses straightforward syntax. [In comparison to Java,][6] it is more concise. Processing doesn't require you to understand advanced concepts such as classes or screen buffering to get started, yet it makes them accessible to any advanced users who want to use them. This makes Processing programs shorter and easier to read.

* The lightweight programming environment installs quickly and is easy to use. Processing is available for GNU/Linux, Mac OS X, and Windows. If you work with multiple computers or want to help someone else get started quickly, being up and running in a few minutes can make all the difference.

* Processing for Android supports [OpenGL.][7] When working with GPU-accelerated 2D and 3D graphics and geometry, lights, or textures, comprehensive OpenGL support is essential to ensure reasonably high frame rates and a fluid user experience.

* The latest version of Processing supports three application environments, or modes. Applications written in Java mode will run on Linux, Mac, or Windows systems. Programs written in Android mode will run on Android devices, and those written in JavaScript mode will run in any HTML5 browser. The Android mode is designed for creating native Android apps.

* Once your sketch prototyping is done, you can easily move your work to Eclipse for debugging and deployment. Processing lets you export your sketches as Android projects in the File &mapsto; Export Android Project menu, creating an android directory with all the necessary files in it.

This list of advantages should provide you all the evidence you need to conclude that Processing is a great environment for developing Android apps. Your projects can scale in scope and context: from sketch to prototype and from prototype to market-ready application, from CPU-focused graphics rendering to hardware-accelerated GPU-focused rendering, from Processing statements and libraries to Android and Java statements and packages, and from a particular operating system and device to other operating systems and devices. You won't need to worry about a different last-minute route or an alternative solution for your software projects. Projects can grow with you and will let you enjoy the iterative process of design and development.

[5]: http://processing.org/reference/
[6]: http://wiki.processing.org/w/Java_Comparison
[7]: https://www.opengl.org

###Who This Book Is For

The book is written for the following readers:

* **Readers with some programming experience:** Readers with a basic understanding of programming concepts can quickly learn the Processing language as they work their way through the examples. Processing is that easy to learn.

* **Intermediate Processing users:** Readers looking to create Android apps from within the Processing IDE can maintain a good balance between simplicity and versatility.

* **Educators who teach courses on mobile technologies:** Teachers often navigate the academic triangle of limited time, limited budget, and classes without prerequisites. This book brings advanced mobile features within the reach of students with little or no prior programming experience using a free tool that does not require developer licenses or subscriptions.

* **Java and Android developers:** Experienced developers look for a productivity gain. Because Processing builds on Java, developers can use their Java code and knowledge with Processing, leveraging a host of libraries for productivity gains.

* **JavaScript and web developers:** Processing.js syntax is identical to standard Processing syntax, making it easy to create JavaScript-powered web applications that can run inside browsers without plugins or other modifications. Processing.js also takes advantage of WebGL hardware acceleration.

* **Arduino users and hobbyists:** Some readers have experience with the Processing language by using it to program the Arduino electronics platform and are interested in adapting Android phones or tablets for use as sensing devices, controllers, or graphics processors.

###Prerequisites

If you have never programmed in Processing or any other language before, you can turn to two excellent sources to get you up to speed; I've listed them at the end of this paragraph. You need to have an idea of the basic principles of programming to fully enjoy the book, such as the use of variables, conditionals, and loops. If you feel a little shaky with any of those concepts, I recommend you get one of the two books and keep it close by for frequent consultation. If you have scripted or programmed before, even if only at a basic level, you should be able follow the examples in this book with a close read.

***Getting Started with Processing (Reas and Fry)***<br/>
[This casual, inexpensive book is a concise introduction to Processing and interactive computer graphics.][8] Written by Processing's initiators, it takes you through the learning process one step at a time to help you grasp core programming concepts.

***Processing: A Programming Handbook for Visual Designers and Artists, Second Edition***<br/>
[This book is an introduction to the ideas of computer programming within the context of the visual arts.][9] It targets an audience of computer-savvy individuals who are interested in creating interactive and visual work through writing software but who have little or no prior experience.

[8]: http://shop.oreilly.com/product/0636920000570.do
[9]: http://mitpress.mit.edu/books/processing-1

###What's in This Book

This book will have you developing interactive sensor-based Android apps in no time. The chapters include previews of all the classes and methods used for the chapter projects, as well as a description of the particular sensor or hardware device that we'll be working with. Small projects introduce the basic steps to get a particular feature working, which leads up to a more advanced chapter project.

Part I of the book gets you started with the touch screen and Android sensors and cameras. **link>chp.getting.started**, walks you through the steps of installing Processing and the Android SDK. We'll write a simple app and run it in the emulator and on an Android device. **link>chp.display**, will show you how to use mouse position, finger pressure, and multitouch gestures on the touch screen panel while also providing details on the support for color that Processing provides. **link>chp.sensors**, introduces us to all the device sensors built into an Android. We'll display accelerometer values on the Android screen, build a motion-based color mixer, and detect a device shake.

In Part II, we'll be working with the camera and location devices found on most Androids. **line>chp.geolocation**, shows us how to write location-based apps. We'll determine our location, the distance to a destination and to another mobile device on the move, and calculate the speed and bearing of a device. **linkend>chp.camera**, lets us access the Android cameras through Processing. We'll display a camera preview of the front- and back-facing cameras, snap and save pictures to the camera's SD card, and superimpose images.

In Part III, we'll learn about peer-to-peer networking. **link>chp.wifi**, teaches us how to connect the Android with our desktop via Wi-Fi using the Open Sound Control protocol. We'll create a virtual whiteboard app, where you and your friends can doodle collaboratively, and we'll build a marble-balancing game, where two players compete on a shared virtual board. **link>chp.p2p**, shows us how to use Android Bluetooth technology to discover, pair, and connect Android devices. We'll create a remote cursor sketch and build a survey app to share questions and answers between devices. **link>chp.nfc**, introduces us to the emerging short-range radio standard designed for zero-click interaction at close proximity and is expected to revolutionize the point-of-sale industry. We'll read and write NFC tags and exchange data between Android devices via NFC and Bluetooth.

Part IV deals with data and storage, as all advanced apps require some sort of data storage and retrieval to keep user data up-to-date. In **link>chp.data**, we'll load, parse, and display data from text files and write data to a text file in the Android storage. We'll also connect to a data source hosted online to create an earthquake app that visualizes currently reported earthquakes worldwide. **link>chp.sqlite**, introduces us to the popular SQLite database management system and Structured Query Language. We'll record sensor data into a SQLite database and query it for particular data attributes.  

Part V gets us going with 3D graphics and cross-platform apps. **link>chp.mobile.3d**, will show us how to work with 3D primitives, how virtual light sources are used, and how cameras are animated. **link>chp.shapes.objects**, deals with 2D vector shapes and how to load and create 3D objects. **link>chp.web.apps**, opens up our mobile app development to a wide range of devices and platforms using the JavaScript mode in Processing. We'll discuss some of the benefits of web apps being able to run on all modern browsers and the range of limitations using built-in device hardware.

###How to Read This Book

The five parts of the book can each be considered self-contained mini-courses that you can jump right into once you have completed Part I, have properly installed all the required software, and are up and running. While the book does progress in a step-by-step fashion from fundamental to advanced subjects, you can jump right into Part II, III, IV, or V if you need to tackle a particular family of sensors or Android features for a current project.

Whenever we undertake a project that builds on prior code, refines an earlier project, or revisits important concepts mentioned earlier in the book, we'll cross-reference those earlier sections accordingly; if you are using the ebook, you can use the link to jump directly to the referenced section.

Throughout our journey in this book, I encourage you to get inspired by the projects in the Processing exhibition http://processing.org/exhibition/, learn from the Processing community (http://forum.processing.org/), use the code examples included in IDE File &mapsto; &lquot;Examples...,&rquot; refer to the online tutorials (http://processing.org/learning/), collaborate with peers (http://sketchpad.cc), and learn from public sources, such as http://www.openprocessing.org/.

###What You Need to Use This Book

For all the projects in this book, you need the following software tools. The first chapter guides you through installing those tools step by step.

* **[Processing 3][10]**
* **[Android 4.0 Ice Cream Sandwich or higher][11]**<br />
(2.3 Gingerbread is sufficient for all projects but *link>chp.p2p*, and *link>chp.nfc*).
* **[Ketai Sensor Library for Processing][12]**
* **[Processing Android installation instructions][13]**

[10]: http://processing.org/download/
[11]: http://developer.android.com/sdk/
[12]: http://ketai.org
[13]: http://wiki.processing.org/w/Android#Instructions

The projects in this book require at least one Android device. To complete Part III, you need two Android devices. This allows us to run and test the sketches on the actual hardware, use the actual sensors, and get the actual mobile user experience that is the focus of this book.

###Tested Android Devices for this Book

The example code for the projects in this book has been tested on the following devices, some shown in *link>fig.tested.devices*:

![](rapid-android-development_p3_0.jpg)
######Tested Android phones and tablets. Clockwise from top left: ASUS Transformer Prime, Samsung Galaxy SIII, Samsung Nexus S, and Google Nexus 7
<br />
* **Asus Transformer Prime Tablet with 32 GB memory** <br/ >(Ice Cream Sandwich, Jelly Bean)
* **Samsung Galaxy SIII** <br />(Ice Cream Sandwich, Jelly Bean, KitKat) 
* **Samsung Nexus S** <br />(Ice Cream Sandwich, Jelly Bean, KitKat) 
* **Google Nexus 7 with 8 GB memory**<br /> (Jelly Bean, KitKat)
* **Google Nexus 6 with 25 GB memory**<br /> (Lollipop)

All the code is available online. Feel free to comment and drop some feedback! 
