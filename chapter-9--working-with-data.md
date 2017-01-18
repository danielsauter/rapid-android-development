###Chapter 9:

#Working with Data
 
 Sooner or later, we’ll need to be able to store and read data. To keep track of user choices and settings, we need to write data into a file or database stored on the Android device. We can’t always rely on a carrier or network connection to read and write data from the Web or the Cloud, so we require a repository on the Android device; that way we can stop the app or reboot the phone without losing data and provide continuity between user sessions. Users expect mobile devices to seamlessly integrate into their daily routines and provide them with information that is relevant to their geographic and time-specific context. Entire books have been dedicated to each section in this chapter. As we create the chapter projects, we’ll try our best to remain focused on the Android specifics when we are working with data and to explore only those formats and techniques you’re most likely to use. 
 
 Processing has received a major upgrade to its data features, which were compiled into a comprehensive `Table` class. The `Table` class allows us to read, parse, manipulate, and write tabular data in different datatypes. With Processing 2.0, Ben Fry, one of its principal authors, has now integrated the methods and techniques from his seminal *Visualizing Data (Fry, '08)* into the Processing core, making it easier for us to visually explore data. 
 
 Using the `Table` class, we'll be visualizing tab- and comma-separated data in no time. We'll learn how to work with private and public data storage on the Android, keeping data accessible only for our app, and alternatively share it with other apps via Android’s external storage. We’ll read data from the internal and external storage and write data into tab-separated value files stored on the Android. 
 
 To demonstrate how sensors, stored data, and Processing techniques for displaying data can be combined, we’ll create an app that acquires real-time earthquake data and displays the result. The app will read, store, and show all reported earthquakes worldwide during the last hour using the data access techniques you’ll learn in this chapter and data collected by the US Environmental Protection Agency (`EPA`). For the project, we’ll make use of the `Location` code introduced in <!--ref linkend="chp.geolocation-->. In a second step, we’ll refine the earthquake app to indicate when new earthquakes are reported using timed device vibrations. 
 
 In the following chapter of this two-part introduction to data, we’ll work with SQLite, the popular relational database management system for local clients like the Android and used by many browsers and operating systems. It implements the popular Structured Query Language (`SQL`) syntax for database queries, which we can use to access data that we’ve stored locally on our device. We’ll first get SQLite running with a simple sketch and learn how to use `SQL` queries to retrieve data from one or more tables, and then we’ll use it to capture, store, browse, and visualize sensor values. These are the tools we’ll need to write some more ambitious data-driven projects. 
 
 Let’s first take a closer look at data, data storage, and databases. 

###Introducing Databases
 
 To autocomplete the words that users type, guess a user’s intent, or allow users to pick up where they have left off requires that our apps work with files and databases; there is simply no alternative. For example, when we pull up a bookmark, check a score, or restore prior user settings, we read data that we’ve written earlier into a local file or database. Data is essential for mobile apps because both time and location are ubiquitous dimensions when we use our Android devices, and it requires additional considerations when we develop, compared to desktop software. We expect our mobile apps to also be functional when cellular or Wi-Fi networks are unavailable. In such a scenario, apps typically rely on the data that has been saved in prior sessions, which typically get updated when a network becomes available. 
 
 Whether they are stored in tabular files or as object-oriented records, databases generally share one characteristic&—structured data in the form of text and numbers, separated into distinct categories, or fields. The more specific the fields, the better the results and sorts the database can deliver. As we know, for example, dumping all of our receipts into one shoebox is not the kind of database structure an accountant or financial advisor would recommend: labeled files and folders are far more efficient and searchable. 
 
 Recommending which type of organization, or data architecture, is the best for a particular task goes beyond the scope of this book. It’s the subject of numerous anthologies [(such as *Visualizing Data (Fry, '08)*)][0], which do a great job of breaking down appropriate table relations, data types, and queries. We’re going to limit the scope of our exploration to tab- and comma-separated values (`TSV` and `CSV`) because they are easy to use and very common, and we’ll balance it with the more powerful SQLite data management system, providing us with more complex queries and the most widely deployed data management system out there. 
 
 The most common structural metaphor for representing a database is a table (or a couple of them). Known to us from spreadsheets, a table uses columns and rows as a data structure. Columns, also known as fields, provide the different categories for a table; rows contain entries in the form of numbers and text that always adhere to the structure provided by the columns. 
 
 Processing provides us with a `Table` class that lets us read, parse, manipulate, and write tabular data, which we’ll be using throughout the chapter. It’s a very useful class that is built into Processing’s core and provides us with methods akin to what we’d expect from a database. However, it is used as an object stored in memory only until we explicitly write the contents to a file. 

###Working with the Table Class and the File System
 
 Throughout this chapter, we'll work with Processing’s `Table` class, and particularly with the following methods: 
 <table> <colspec col="1" width="23%--> <row><col>
`Table`
 <col> <p size="small--> A comprehensive Processing class to load, parse, and write data in different file formats&—it provides similar methods that we’d find in a database. 
 </row> <row><col>
`getRowCount()`
 <col> 
 A `Table` method, which returns the number of rows or entries inside a table 
 </row> <row><col>
`getInt()`, `getLong()`, `getFloat()`, `getDouble()`, `getString()`
 <col> 
 A series of `Table` methods to retrieve the different value types from a specified row and column provided to the methods as two parameters separated by comma 
 </row> <row><col>
`addRow()`
 <col> 
 A `Table` method to add a new row to the table 
 </row> <row><col>
`writeTSV()`
 <col> 
 A `Table` method to write a `tsv` file to a specified location in the file system, provided to the method as a parameter 
 </row> <row><col>
[`Environment`][1]
 <col> 
 An Android class that provides access to environment variables such as directories 
 </row> <row><col>
[`File`][2]
 <col> 
 A Java method to create a file path to a specified location in the file system 
 </row> <row><col>
[`URL`][3]
 <col> 
 A Java class for a Uniform Resource Locator, a pointer to a resource on the Web 
 </row> <row><col>
[`BufferedReader`][4]
 <col> 
 A Java class that reads text from a character-input stream and buffers them so we can read individual characters as complete text&—we use it in this chapter to make sure we’ve received all the comma-separated values stored in our online data source. 
 </row> <row><col>
[`InputStreamReader`][5]
 <col> 
 A Java class reading a bytes stream and decoding the data into text characters 
 </row> <row><col>
`sketchPath()`
 <col> 
 A Processing method returning the file path to the sketch in the file system&—if we run our sketch on the Android device, it returns the path to the app’s location within Android’s file system. 
 </row> <row><col>
[`KetaiVibrate()`][6]
 <col> <p size="small--> A Ketai class giving access to the built-in device vibration motor 
 </row> <row><col>
[`vibrate()`][7]
 <col> 
 A `KetaiVibrate` method to control the built-in device vibration motor&—this can be used without parameters for a simple vibration signal, a duration parameter in milliseconds, or an array of numbers that trigger a pattern of vibrations, `vibrate(long[] pattern, int repeat)`. 

 Since we are writing to the device’s file system in this chapter, let’s take a look at the options we have. 

###Working with Android Storage
 
 The Android device is equipped with the following storage types, which are available to our apps for saving data. We can keep our data private or expose it to other applications, as we’ve done deliberately in <!--ref linkend="sec.save.pictures-->, to share images we took. 

* *Internal Storage* This is used to store private data on the device memory. On the Android, files we save are saved by default to internal storage and are private, which means other applications cannot access the data. Because they are stored with our application, files saved to internal storage are removed when we uninstall an app. We’ll use the internal storage in <!--ref linkend="sec.write.tsv-->. 

* *External Storage* All Android devices support a shared external storage that we can use to store files. The external storage can be a removable SD card or a non-removable storage medium, depending on your Android device’s make and model. If we save a file to external storage, other applications can read the file and users can modify or remove it in the USB mass storage mode when we connect the device to the desktop via USB. In 4.1 Jelly Bean or earlier versions of Android, we need to be careful when writing essential data there for the app to run, and we can’t use it for any data we need to keep private. Since 4.2 Jelly Bean, Android provides a `READ_EXTERNAL_STORAGE` permission for protected read access to external storage. In the Settings menu on the Android device, a new developer option called `Protect USB storage` allows us to activate a read-access restriction and test this new permission option for protected read access to [external storage.][8] 

* *SQLite Databases* SQLite support on the Android provides us with a simple database management tool for our local storage, both internal and external, which we’ll explore in the next chapter, <!--ref linkend="chp.sqlite-->. 

* *Network Connections* We’ve explored the possibility of working with a web server for stored data already in <!--ref linkend="sec.device.finder-->, which is an option for files that do not have to be readily available for our app to run. This is not a good option for user preferences, as we can’t rely on a carrier or Wi-Fi network to reach the server. 

* **Cloud Services**  Cloud services are becoming increasingly popular and are another option for extending the storage capabilities of Android devices. [Google’s Cloud platform,][9] for instance, provides SDKs to integrate the Cloud into your apps alongside a Google Cloud Messaging service to send a notification to your Android device if new data has been uploaded to the Cloud and is [available for download.][10] Also, Google Drive provides an SDK to [integrate Google’s document and data storage service into our apps.][11] 
   
 We’ll focus on Android’s internal storage in this chapter. Let’s get started and use the `Table` class now to read data from a tab-separated file. 
 

###Read a Tab-Separated Grocery List
 
 Let’s get started by working with a familiar list, a grocery list for our favorite pasta recipe, which we’ll display on the device screen. Let’s color-code the ingredients based on where we have to go to get them. We’ll work with tab-separated values stored in a text file called `groceries.tsv`, which is located in the `data` folder of our sketch. The file contains eleven items saved into individual rows, each row containing the amount, unit, item, and source for each ingredient on our list, separated by a tab character. The first row contains the labels for each column, which we’ll keep for our reference but not display on the Android screen, as shown in <!--ref linkend="fig.data.read.groceries-->. 
 
![](images/Data/GroceryList.png)
#####Figure 9.0 - Reading groceries items from a tab-separated data file.
######The eleven items we need for this favorite pasta recipe are listed, color-coded by source (cyan for “market” and orange for “store”). 

To implement this sketch, we’ll use Processing’s `Table` class for loading and parsing the file’s contents row by row. When we initialize our `Table` object in `setup()`, we provide a file path to our data as a parameter, and `Table` object will take care of loading the data contained in the file for us. The grocery items and amounts contained in the `groceries.tsv` file each use one row for one entry, separated by a new line (“\n”) character. A tab separates the amount from the volume unit, item description, and the source where we’d like to get it. 
 
 Let’s look at the text file containing our grocery items, which are saved into individual rows and separated by tabs.
 
 #####code/Data/DataReadGroceries/data/groceries.tsv
 [include](code/Data/DataReadGroceries/data/groceries.tsv)

 The file extension `tsv` indicates here that the groceries data is tab-separated. If the file is named `groceries.txt` instead, we can use the option parameter in `loadTable()` to indicate the tab-separated data structure, like this: 
 
```
loadTable("groceries.txt", "tsv");
``` 

 We can also add `header` in the options parameter to indicate that the file includes a header row. 
 
```
loadTable("groceries.txt", "header, tsv");
``` 

 Now let’s take a look at our code.
  
 #####code/Data/DataReadGroceries/DataReadGroceries.pde 
 [include](code/Data/DataReadGroceries/DataReadGroceries.pde)
 
 Here are the steps we take to read our text file and display the grocery list. 
 1. Load `groceries.tsv` by providing the file name as a parameter to the `Table` object `groceries`. 
 2. Set the rectangle drawing mode to `CENTER` so that the *x* and *y* location of the rectangle specifies the center of the rectangle instead of the default upper left corner. 
 3. Center the text labels for our rows horizontally and vertically within our text area. 
 4. Do not loop the sketch (by default it loops 60 times per second), because we are not updating the screen and do not interact with the touch screen interface. This optional statement saves us some `CPU` cycles and battery power; the sketch produces no different visual output if we don’t use this statement. 
 5. Count the number of rows contained in `groceries` and store this number in `count`—used also to position the rectangles. 
 6. Calculate the `rowHeight` of each color rectangle by dividing the display height by the number of rows in the file. 
 7. Get the text string from column `0` that contains the `amount` using `getString()`. 
 8. Get the text string from column `1` that contains the measurement `unit`. 
 9. Get the `item` description from column `2`, `unit`. 
 10. Check if the location stored in column `3` matches “store.” 
 11. Check if the location stored in column `3` matches “market.” 
 12. Draw a rectangle with the fill color `c` horizontally centered on the screen and vertically moved down by half a `rowHeight`. 
 13. Output the text label for each named color centered within the row rectangle. 
 14. Move downward by one `rowHeight` using `translate()`. 
 
 Let’s now move on to reading comma-separated values from a text file. 

###Read Comma-Separated Web Color Data
 
 In the next sketch, we’ll work with hexadecimal values of web colors and juxtapose them with their official name from the HTML web specification. Our data source contains comma (“,”) separated values (`CSV`), which we read from the file stored in the `data` directory of our sketch. The `CSV` file contains sixteen rows, each containing two values separated by a comma. The first value contains a `String` that is one of the named colors in the [W3C’s `HTML` `color` specification.][12] The second value contains a text `String` that represents the hexadecimal value (or “hex value,” for short) of that named color. When we juxtapose a text description with its color in a list of individually labeled swatches, our sketch will display a screen like that shown in <!--ref linkend="fig.data.read-->. To distribute each swatch vertically, we use the `translate()` method we’ve implemented already in <!--ref linkend="sec.destination.finder-->.[][13] 
 
![](images/Data/DataRead.png)
#####Figure 9.1 - Reading comma-separated color values.
######Sixteen named colors from the HTML specification are stored in a csv file and juxtaposed with their hexadecimal color value. 

Hexadecimal is a numbering system with a base of `16`. Each value is represented by symbols ranging `0..9` and `A..F` (`0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F`)&—sixteen symbols that each represent one hexadecimal value. Two hex values combined can represent decimal numbers up to `256` (`16` times `16`)—the same number we use to define colors in other Processing color modes such as `RGB` and `HSB` (see <!--ref linkend="sec.color.modes-->). 
 
In most programming languages, hexadecimal color values are typically identified by a hash tag (`#`) or the prefix `0x`. The hex values stored in column 1 of our file contains a `#` prefix. We need to convert the text `String` representing the hex color in the first column into an actual hex value we can use as a parameter for our `fill()` method. For that, we use two Processing methods, [`substring()`][14] and [`unhex()`][24], to bring the hex value into the correct format, and then we convert the `String` representation of a hex number into its equivalent integer value *before* applying it to `fill()`. 
 
The `substring()` method allows us to remove the `#` prefix, and `unhex()` allows us to convert `String` into hex. The `unhex()` method expects a hexadecimal color specified by eight hex values, the first two (first and second) defining the alpha value or transparency; the next two (third and fourth), red; then the next two (fifth and sixth), green; and finally the last two values (seventh and eighth), the blue value of that color. When we read the color from the file, we’ll prepend `"FF"` so we get fully opaque and saturated colors. 
 
Let’s first take a peek at the color data we copy into `colors.csv`. 

#####code/Data/DataRead/data/colors.csv
[include](code/Data/DataRead/data/colors.csv)

Open the file in your text editor and copy the file into your sketch’s `data` folder. The file contents are fairly easy for us to grasp, as the file only contains two columns and sixteen rows. Our approach would be the same if we faced a `csv` file containing fifty columns and one thousand rows. Note that there are no spaces after the commas separating the values, as this would translate into a whitespace contained in the value following the comma. 
 
 Now let’s take a look at our Processing sketch. 
 
#####code/Data/DataRead/DataRead.pde
[include](code/Data/DataRead/DataRead.pde)
  
 Here are the steps we take to load and parse the data. 
 
 1. Load the text file containing colors as comma-separated values. 
 2. Define a hex color from the `String` contained in column `1` after removing the `#` prefix using `substring()` and prepending `"FF"` for a fully opaque alpha channel. 
 3. Set the `fill()` color for the color rectangle to the hex color we’ve retrieved from the text file. 
 
Now that you know how it works, let’s run the app.

###Run the App
 
 When our sketch runs, the `colors.csv` file will be included as a resource and installed with our app on the device. You’ll see the sixteen named colors in `HTML` as individual swatches filling up the screen. Because we haven’t locked `orientation()` in this sketch, the display will change its orientation depending on how we hold the device. We’ve implemented the position and alignment of the swatches in a variable manner based on the current display’s `width` and `height`, so the sketch will scale to any orientation or display size on our Android phone or tablet. 
 
 Now that we know how to read data from a file, let’s now move ahead and read and write tab-separated values. 

###Save User Data in a TSV File
 
 In this project, we’ll learn how to save user data. We’ll implement a simple drawing sketch that allows us to place a sequence of points on the Android touch screen. When we press a button on the device triggering a `keyPressed()` event, the resulting drawing doodle consisting of individual points is saved to the app folder on the Android device. 
 
 Using the menu button on the device as a trigger, we’ll write each horizontal and vertical position *x* and *y* into a text file using tab-separated values. To keep track of how many points we’ve saved into our file, we’ll output our row count on the display as well. If we pause or close the app and come back later, the points we’ve saved will be loaded into the sketch again, and we can continue where we left off. If we add to the drawing and press the menu button again, the new points will be appended to our `data.tsv` file and saved alongside our previous points. 
 
 We’ll revisit the simple drawing concepts from <!--ref linkend="sec.touch.screen-->, and <!--ref linkend="sec.real.time.data-->, and use the `mouseX` and `mouseY` location of our fingertip to continuously draw points on the screen, as shown in <!--ref linkend="fig.data.write-->. Using Java’s `File` class, we’ll also learn about Android storage and file paths, because we are creating a `tsv` file inside our app. This file will only be available for our app and not be usable by other locations, keeping the data private. 
 
 In terms of working with data, we’ll start this time from scratch. We won’t be copying an existing data source into the sketch’s `data` folder. Instead we’ll create data via the touch screen interface and write it into a file located in our sketch folder. This time, we use tab-separated values and save the data into a `data.tsv` file. 
 
 There is no significant difference between the two [delimiters.][15] Instead of a comma, `TSV` uses a tab (`\t`) to separate values. The most important thing to consider when choosing between the two formats is this: if you use comma-separated values, you cannot have entries that include a comma in a text string, and if you use tab-separated values, you cannot have entries that use tabs without changing the table structure and making it impossible to parse the file correctly. 
 
 You can modify `CSV` and `TSV` text files in any text editor, and your operating system might already open it up with your default spreadsheet software. I personally have an easier time deciphering tab-separated values because tabs lay out the columns in a more legible way, which is why I prefer `TSV`. The `Table` class can handle, read, and write either format equally well, so from a technical perspective, it really doesn’t make much of difference how we store our data. 
 
 To implement this sketch, we’ll revisit the handy `PVector` class we already used in <!--ref linkend="sec.multiple.sensors-->, to store value pairs in a vector. When we worked with an existing file earlier, we were certain that the `csv` file exists. Now when we run the sketch for the first time, the `data.tsv` file we’ll be using to store our data won’t exist yet, and we’ll need to create one using Processing’s `Table` method `writeCSV()`. To check if `data.tsv` exists from a prior session, we’ll use the `try` `catch` construct typically used in Java to catch exceptions that would cause our app to crash.[][16] We use it in our sketch to check if `data.tsv` already exists within our app. If we are trying to load the file when it does not exist the first time around, we’ll receive an exception, which we can use to create the file. 
 
 To draw, we’ll use Processing’s `mouseDragged()` method again, called every time we move our finger by one or more pixels while tapping the screen. This means that we will add new points to our table only when we move to a new position. The point count we display at the top of the screen will give us some feedback whenever we’ve added a new point to the list. To save the points to the Android’s internal storage, press one of the device buttons. 
 
 Let’s take a look at the sketch. 
 
![](images/Data/DataWrite.png)
#####Figure 9.2 - Write data to an Android.
######The illustration shows a total of eighty data points drawn on the touch screen, stored in the points PVector array, and saved to the Android storage in a file called data.tsv when we press a button. 

#####code/Data/DataWrite/DataWrite.pde
[include](code/Data/DataWrite/DataWrite.pde)

 We take the following steps to create a new `Table`, add points to it, and save those points into a file. 
 1. Create a new variable called `tsv` of type `Table`. 
 2. Create a `PVector` `ArrayList` called `points` to store the *x* and *y* location of a fingertip. 
 3. Try reading the `data.tsv` file from the Android sketch folder, if it exists. 
 4. Create the `tsv` `Table` object using a parameter. For the parameter, use Java’s `File` class and Processing’s `sketchPath()` for the file path, which the `Table` class will attempt to load&—causing an exception that the file doesn’t exist. 
 5. Catch the `java.io.FileNotFoundException`, which you can see in the console if the `data.tsv` file doesn’t exist at the defined location. 
 6. Create a new `tsv` `Table` object without a parameter if it’s the first time we run the sketch and the `data.tsv` file doesn’t exist. 
 7. Parse the `tsv` `Table` object row by row and add a new `PVector` to our `points` `ArrayList` for every record in our `data.tsv` file. Do nothing if `getRowCount()` returns `0`. 
 8. Parse the `points` `ArrayList` and draw a five-pixel-wide and -high `ellipse()` for each item using the `PVector`’s `x` and `y` components for the *x* and *y* location. 
 9. Add a new `PVector` to the `points` `ArrayList` when a new `mouseDragged()` event is triggered. 
 10. Create a `String` array called `data` containing two `String` values using Java’s `toString()` method to convert the `mouseX` and `mouseY` values into a text string. 
 11. Add a row to the `Table` object using the `addRow()` `Table` method. 
 12. Set the last row in the `Table` object to the `String` array `data`. 
 13. Using `writeTSV()`, write our `tsv` `Table` object to the `data.tsv` file inside our app at the `sketchPath()` location on the Android. Trigger the method using `keyPressed()`, which will detect if we press any menu button or key on the keyboard. 
 
We won’t need to give the sketch permission to access the Android’s internal storage because we are writing to the memory allocated for our app. Let’s run the code. 

###Run the App
 
When the app starts up, use your finger and doodle on the screen. It leaves behind a trace of points drawn sixty times per second. Each time, we set the point position using `mouseX` and `mouseY` and add the point to our `PVector` array, making the point count go up. 
 
Press `MENU` to save all point coordinates to internal storage. Now let’s test whether we’ve written our data successfully by closing and restarting our app. 
 
Press the `HOME` key to go back to the home screen. Now press and hold the `HOME` button to open the recent app screen, showing `DataWrite` alongside other apps you’ve launched recently. 
 
To close the `DataWrite` app or any app that’s running, swipe the app icon horizontally left or right, and it will close. Let’s reopen the `DataWrite` app now to see if our points are still there by navigating to the apps installed on the device using the Apps button. 
 
Reopen the app. The sketch launches, showing all the previously saved points we’ve doodled. Great, you’ve built an app that stored data on the Android device. 

Now that you’ve learned how to write data to the app using a specified location in internal storage, it’s time to explore how to share data with other apps using Android’s external storage. 

###Write Data to External Storage
 
 Building on our previous <!--ref linkend="code.data.write-->, let’s now make some modifications so we can write our data to the Android’s external storage. This allows us to share files with other applications, as we’ve done when we worked with the camera and saved pictures to the external storage in <!--ref linkend="sec.save.pictures-->. We can also copy our data to the desktop by mounting the device as USB mass storage. 
 
 The process of mounting the device as USB mass storage is inconsistent across devices and is manufacturer-specific. Some devices like the Nexus S offer to “Turn on USB storage” when you connect the device to the desktop via a USB cable. Other devices like the Galaxy S3 now require an app to launch the device as mass storage. Either way, Android devices typically offer such a feature, and we’ll take a look at the `data.tsv` file once we’ve created it on the external storage.
 
 To work with the file path to the external storage, we need to `import` [Android’s `android.os.Environment`package,][17] which will give us access to the `Environment` class and its `getExternalStorageDirectory()` method, including the file path method `getAbsolutePath()`. We use both methods to create the path `String` for our sketch, writing to and reading from `data.tsv` on the external storage. 
 
 Let’s take a look at the code snippet showing `keyPressed()`, where we only modify our file path for writing `data.tsv` to the external storage. The path for reading `data.tsv` is, and must be, identical. 

 #####code/Data/DataWriteExternal/DataWriteExternal.pde
 [include](code/Data/DataWriteExternal/DataWriteExternal.pde)
 
 1. Use Android’s `Environment` method `getExternalStorageDirectory()` to get the name of the external storage directory on the Android device, and use `getAbsolutePath()` to get the absolute path to that directory. Work with that path as a parameter for Java’s `File` object, providing a `File`-type parameter for Processing’s `writeTSV()` `Table` method, used to write the actual `TSV` file. 
 
 Let’s test the app now. 


###Run the App
 
 Before we can write to the external storage, we need to give the appropriate permission to do so in the Permissions Selector. Open the Android Permissions Selector, scroll to Write External Storage and check the permission box. 
 
 Now run the sketch on your device. It looks and behaves identically to the previous sketch shown in <!--ref linkend="fig.data.write-->. Draw some points on the screen and save it by pressing any of the menu keys. The only difference here is that we save `data.tsv` now into the root of your Android’s external storage directory. 
 
 Let’s browse the external storage and look for our `data.tsv` file. Depending on your Android make and model, try unplugging the USB cable connecting your device and the desktop, and plug it back in. You should be prompted to “Turn on USB” storage. If this is the case, go ahead and confirm (on some devices, try browsing to Settings &mapsto; “More...” on the Android and look for a USB mass storage option. Alternatively, look for the USB mass storage process recommended by your device manufacturer). 
 
 When you turn on USB storage, the device lets you know that some apps will stop; go ahead and OK that. Now move over to your desktop computer and browse to your USB mass storage medium, often called `NO NAME` if you haven’t renamed it. Click on your mass storage device, and right there in the root folder, find a file called `data.tsv`. 
 
 Check `data.tsv` by opening it in your favorite text editor. You’ll find two columns there neatly separated by a tab; in each row, you’ll find a pair of integer values. This is perfectly sufficient for our project. More complex data projects typically require a unique identifier for each row, a row in one table to point to a specific record in another. We’ll look into this when we are in <!--ref linkend="sec.sqlite-->, later in this chapter. 
 
 Now that we’ve learned how to use `CSV` and `TSV` data stored on the Android device, let’s explore how to load comma-separated values from a source hosted online in the next project. 

###Visualize Real-Time Earthquake Data
 
Let’s create an app to track earthquakes, putting our newly acquired data skills to work on a nifty data visualization project. The objective of the project is to visualize the location and magnitude of all of the earthquakes that have been reported worldwide during the last hour. We’ll use live data hosted on the U.S. Geological Survey Organization’s website and visualize it as an animated map, shown in <!--ref linkend="fig.earthquakes-->. The `CSV` data format that we’ll work with again is typically available on governmental sites, such as for the `USGS` or [the US Census.][18] 
 
When we take a look at the text data source containing comma-separated values, we can see the following data. The file linked here is a sample of the live online source, saved on February 24, 2015, which we’ll use as a fallback in case we don’t have an Internet connection. The first row contains the field labels. 
 
#####code/Data/DataEarthquakes/data/all_hour_2015-02-24.txt
[include](code/Data/DataEarthquakes/data/all_hour_2015-02-24.txt)
 
The actual data source we’ll work with is hosted online: 
 
[`http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.csv`](http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.csv)
 
 Follow the link in your browser, and you’ll see the current live `CSV` file consisting of comma-separated values. We won’t need to use all of the fields in order to visualize the location and magnitude of each earthquake, but we will need `latitude`, `longitude`, and `mag`. 
 
 To display the geographic location of each earthquake, we’ll use an [equirectangular projection world map,][19] which stretches the globe into a rectangular format. This allows us to translate the longitude and latitude values for each earthquake into an *x* and *y* location that we can display on our device screen. [Such a projection maps][20] the longitude meridians to regularly spaced vertical lines and maps latitudes to regularly spaced horizontal lines. The constant intervals between parallel lines lets us overlay each earthquake’s geolocation accurately in relation to the world map. 
 
 The map includes the complete range of longitude meridians from -180 to 180 degrees, but only a portion of the latitude degree spectrum&—from -60 to 85 degrees instead of the usual -90 to 90 degrees. The poles are not included in the map, which are the most distorted portion of an equirectangular projection map. Because they are less populated and less frequently the source of earthquakes, they are also less relevant for our app, and we can use the map’s pixel real estate for its more populated land masses. 
 
 To use our pixel real estate most effectively, we’ll draw the world map full screen, covering the complete `width` and `height` of the Android screen and introducing some additional distortion to our data visualization due to the device’s own aspect ratio. Because both the map and the location data scales depend on the display `width` and `height`, our information remains geographically accurate. 
 
 ![](images/Data/Earthquakes.png)
#####Figure 9.3 - Earthquakes reported worldwide during the last hour.
######The device location is indicated by a green circle. Red circles indicate the locations of earthquakes reported within the hour&—the size and pulse frequency indicate their magnitude. 

 Using a data file that is hosted online changes the way we load the file into Processing’s `Table` class. Unlike our earlier examples, where we loaded the file from the Android’s storage, we won’t know ahead of time whether we can successfully connect to the file due to a very slow or an absent Internet connection, for instance. So we’ll use the `try` `catch` construct we’ve seen in <!--ref linkend="code.data.write-->, again to attempt loading from the online source. If it fails, catch the exception and load a data sample stored in our sketch’s `data` folder as a fallback. 
 
 Let’s take a look at the code. 
 
#####code/Data/DataEarthquakes/DataEarthquakes.pde
[include](code/Data/DataEarthquakes/DataEarthquakes.pde)
  
 Here are the steps we need to take to load and visualize the data. 
 1. Define an `src` string containing the `URL` to the data source hosted online. 
 2. Load the data into the `earthquakes` `Table` object using the `header, csv` to indicate that we have a header row and use a comma-separated data structure. 
 3. Use the fallback local data source `all_hour_2015-02-24.txt` stored in the `data` folder of our sketch if the connection to the online source fails. The local file is a sample of the online source using the same data structure. 
 4. Draw the world map fullscreen over the screen’s `width` and `height`, with the upper left image corner placed at the origin. 
 5. Get the longitude of the individual earthquake stored in each table row as a floating point number from the field index number `2`, which is the sixth column in our data source. 
 6. Get the latitude of the earthquake as a `float` from the field index number `1`. 
 7. Get the magnitude of the earthquake as a `float` from the field index number `4`. 
 8. Map the retrieved longitude value to the map’s visual degree range (matching the Earth’s degree range) of `-180..180`, and assign it to the horizontal position `x` on the screen. 
 9. Map the retrieved latitude value to the map’s visual degree range of `85..-60`, and assign it to the vertical position `y` on the screen. 
 10. Map the dimension of the red circles visualizing the earthquakes based on their individual `magnitude`s. 
 11. Calculate a blink frequency for the red circles based on the milliseconds ([`millis()`][21]) passed since the app started, modulo 1000 milliseconds, resulting in a frequency of once per second, and then divide it by the earthquake’s magnitude to blink faster for greater magnitudes. 
 12. Use the blink frequency variable `freq` to control the alpha transparency of the red ellipses with the `RGB` value `color(255, 127, 127)`. 
 13. Create a new Android `Location` object “quake,” and set it to the latitude and longitude of the individual earthquake. 
 14. Calculate the distance of the current device `location` stored in the `KetaiLocation` object, and compare it to the `quake` location stored in the Android object. Divide the resulting number in meters by `1609.34` to convert it to miles. 
 15. Draw a circle with a gray outline indicating the distance of the current location to the earthquake. Use Processing’s distance method `dist()` to calculate the distance between both points on the screen, and draw an ellipse with a width and a height of double that distance. 
 16. Draw a text label indicating the distance from the current device location to the earthquake at the position of the earthquake on the screen. 
 17. Draw a slowly animated green circle to indicate the current device’s location on the map. The pulse rate is one second for a 100-foot accuracy, or 0.1 seconds for a 10-foot accuracy. 
 
Let’s look at the `Location` tab next, which includes all the necessary code to determine the location of our device. It’s very similar to our <!--ref linkend="code.geolocation-->. 
 
#####code/Data/DataEarthquakes/Location.pde
[include](code/Data/DataEarthquakes/Location.pde)
 
 Here’s what we need to do to determine our device location. 
 1. Create a `KetaiLocation` variable named `location`. 
 2. Create two floating point number variables to store the *x* and *y* position of the device relative to the world map so we can use it in `draw()`. 
 3. Map the `lon` value we receive from the Location Manager relative to the screen width. 
 4. Map the `lat` value we receive from the Location Manager relative to the screen height. 
 5. Assign the accuracy value we receive from the Location Manager to the global `accuracy` variable, and use it for the blink rate of the green ellipse indicating the current device’s location. 
 
Let’s test the app now. 

###Run the App
 
We need to make sure we set the correct Android permissions again to run this sketch. Not only do we need to select `INTERNET` from the Android Permission Selector under Sketch Permissions, we also need to check `ANDROID_COARSE_LOCATION` at least, or if we want to know it more accurately we check `ANDROID_FINE_LOCATION` as well. A couple of hundred feet matter less in this application, so the Fine Location is optional. 
 
Run the sketch on your device. When it starts up, the app will try to connect to the data source online. If your device doesn’t have a connection to the Internet, it will catch the exception (“Failed to open online stream reverting to local data”) and load a sample stored as a fallback inside our data folder. 
 
Your device might not have an updated coarse location available, so it might take a couple of seconds until the green circle moves into the correct location on the world map; the gray concentric circles are tied to the (green) device location and indicate the distance to each individual earthquake. 

###Try Another Source
 
Try another source from the [`USGS`’s data feed,][22] where you can find `CSV` files containing other earthquake data using the same file structure we’ve seen earlier in the <!--ref linkend="code.data.earthquakes.source-->. 
 
 Replace the `src` text string with this `URL`: 
 
 http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv 

Now rerun the code. Looking at the seven-day-period visualization, you can see how vibrant our planet is, even though we’ve limited the scope of the application to [earthquakes][23] of magnitude 2.5 and higher. In terms of their physical impact, experts say earthquakes of magnitude 3 or lower are almost imperceptible, while earthquakes of magnitude 7 and higher can cause serious damage over large areas.
 
 Because the comma-separated data structure of this seven-day-period data file is identical to the one we used earlier in the last hour, we don’t have to do anything else besides replace the source `URL`. The app loads the additional data rows containing the earthquake data and displays it independent of how many earthquakes are reported, as shown in <!--ref linkend="fig.earthquakes.past.week" thispage="yes-->. 

![](images/Data/EarthquakesSevenDays.png)
#####Figure 9.4 - Earthquakes reported worldwide during the last seven days.
######Only earthquakes with a magnitude of 2.5 and higher are included in this data source. 

Let’s now refine the earthquake app using a feature that we’re quite familiar with&—device vibration. 

###Add Vibes to the Earthquake App
 
How much we know and care about earthquakes and the alert systems that are used to warn people about them probably depends on where you live and what kind of incident history your area has. Clearly the earthquake app we’ve developed so far has educational value and is not designed as a warning system. Wouldn’t it be great, though, if we could keep the app running and receive a notification when a new earthquake incident is reported? Maybe, but we have neither the time nor the attention span to keep looking at our device screen, so let’s use a very familiar feedback device built into our Android, the tiny `DC` motor that makes it vibrate. 
 
We can take this quite literal translation from Earth’s vibrations to device vibrations quite far, as we can control the duration of each device’s vibrations and can even use a vibration pattern. So let’s refine our earthquake app by mapping each individual earthquake magnitude to an individual vibration duration and the number of earthquakes to the number of vibrations. Furthermore, we can continue to check the online data source for reports of new earthquakes and vibrate the device each time a new one appears. We won’t modify the visual elements of the app any further, but we’ll focus on manipulating the audio-tactile response from the vibration motor built into the device to give us the effect we want. 
 
To refine our app in this way, we can work with `KetaiVibrate`, which gives us straightforward access to the device’s vibration motor. We’ll also need an additional Processing `Table` object so we can compare our data to the data received from the live data source and add new quakes to the `earthquakes` `Table` when we determine they have occurred. 
 
Let’s take a look at the code, focusing on the `vibrate()` and `update()` methods that provide the functionality we’re looking for. Besides the main tab, we’ll use the `Location` tab we’ve seen already in the previous iteration of the app in the <!--ref linkend="code.data.earthquakes.location-->. 
 
 #####code/Data/DataEarthquakesShake/DataEarthquakesShake.pde
 [include](code/Data/DataEarthquakesShake/DataEarthquakesShake.pde)
 
 Let’s take a look at the modifications we need to make to frequent updates and add vibration feedback to the earthquake app. 
 1. Create a `motor` variable of type `KetaiVibrate`. 
 2. Create the `KetaiVibrate` object `motor`. 
 3. Check if the ten-second interval has expired. 
 4. Check if the device has a vibration motor built in and available. 
 5. Vibrate the device motor using the `KetaiVibrate` method `vibrate()` using the vibration `pattern` as the first parameter and “no-repeat” (`-1`) as the second parameter. 
 6. Iterate through the `earthquakes` table; determine the number of rows contained in it using `getRowCount()`. 
 7. Add a new row into the `history`. 
 8. Set the new row in the `history` table to the new entry found in the `earthquakes` table. 
 9. Get the magnitude of the new entry we’ve found. 
 10. Create an array of `long` numbers to be parsed into the `vibrate()` method as a duration pattern. 
 11. Call the `vibrate` method using the `pattern` we’ve assembled as an array of `long` numbers. 
 12. Create a `boolean` custom method to iterate through a table and find a specific `String` entry we call `needle`. Use the table name, the column index number we are searching in, and the `needle` as parameters for the method. 
 13. Iterate through the table `t` contents in column `col`, and compare the entry to the `needle`. Return `true` if we find a matching entry, and `false` if we don’t. 
 
 Let’s test the sketch. 

###Run the App
 
Run the sketch on your device. Visually, everything looks familiar. Every ten seconds the app is checking back to the `EPA`’s server for updates. When the app detects a new earthquake, you’ll hear the device vibrate briefly. A 2.5-magnitude earthquake results in a quarter-second vibration. If you receive two or more updates, you’ll hear two or more vibrations. 
 
When earthquakes disappear from the data source hosted by the `EPA`, we still keep them in our `history` `Table`. So for as long as the app is running, we’ll accumulate earthquake records, and we show them all collectively on the world map. 

This completes our earthquake app as well as our investigation in comma- and tab-separated data structures. 

###Wrapping Up
 
This concludes our examination of databases and tables, a highly relevant subject when developing mobile applications. You’ll be able to read and write data to the Android into private and public directories and work with comma- and tab-separated values. This will allow you to save settings and application states so you can get your users started where you left off. 
 
For more complex projects, where our interactions with the data become more complicated and our questions more detailed, we might need to work with a database, which gives us the crucial features to search, sort, and query the data we are working with. The most commonly used local database management system on mobile devices is SQLite, which we'll learn about in the next chapter.  

[0]: http://search.oreilly.com/?q=database
[1]: http://developer.android.com/reference/android/os/Environment.html
[2]: http://docs.oracle.com/javase/1.4.2/docs/api/java/io/File.html
[3]: http://docs.oracle.com/javase/6/docs/api/java/net/URL.html
[4]: http://docs.oracle.com/javase/1.4.2/docs/api/java/io/BufferedReader.html
[5]: http://docs.oracle.com/javase/1.4.2/docs/api/java/io/InputStreamReader.html
[6]: http://ketai.org/reference/ui/ketaivibrate
[7]: http://ketai.org/reference/ui/ketaivibrate
[8]: http://developer.android.com/guide/topics/data/data-storage.html
[9]: http://cloud.google.com/try.html
[10]: http://developer.android.com/guide/google/gcm/
[11]: https://developers.google.com/drive/integrate-android-ui
[12]: www.w3.org/MarkUp/Guide/Style
[13]: http://processing.org/reference/translate_.html
[14]: http://processing.org/reference/String_substring_.html
[24]: http://processing.org/reference/unhex_.html.
[15]: http://www.w3.org/2009/sparql/docs/csv-tsv-results/results-csv-tsv.html
[16]: http://wiki.processing.org/w/Exceptions
[17]: http://developer.android.com/reference/android/os/Environment.html
[18]: http://www.census.gov/
[19]: http://commons.wikimedia.org/wiki/File:Timezones2008-GE.png
[20]: http://en.wikipedia.org/wiki/Equirectangular_projection
[21]: http://processing.org/reference/millis_.html
[22]: http://earthquake.usgs.gov/earthquakes/feed/v1.0/csv.php
[23]: http://en.wikipedia.org/wiki/Earthquake