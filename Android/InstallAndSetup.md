INSTALL AND SETUP INSTRUCTIONS: MAC
==============================

Getting Processing and your device set up to talk to each other is mostly pretty straightforward, but may require a few tricks to get started.

This is mostly based on the [Processing Wiki](http://wiki.processing.org/w/Android), with a few additions and reorganizations.

####UPDATE PROCESSING
Make sure your install of Processing is up to date!

####DOWNLOAD AND INSTALL THE ANDROID SDK
1. Download the [Android SDK](http://developer.android.com/sdk) - do not download the full SDK but use the "Use An Existing IDE" link
2. Rename the folder to something like "`AndroidSDK`", move it to your preferred location (for these instructions it is placed in Developer folder of your home directory)
3.	Using [these instructions](http://developer.android.com/sdk/installing/adding-packages.html) , open the Terminal (Applications > Utilities > Terminal) and type the following:  
	
	    cd Developer/AndroidSDK/tools  
	    
	Or wherever your Android SDK is placed. Then type:  
 	   
	    android sdk  
  	
	This will open a special application where you can download and install various parts of the SDK as needed.
4. Within the SDK Manager, select the following:
	* Android 2.3.3 (API version 10) - this is the required install for Processing
	* The entire Tools folder
	* The entire Extras folder (not necessary but can't hurt)
	* You can deselect the newest version if you want to save space, but this won't break Processing if it is still installed
	* Click "Install" and accept the terms; wait a while as things download :)
5. Quit the SDK Manager

####UPDATE OR CREATE SDK PATH
Depending on your installation, you may need to update or create a "`.bash_profile`" file so the Android SDK can be found. Since the period at the start of the filename means it is a hidden file, open the Terminal and type the following command:

    defaults write com.apple.Finder AppleShowAllFiles TRUE

Then restart the Finder to see hidden files:

    killall Finder

You will now see all hidden files on your system; the .bash_profile file is likely in your user folder. Open it in a text editor, or create the file if it does not already exist. Add the following lines:

    export ANDROID_HOME=/Developer/AndroidSDK
    export PATH=/Developer/AndroidSDK/platform-tools:/Developer/AndroidSDK/tools:$PATH

"`/Developer/AndroidSDK`" should be the path to your Android installation folder; the other path's on the second line are folders within the SDK folder. Save the "`.bash_profile`" file. To hide hidden files again, use the above commands with `FALSE` instead of `TRUE,` then restart the Finder to hide the files again.

####SETTING UP YOUR DEVICE
With your computer set up, you will also need to make sure your device has "`USB Debugging`" enabled.

* On older devices, this will be in Menu > Applications > Development
* On Nexus tablets, open Settings > About Tablet, then click on the Build Number seven times to activate USB Debugging (so weird!)

####TRY IT!
Open Processing and switch to Android mode by clicking the "Java" button.  You can also develop a sketch in Java mode and switch to Android midway through development.

Open one of the example sketches in this repository. Click the Run button (which should now be renamed "Run on Device") - your sketch will compile (this may take a while), then install on your device, and finally launch!

####COMMON ERRORS
* Symbol not found: this is probably the most common error in Android development - it probably means you have not imported a required library, either for Android development (such Activity, Context, etc). For the correct import path, see the [Android Developer documentation](http://developer.android.com/develop).