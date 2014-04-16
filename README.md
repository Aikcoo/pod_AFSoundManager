AFSoundManager
==============

iOS audio playing (both local and streaming) made easy through a complete and block-driven Objective-C class. AFSoundManager uses AudioToolbox and AVFoundation frameworks to serve the audio. You can pick a local file or you can use a URL to stream the audio, the choice is up to you.

##Installation

AFSoundManager is available on CocoaPods so you can get it by adding this line to your Podfile:
	
	pod 'AFSoundManager', '~> 1.0'
	
If you don't use CocoaPods, you will have to import these files into your project:

	AFSoundManager.h
	AFSoundManager.m
	AFAudioRouter.h
	AFAudioRouter.m

Also, you need to import the ```AudioToolbox``` framework and te ```AudioFoundation``` framework.

##Usage

First of all, make sure that you have imported both classes into the class where you are going to play audio.

	#import "AFSoundManager.h"
	#import "AFAudioRouter.h"
	
Then, you only need to call one method to start playing your audio.

###Local playing
If you need to play a local file, call ```-startPlayingLocalFileWithName:andBlock:```

Example:

	[[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"filename.mp3" andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error) {
        
        if (!error)
        	//This block will be fired on every single integer percententage (from 0 to 100)
        } else {
        	//Handle the error
        }
    }];
    
###Audio streaming
For remote audio, call ```-startStreamingRemoteAudioFromURL:andBlock:```

Example:

	[[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:@"http://www.example.com/audio/file.mp3" andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error) {
        
        if (!error)
        	//This block will be fired on every single integer percententage (from 0 to 100)
        } else {
        	//Handle the error
        }
    }];

###Control
If you need to pause, resume or stop the current playing, guess what, there's a method for that!

	[[AFSoundManager sharedManager]pause];
	[[AFSoundManager sharedManager]resume];
	[[AFSoundManager sharedManager]stop];
	[[AFSoundManager sharedManager]restart];

For going back or forward, you have to specify the second where to continue playing the audio by calling ```-moveToSecond:```

For example, if you need to move the audio to the second 288, call

	[[AFSoundManager sharedManager]moveToSecond:288];

In order to change the volume, call ```-changeVolumeToValue:``` by passing a decimal number between 0.000000 (mute) and 1.000000 (maximum volume). Example:

	[[AFSoundManager sharedManager]changeVolumeToValue:0.750000]; //This will put the volume at 75%
	
###Playing information
When you start a new playing the blocks will retreive you some information about the playing every single percent. The info given will be the percentage played, the elapsed time and the time remaining. It will also retrieve a NSError so you can check if there's any error playing the audio.

If you want to get this information even if the playing is paused, ```-retrieveInfoForCurrentPlaying``` will give you a NSDictionary with all the information.

###Output manage
AFSoundManager also lets you choose which device do you want to use to play the audio. I mean, even if you have your headphones plugged in, you can force the audio to play on the built-in speakers or play it through the headphones.

If the headphones (or any external speaker) are plugged in and you want to play it on the built-in speakers, call:

	[[AFSoundManager sharedManager]forceOutputToBuiltInSpeakers];
	
If you want to play it through the default device (in this case the headphones or the external speaker) call

	[[AFSoundManager sharedManager]forceOutputToDefaultDevice];

And if you want to check if the headphones, or a external speaker, are currently plugged it on the device, check it with ```-areHeadphonesConnected```. Example:

	if ([[AFSoundManager sharedManager]areHeadphonesConnected]) {
		//Headphones connected
	} else {
		//Headphones NOT connected
	}
	
##License
AFSoundManager is under MIT license so feel free to use it!

##Author
Made by Alvaro Franco. If you have any question, feel free to drop me a line at [alvarofrancoayala@gmail.com](mailto:alvarofrancoayala@gmail.com)