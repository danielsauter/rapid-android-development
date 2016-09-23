## Reviews

> I highly recommend this book; there is no other text on Processing and Android quite like it on the market. It is extremely exhaustive and well structured, and it avoids the pitfalls of preaching to the converted or assuming too much prior knowledge. It is not a small thing to write for experienced creative coders and n00bs alike. Daniel Sauter clearly knows his stuff.

**Jesse Scott**, Adjunct Faculty, Interaction Design and Smartphone Development, Emily Carr University of Art + Design and Langara College

> _Rapid Android Development_ successfully aims at a wide audience—from beginners to experienced developers. I recommend it to anyone who wants to use Processing to develop Android apps, especially creative coders who will be inspired by the diverse techniques for mobile development that fill this book.

**Andrés Colubri, **Computational Researcher, Harvard University and Fathom Information Design

> Even if you think you know Processing for Android, this book will still teach you something new, be it 3D, data storage methods, or networking techniques. It provides a solid framework from which aspiring Android developers can launch into developing apps, all while being enjoyable to read.

**William Smith**, Moderator, Processing Forum

> Daniel Sauter's _Rapid Android Development_ provides a serious guide to using the platform for creative coding that Processing provides for leveraging the full potential of Android devices. Advanced graphics, gestures and sensors are only the tip of the iceberg, and you will find yourself diving into sophisticated sensor-based applications, games and art-ware, learning a host of techniques for coding and even publishing them in Google’s Play market. This book is invaluable!

**Jesus Duran**,** **Artist, educator, and CTO of Ketai LLC

> Whether used for education, application prototyping or just plain fun, Processing for Android is easy to learn and can produce truly stunning visual results. If you don't have time or interest to learn the intricacies of Android OpenGL, radios and sensor programming, but want to benefit from all the magic that these technologies have to offer, this book provides the shortest and most informative path toward achieving that goal.

**Mike Riley**,** **Author, Programming Your Home

## Foreword

Processing was hand-rolled at MIT 12 years ago, by Ben Fry and Casey Reas, conceived originally as a programming environment for media artists. Really, it had two purposes. First, it was supposed to be quick and painless to create and compile a program. Second, it was built to be teachable—the commands and structures made sense, and \(most of\) the things that usually make programming painful were tucked away so that the user didn't have to think about them. In the years that have passed since its birth, Processing has been used for a dizzying array of projects, from robotics to architecture to dance to science to gaming and beyond. But these two core principles, ease-of-use and ease-of-learning, still guide the project and how it is developed.

With Processing for Android, and with Daniel's work on KETAI, these core philosophies are alive and breathing in the world of mobile devices. In a matter of minutes \(really!\), we can create real working applications on Android. Instead of being limited by the offerings in online "app marketplaces," we can build our own tools, focused on markets as large or as small as we want them to be. Want to make an app to track the time you spend with your kids? Build it in Android. Want to sample colors on your trip to the botanical gardens? Make an app, in minutes. Have an idea for the next big mobile game? Sketch it in Processing, and test it on your phone and tablet, with a single click.

Casey Reas has said that Processing was built to have a very low floor and a very high ceiling. It is meant to be both easy to use, and extremely functional. This core principle applies neatly to Processing for Android, which is at the same time very easy to learn, and extraordinarily powerful. With Daniel's book, readers will be quickly building and deploying simple projects to their Android devices. By working through the well-crafted examples and taking advantage of the code samples and libraries, they will easily be able to progress toward building more advanced apps, incorporating sensors and databases and all sorts of other useful and amazing things.

The central metaphor for Processing has for years been the sketchbook. Now this computational sketchbook is no longer tethered to our desks in an unwieldy box. We can take it with us into the world. A digital sketchbook, in our pocket. What an amazing idea.

**Jer Thorp**, Co-founder, The Office for Creative Research \(March 2013\)

## Acknowledgments

I'd like to acknowledge the following individuals who have contributed to this project and thank them deeply for their support:

