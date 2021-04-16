# HapticLock

Although PIN entry is widely used for mobile authentication, as a primary tool or fallback mechanism, it is vulnerable to several types of observational/side-channel attacks including smudge attacks, thermal attacks and shoulder surfing. 

Shoulder surfing refers to the practice of observing someone to gain unauthorised access to private information. Visual output provides observational attackers with context for touchscreen interaction (e.g., allowing them to identify a PIN by watching which icons the user taps).

HapticLock is a novel, eyes-free mobile authentication system, which uses haptic cues based on Morse code to guide non-visual PIN entry. 

This project involves extending the audio-assisted scroll input method explored by Chen *et al.* [[1]](#1) and investigating the use of haptic cues, instead of audio, to support the interaction. The scroll input method for PIN entry offers resistance to smudge and thermal attacks as the trace of vertical swipe gestures will overlap and change as the user scrolls (e.g., scrolling too quickly and then reversing back) making the resulting marks and heat traces difficult to decipher [[2]](#2).

## Local Deployment

### Prerequisites

* iPhone running iOS 13.2+
* Xcode 

### Steps

1. Open workspace (HapticLock.xcworkspace) in Xcode
2. Go to Product -> Scheme and select HapticLock
3. Connect iPhone to computer and select connected device from dropdown menu (near the stop button on the top left of the screen)
4. Select the play button to run the app (note: you may need to trust developer profile by following the steps outlined [here](https://apple.stackexchange.com/questions/206143/ios-untrusted-developer-error-when-testing-app/206144).

## Guide to Using the App

### Version 2.0+

The system recognises the following gestures:
* Swipe up: increment current number and play haptic pattern for that number 
* Swipe down: decrement current number and play haptic pattern for that number 
* Double tap: select current number and play short haptic pulse 
* Two-finger tap: undo last selected number and play short haptic pulse 
* Long press: play “dots” or short haptic pulses to indicate how many digits have been selected

The current number will always be between 0 and 9 inclusive, e.g., swiping up from 0 takes you to 1 and swiping down from 0 takes you to 9. 

### Version 1.0

The system recognises the following gestures:
* Swipe up: increment current number and play haptic pattern for that number 
* Swipe down: decrement current number and play haptic pattern for that number 
* Swipe right: select current number and play short haptic pulse 
* Swipe left: undo last selected number and play short haptic pulse

The current number will always be between 0 and 9 inclusive, e.g., swiping up from 0 takes you to 1 and swiping down from 0 replays the haptic pattern for 0. 

### General

Before using the app, please familiarise yourself with Morse code for digits from 0 to 9 inclusive by using this [Morse code translator](https://morsecode.world/international/translator.html).

When you open the app, there will be a menu of options with predefined PINs or passcodes which can be found [here](https://github.com/gdcodes/HapticLock/blob/main/HapticLock/HapticLock/HapticLock/PredefinedValues.swift).

If you tap one of the options, you will be taken to a blank screen where you can enter the corresponding predefined PIN by using the aforementioned touch gestures. If you enter the wrong PIN, the standard haptic feedback will be generated; otherwise, you will be taken to a screen representing the 'Home' screen with a welcome message.

## Built With

* [Swift](https://developer.apple.com/swift) 
* [Core Haptics](https://developer.apple.com/documentation/CoreHaptics) 
* [Xcode](https://developer.apple.com/xcode) 

## Versioning

For the versions available, see the [tags on this repository](https://github.com/gdcodes/HapticLock/releases). 

## References

<a id="1">[1]</a> 
C. Chen, S. H. Chua, D. Chung, S. T. Perrault,
S. Zhao, and W. Kei. Eyes-free gesture passwords: a comparison of various eyes-free input methods. In Proceedings of the Second International Symposium of Chinese CHI, Chinese CHI ’14, New York, NY, USA, Apr. 2014. Association for Computing Machinery. DOI: [https://doi.org/10.1145/2592235.2592248](https://doi.org/10.1145/2592235.2592248).

<a id="2">[2]</a> 
Y. Abdelrahman, M. Khamis, S. Schneegass, and
F. Alt. Stay Cool! Understanding Thermal Attacks on Mobile-based User Authentication. In Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems, CHI ’17, New York, NY, USA, May 2017. Association for Computing Machinery. DOI: [https://dl.acm.org/doi/10.1145/3399715.3399819](https://dl.acm.org/doi/10.1145/3399715.3399819).