First and foremost, Jesus Duran, CTO of Ketai LLC, without whom the Ketai library used in this book would neither have come to existence nor contain the comprehensive list of features that it has today&emdash;his talent and rigor have been essential to bringing Android features within Processing's reach in a timely and reliable way;

John Osborn, my editor, whose valuable feedback and recommendations were always right on target and instrumental to completing a book that could be useful and clear to diverse audiences;

Casey Reas, Processing cofounder, whose guidance and friendship are what brought me to Processing in the first place—I consider Processing to be not only one of the most versatile teaching and production tools available to solve problems but also the subject of the most generous community of creative coders out there;

Ben Fry, Processing cofounder, who has relentlessly guided Processing through its countless updates while maintaining a particular sense of humor that helped form the popular multimodal development environment into what it is today;

Andres Colubri, whose four-dimensional genius has produced a significant OpenGL and video overhaul for Processing and who has made major contributions to the Android mode;

Joshua Albers, Jon Buckley, Andres Colubri, Paulo Guerra, Riley Hoonan, Stephen Mendez, Jaskirat Singh Randhawa, Michael Riley, Andreas Schlegel, Jesse Scott, and William Smith for their thorough technical reviews of the book and their valuable feedback;

The University of Illinois at the Chicago School of Art and Design, supporting me to launch the Mobile Processing Conference in Chicago from 2010 to 2013;

The New School in New York City for supporting some of the comprehensive online reference; and

Irena Haiduk, my wife, on whom I rely for the critical judgment and daily joy that is required to write a book.

# Preface

&lt;i start-range="i. pf1.1"&gt;Processing language&lt;ii&gt;about&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i&gt;Fry, Ben&lt;\/i&gt;

 &lt;i&gt;Reas, Casey&lt;\/i&gt;

 Processing is a favorite among artists and designers and widely popular among 

 developers who

 look for a productivity edge.&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/processing.org\/&lt;\/url&gt;

 &lt;\/p&gt;&lt;\/footnote&gt; The programming language and environment has developed from a sketching tool to a production environment for a range of operating systems and platforms. The &lt;firstuse&gt;Android mode&lt;\/firstuse&gt;, introduced to Processing with the release of version 2.0, now makes it as easy to develop Processing apps for the Android as for the desktop.&lt;\/p&gt;

 &lt;p&gt;Initiators Ben Fry and Casey Reas have promoted software literacy since 2001 using Processing, a free open source tool that can be used by individuals at any level of programming experience. The Processing project thrives on the support of its generous online community, whose members encourage collaboration and code sharing and are responsible for one of Processing's most important features: its libraries.

 &lt;\/p&gt;

 &lt;p&gt;&lt;i&gt;Arduino&lt;\/i&gt;

 &lt;i&gt;Duran, Jesus&lt;\/i&gt;

 &lt;i&gt;libraries&lt;ii&gt;Processing&lt;\/ii&gt;&lt;\/i&gt; 

 Libraries have made Processing the versatile and capable coding environment that it is today. Members have contributed more than 130 libraries to Processing over the last decade. I have extensively used Processing in the classroom during the past eight years and have realized various projects with it, sometimes in conjunction with Processing's sister project, Arduino.&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/arduino.cc\/&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; In 2010, I started the &lt;firstuse&gt;Ketai&lt;\/firstuse&gt; \(the Japanese term for cell phone culture\) library with Jesus Duran,&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/code.google.com\/p\/ketai\/&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; which brings Android hardware features to Processing and makes it possible to work with sensors and hardware devices using simple and easy-to-read code.

 &lt;\/p&gt;

 &lt;p&gt;&lt;i&gt;Android apps&lt;ii&gt;developing in Java&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i&gt;Java&lt;ii&gt;developing Android apps in&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i&gt;Eclipse IDE&lt;\/i&gt;

 In comparison, developing Android apps in Java using the standard Eclipse IDE entails a much steeper learning curve,&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/developer.android.com\/sdk\/eclipse-adt.html&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; one that requires a programmer to master both the syntax of a modern object-oriented language and the features of a complex development environment. In Processing, we can see results immediately because we are working with a straightforward syntax and a wide range of libraries and tools designed specifically to support visually lavish and highly interactive applications.

 &lt;\/p&gt;

 &lt;p&gt;

 Android users expect a rich, interactive mobile user experience from their phones and tablets, one that takes full advantage of their touch screens, networking hardware, sensors for geolocation and device orientation, built-in cameras, and more. In this book, we'll learn how to create apps for Android devices that take full advantage of their many built-in hardware affordances.

 &lt;\/p&gt;

 &lt;sect1&gt;

 &lt;title&gt;Introducing Processing for the Android&lt;\/title&gt;

 &lt;p&gt;&lt;i&gt;Android apps&lt;ii&gt;developing in Processing&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i&gt;Android mode&lt;ii&gt;vs. Java mode&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i&gt;Java mode&lt;ii&gt;vs. Android mode&lt;\/ii&gt;&lt;\/i&gt;

 Android is based on the Java programming language. Processing is also based on Java, making it the perfect platform for developing Android apps using Processing's straightforward syntax. The addition of the Android mode was a natural progression for Processing in order to streamline application development while targeting a broad range of operating systems and devices with one comprehensive programming language. In fact, Processing's software architecture allows us to mix in Java statements and packages, Android statements and packages, and Processing sketches and libraries wherever we feel like it. 

 &lt;i end-range="i. pf1.1"\/&gt;&lt;\/p&gt;

 &lt;p&gt;

 This book focuses on Android apps developed in Processing. There are no differences between the Android mode and Processing's Java mode for desktop applications when it comes to the basic programming structure and syntax. Android-specific features that require device sensors and hardware are not available on the desktop and therefore are not usable in Processing's Java mode. They are available, however, as soon as we switch to Android mode. 

 &lt;\/p&gt;

 &lt;p&gt;

 In the last chapter of the book we'll discuss cross-platform challenges for mobile apps and introduce Processing's JavaScript mode. HTML5 web apps developed in Processing run on all modern browsers found on smart phones, tablets, and desktops today. While interoperability is an important factor, we will limit our discussion of web apps to the last chapter, as we can't access many of the hardware sensors and devices that make for exciting apps. 

 &lt;\/p&gt;

 &lt;p&gt;

 All core Processing methods are identical across modes, so when we develop Android apps we can also consider and use code examples written for Java mode. The Processing website contains a complete reference for all Processing methods.&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/processing.org\/reference\/&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; So does the IDE, which ships with a packaged reference that we can use without a connection to the Web; it's available from the Processing menu by selecting Help &mapsto; Reference.

 &lt;\/p&gt;

 &lt;p&gt;&lt;i start-range="i. pf1.2"&gt;Android apps&lt;ii&gt;advantages to developing in Processing&lt;\/ii&gt;&lt;\/i&gt;

 &lt;i start-range="i. pf1.3"&gt;Processing language&lt;ii&gt;advantages to developing Android apps in&lt;\/ii&gt;&lt;\/i&gt;

 Let's take a look at some of the main advantages to developing Android apps in Processing:

 &lt;\/p&gt;

 &lt;ul&gt; 

 &lt;li&gt;

 &lt;p&gt;

 If you are new to programming, Processing for Android is much easier to learn than Java. If you are an experienced Java programmer already, Processing is a great programming environment for rapid prototyping of graphics and sensor-heavy apps. 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Processing uses straightforward syntax. In comparison to Java, it is more concise.&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/wiki.processing.org\/w\/Java\_Comparison&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; Processing doesn't require you to understand advanced concepts such as classes or screen buffering to get started, yet it makes them accessible to any advanced users who want to use them. This makes Processing programs shorter and easier to read. 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 The lightweight programming environment installs quickly and is easy to use. Processing is available for GNU\/Linux, Mac OS X, and Windows. If you work with multiple computers or want to help someone else get started quickly, being up and running in a few minutes can make all the difference. 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Processing for Android supports OpenGL.&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;https:\/\/www.opengl.org&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt;. When working with GPU-accelerated 2D and 3D graphics and geometry, lights, or textures, &lt;nobreak&gt;comprehensive&lt;\/nobreak&gt; OpenGL support is essential to ensure reasonably high frame rates and a fluid user experience.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 The latest version of Processing supports three application environments, or modes. Applications written in Java mode will run on Linux, Mac, or Windows systems. Programs written in Android mode will run on Android devices, and those written in JavaScript mode will run in any HTML5 browser. The Android mode is designed for creating native Android apps.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Once your sketch prototyping is done, you can easily move your work to Eclipse for debugging and deployment. Processing lets you export your sketches as Android projects in the File &mapsto; Export Android Project menu, creating an &lt;dir&gt;android&lt;\/dir&gt; directory with all the necessary files in it.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;\/ul&gt; 

 &lt;p&gt;

 This list of advantages should provide you all the evidence you need to conclude that Processing is a great environment for developing Android apps. Your projects can scale in scope and context: from sketch to prototype and from prototype to market-ready application, from CPU-focused graphics rendering to hardware-accelerated GPU-focused rendering, from Processing statements and libraries to Android and Java statements and packages, and from a particular operating system and device to other operating systems and devices. You won't need to worry about a different last-minute route or an alternative solution for your software projects. Projects can grow with you and will let you enjoy the iterative process of design and development. 

 &lt;i end-range="i. pf1.2"\/&gt;

 &lt;i end-range="i. pf1.3"\/&gt;&lt;\/p&gt; 

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;Who This Book Is For&lt;\/title&gt; 

 &lt;p&gt; 

 The book is written for the following readers:

 &lt;\/p&gt;

 &lt;ul&gt;

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;Readers with some programming experience&lt;\/emph&gt;: Readers with a basic understanding of programming concepts can quickly learn the Processing language as they work their way through the examples. Processing is that easy to learn.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;Intermediate Processing users&lt;\/emph&gt;: Readers looking to create Android apps from within the Processing IDE can maintain a good balance between simplicity and versatility.

 &lt;\/p&gt;

 &lt;\/li&gt; 

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;Educators who teach courses on mobile technologies&lt;\/emph&gt;: Teachers often navigate the academic triangle of limited time, limited budget, and classes without prerequisites. This book brings advanced mobile features within the reach of students with little or no prior programming experience using a free tool that does not require developer licenses or subscriptions. 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;Java and Android developers&lt;\/emph&gt;: Experienced developers look for a productivity gain. Because Processing builds on Java, developers can use their Java code and knowledge with Processing, leveraging a host of libraries for productivity gains.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;JavaScript and web developers&lt;\/emph&gt;: Processing.js syntax is identical to standard Processing syntax, making it easy to create JavaScript-powered web applications that can run inside browsers without plugins or other modifications.

 Processing.js also takes advantage of WebGL hardware &lt;nobreak&gt;acceleration&lt;\/nobreak&gt;.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 &lt;emph&gt;Arduino users and hobbyists&lt;\/emph&gt;: Some readers have experience with the Processing language by using it to program the Arduino electronics platform and are interested in adapting Android phones or tablets for use as sensing devices, controllers, or graphics processors.

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;\/ul&gt;

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;Prerequisites&lt;\/title&gt;

 &lt;p&gt;

 If you have never programmed in Processing or any other language before, you can turn to two excellent sources to get you up to speed; I've listed them at the end of this paragraph. You need to have an idea of the basic principles of programming to fully enjoy the book, such as the use of variables, conditionals, and loops. If you feel a little shaky with any of those concepts, I &lt;nobreak&gt;recommend&lt;\/nobreak&gt; you get one of the two books and keep it close by for frequent consultation. If you have scripted or programmed before, even if only at a basic level, you should be able follow the examples in this book with a close read. 

 &lt;\/p&gt;

 &lt;dl&gt;

 &lt;dt newline="yes"&gt;&lt;bookname cite="reas:getstart"&gt;Getting Started with Processing&lt;\/bookname&gt;&lt;\/dt&gt;

 &lt;dd&gt; 

 &lt;p&gt;&lt;i&gt;&lt;emph&gt;Getting Started with Processing&lt;\/emph&gt; \(Reas and Fry\)&lt;\/i&gt;

 &lt;i&gt;&lt;emph&gt;Processing: A Programming Handbook for Visual Designers and Artists, Second Edition&lt;\/emph&gt; \(Reas and Fry\)&lt;\/i&gt;

 &lt;i&gt;Reas, Casey&lt;\/i&gt;

 &lt;i&gt;Fry, Ben&lt;\/i&gt;

 This casual, inexpensive book is a concise introduction to Processing and interactive computer graphics.&lt;footnote&gt;&lt;p&gt;Available at &lt;url&gt;http:\/\/shop.oreilly.com\/product\/0636920000570.do&lt;\/url&gt;.&lt;\/p&gt;&lt;\/footnote&gt; Written by Processing's initiators, it takes you through the learning process one step at a time to help you grasp core programming concepts. 

 &lt;\/p&gt;

 &lt;\/dd&gt;

 &lt;dt newline="yes"&gt;&lt;bookname cite="reas:processing"&gt;Processing: A Programming Handbook

 for Visual Designers and Artists, Second Edition&lt;\/bookname&gt;&lt;\/dt&gt;

 &lt;dd&gt;

 &lt;p&gt;

 This book is an introduction to the ideas of computer programming within the context of the visual arts.&lt;footnote&gt;&lt;p&gt;Available at &lt;url&gt;http:\/\/mitpress.mit.edu\/books\/processing-1&lt;\/url&gt;.&lt;\/p&gt;&lt;\/footnote&gt; It targets an audience of computer-savvy individuals who are interested in creating interactive and visual work through writing software but who have little or no prior experience.

 &lt;\/p&gt;

 &lt;\/dd&gt;

 &lt;\/dl&gt;

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;What's in This Book&lt;\/title&gt;

 &lt;p&gt;

 This book will have you developing interactive sensor-based Android apps in no time. The chapters include previews of all the classes and methods used for the chapter projects, as well as a description of the particular sensor or hardware device that we'll be working with. Small projects introduce the basic steps to get a particular feature working, which leads up to a more advanced chapter project.

 &lt;\/p&gt;

 &lt;p&gt;

 Part I of the book gets you started with the touch screen and Android sensors and cameras. &lt;ref linkend="chp.getting.started" \/&gt;, walks you through the steps of installing Processing and the Android SDK. We'll write a simple app and run it in the emulator and on an Android device. &lt;ref linkend="chp.display" \/&gt;, will show you how to use mouse position, finger pressure, and multitouch gestures on the touch screen panel while also providing details on the support for color that Processing provides. &lt;ref linkend="chp.sensors" \/&gt;, introduces us to all the device sensors built into an Android. We'll display accelerometer values on the Android screen, build a motion-based color mixer, and detect a device shake.

 &lt;\/p&gt;

 &lt;p&gt;

 In Part II, we'll be working with the camera and location devices found on most Androids. &lt;ref linkend="chp.geolocation" \/&gt;, shows us how to write location-based apps. We'll determine our location, the distance to a destination and to another mobile device on the move, and calculate the speed and bearing of a device. &lt;ref linkend="chp.camera" \/&gt;, lets us access the Android cameras through Processing. We'll display a camera preview of the front- and back-facing cameras, snap and save pictures to the camera's SD card, and superimpose images.

 &lt;\/p&gt;

 &lt;p&gt;

 In Part III, we'll learn about peer-to-peer networking. &lt;ref linkend="chp.wifi" \/&gt;, teaches us how to connect the Android with our desktop via &lt;acronym&gt;Wi-Fi&lt;\/acronym&gt; using the Open Sound Control protocol. We'll create a virtual whiteboard app, where you and your friends can doodle collaboratively, and we'll build a marble-balancing game, where two players compete on a shared virtual board. &lt;ref linkend="chp.p2p" \/&gt;, shows us how to use Android Bluetooth technology to discover, pair, and connect Android devices. We'll create a remote cursor sketch and build a survey app to share questions and answers between devices. &lt;ref linkend="chp.nfc" \/&gt;, introduces us to the emerging short-range radio standard designed for zero-click interaction at close proximity and is expected to revolutionize the point-of-sale industry. We'll read and write NFC tags and exchange data between Android devices via NFC and Bluetooth.

 &lt;\/p&gt;

 &lt;p&gt;

 Part IV deals with data and storage, as all advanced apps require some sort of data storage and retrieval to keep user data up-to-date. In &lt;ref linkend="chp.data" \/&gt;, we'll load, parse, and display data from text files and write data to a text file in the Android storage. We'll also connect to a data source hosted online to create an earthquake app that visualizes currently reported earthquakes worldwide. &lt;ref linkend="chp.sqlite" \/&gt;, introduces us to the popular SQLite database management system and Structured Query Language. We'll record sensor data into a SQLite database and query it for particular data attributes. 

 &lt;\/p&gt;

 &lt;p size="small"&gt;

 Part V gets us going with 3D graphics and cross-platform apps. &lt;ref linkend="chp.mobile.3d" \/&gt;, will show us how to work with 3D primitives, how virtual light sources are used, and how cameras are animated. &lt;ref linkend="chp.shapes.objects" \/&gt;, deals with 2D vector shapes and how to load and create 3D objects. &lt;ref linkend="chp.web.apps" \/&gt;, opens up our mobile app development to a wide range of devices and platforms using the JavaScript mode in Processing. We'll discuss some of the benefits of web apps being able to run on all modern browsers and the range of limitations using built-in device hardware.

 &lt;\/p&gt;

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;How to Read This Book&lt;\/title&gt;

 &lt;p&gt;

 The five parts of the book can each be considered self-contained mini-courses that you can jump right into once you have completed Part I, have properly installed all the required software, and are up and running. While the book does progress in a step-by-step fashion from fundamental to advanced subjects, you can jump right into Part II, III, IV, or V if you need to tackle a &lt;nobreak&gt;particular&lt;\/nobreak&gt; family of sensors or Android features for a current project.

 &lt;\/p&gt;

 &lt;p&gt;

 Whenever we undertake a project that builds on prior code, refines an earlier project, or revisits important concepts mentioned earlier in the book, we'll cross-reference those earlier sections accordingly; if you are using the ebook, you can use the link to jump directly to the referenced section. 

 &lt;\/p&gt;

 &lt;p&gt;

 Throughout our journey in this book, I encourage you to get inspired by the projects in the Processing exhibition \(&lt;url&gt;http:\/\/processing.org\/exhibition\/&lt;\/url&gt;\), learn from the Processing community \(&lt;url&gt;http:\/\/forum.processing.org\/&lt;\/url&gt;\), use the code examples included in IDE File &mapsto; &lquot;Examples...,&rquot; refer to the online tutorials \(&lt;url&gt;http:\/\/processing.org\/learning\/&lt;\/url&gt;\), collaborate with peers \(&lt;url&gt;http:\/\/sketchpad.cc&lt;\/url&gt;\), and learn from public sources, such as &lt;url&gt;http:\/\/www.openprocessing.org\/&lt;\/url&gt;.

 &lt;\/p&gt;

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;What You Need to Use This Book&lt;\/title&gt;

 &lt;p&gt;

 For all the projects in this book, you need the following software tools. The first chapter guides you through installing those tools step by step.

 &lt;\/p&gt;

 &lt;ul style="compact"&gt;

 &lt;li&gt;

 &lt;p&gt;

 Processing 3&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/processing.org\/download\/&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt;

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Android 4.0 Ice Cream Sandwich or higher&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/developer.android.com\/sdk\/&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt; \(2.3 Gingerbread is sufficient for all projects but &lt;ref linkend="chp.p2p" \/&gt;, and &lt;ref linkend="chp.nfc" \/&gt;\).

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Ketai Sensor Library for Processing&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/ketai.org&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt;

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Processing Android installation instructions&lt;footnote&gt;

 &lt;p&gt;

 &lt;url&gt;http:\/\/wiki.processing.org\/w\/Android\#Instructions&lt;\/url&gt;

 &lt;\/p&gt;

 &lt;\/footnote&gt;

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;\/ul&gt;

 &lt;p&gt;

 The projects in this book require at least one Android device. To complete Part III, you need two Android devices. This allows us to run and test the sketches on the actual hardware, use the actual sensors, and get the actual mobile user experience that is the focus of this book. 

 &lt;\/p&gt;

 &lt;\/sect1&gt;

 &lt;sect1 id="sec.tested.devices"&gt;

 &lt;title&gt;Tested Android Devices for this Book&lt;\/title&gt;

 &lt;p&gt;

 The example code for the projects in this book has been tested on the following devices, some shown in &lt;ref linkend="fig.tested.devices" \/&gt;:

 &lt;\/p&gt;

 &lt;figure id="fig.tested.devices"&gt;

 &lt;title&gt;Tested Android phones and tablets.&lt;\/title&gt;

 &lt;p&gt;Clockwise from top left: ASUS Transformer Prime, Samsung Galaxy SIII, Samsung Nexus S, and Google Nexus 7&lt;\/p&gt;

 &lt;imagedata fileref="images\/Preface\/DevicesOn\_8bit.png" width="fit" \/&gt;

 &lt;\/figure&gt;

 &lt;ul style="compact"&gt;

 &lt;li&gt;

 &lt;p&gt;

 Asus Transformer Prime Tablet with 32 GB memory \(Ice Cream Sandwich, Jelly Bean\) 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Samsung Galaxy SIII \(Ice Cream Sandwich, Jelly Bean, KitKat\) 

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Samsung Nexus S \(Ice Cream Sandwich, Jelly Bean, KitKat\) 

 &lt;\/p&gt;

 &lt;\/li&gt; 

 &lt;li&gt;

 &lt;p&gt;

 Google Nexus 7 with 8 GB memory \(Jelly Bean, KitKat\)

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;li&gt;

 &lt;p&gt;

 Google Nexus 6 with 25 GB memory \(Lollipop\)

 &lt;\/p&gt;

 &lt;\/li&gt;

 &lt;\/ul&gt;

 &lt;p&gt;

 All the code is available online. Feel free to comment and drop some feedback! 

 &lt;\/p&gt;

 &lt;\/sect1&gt;

 &lt;sect1&gt;

 &lt;title&gt;Online Resources&lt;\/title&gt;

 &lt;p&gt;

 You can download the complete set of source files from the book's web page at &lt;url&gt;http:\/\/pragprog.com\/titles\/dsproc\/source\_code&lt;\/url&gt;. The compressed file available online contains all the media assets you need organized by chapter directories and individual projects. If you’re reading the ebook, you can also open the discussed source code just by clicking the file path before the code listings.

 &lt;\/p&gt;

 &lt;p&gt;

 The online forum for the book, located at &lt;url&gt;http:\/\/forums.pragprog.com\/forums\/209&lt;\/url&gt;, provides a place for feedback, discussion, questions, and&emdash;I hope&emdash;answers as well. In the ebook, you'll find a link to the forum on every page next to a &lquot;report erratum&rquot; link that points to &lt;url&gt;http:\/\/pragprog.com\/titles\/dsproc\/errata&lt;\/url&gt;, where you can report errors such as typos, technical errors, and suggestions. Your feedback and suggestions are very much appreciated.

 &lt;\/p&gt;

 &lt;\/sect1&gt;

 &lt;p&gt;

 Let's get started! Once we're done installing our software tools in &lt;ref linkend="chp.getting.started" \/&gt;, we are only minutes away from completing our first Android app.

 &lt;\/p&gt;

 &lt;prefacesignoff name="Daniel Sauter" date="2015-03-31" location="New York City" email="daniel@ketai.org" title="Associate Professor, School of Art, Media, and Technology at Parsons, The New School"\/&gt;

&lt;\/chapter&gt;

