# HapticLock

Although PIN entry is widely used for mobile authentication, as a primary tool or fallback mechanism, it is vulnerable to several types of side-channel attacks including shoulder surfing, smudge and thermal attacks. 

Visual output and fingertip traces can be exploited by attackers to gain unauthorised access to a system (e.g., by watching or recording which icons a user taps when entering their PIN).

HapticLock is a novel, eyes-free mobile authentication system, which uses haptic cues based on Morse code to guide non-visual PIN entry. The touch gestures required for non-visual PIN entry (which are similar to the Scroll input method explored by Chen *et al.* [[1]](#1)) will cause overlapping marks to appear on the screen, making the resulting heat traces and smudges difficult to decipher [[2]](#2).

HapticLock was created for an undergraduate MSci research project titled: 'HapticLock: Evaluating Eyes-free Authentication Resistant to Shoulder Surfing'. 

HapticLock was evaluated in three user studies for the project. Feedback gained from the first usability study was used to refine the system. Subsequent findings showed that HapticLock is capable of mitigating video-based shoulder surfing attacks when the screen is obscured (i.e., when the mobile device is held in the user's pocket during authentication) or when the screen is visible to the attacker (i.e., from a clear over-the-shoulder viewpoint) and the authentication process begins at a random number. 

While HapticLock requires more time for authentication compared to standard PIN entry, results show that it has a low error rate and its haptic cues can be learned quickly by users with no prior experience interpreting Morse code. HapticLock is therefore suitable for use on demand when users attempt to access sensitive information or execute personal transactions, mitigating shoulder surfing and other side-channel attacks.

This work was extended by academic staff at the University of Glasgow and accepted at the 23rd ACM International Conference on Multimodal Interaction. The published paper and supplemental material is accessible [here](http://dx.doi.org/10.1145/3462244.3481001).

If you would like to know more about the research or have other enquires, please send an email to [hapticpatternlock@gmail.com](mailto:hapticpatternlock@gmail.com).

## Local Deployment

### Prerequisites

* iPhone running iOS 13.2+
* Xcode 

### Steps

1. Open workspace (HapticLock.xcworkspace) in Xcode
2. Go to Product -> Scheme and select HapticLock
3. Connect iPhone to computer and select connected device from dropdown menu (near the stop button on the top left of the screen)
4. Select the play button to run the app (to do this you may need to trust the developer profile by following the steps outlined [here](https://apple.stackexchange.com/questions/206143/ios-untrusted-developer-error-when-testing-app/206144))

## Guide to Using the App

### General Information

Before using the app, please familiarise yourself with Morse code for digits from 0 to 9 inclusive by using this [Morse code translator](https://morsecode.world/international/translator.html).

When you open the app, you will be presented with a menu of options with predefined PINs/passcodes which can be found [here](https://github.com/gdcodes/HapticLock/blob/main/HapticLock/HapticLock/HapticLock/PredefinedValues.swift).

If you tap one of the options, you will be taken to a blank screen where you can enter the corresponding predefined PIN by using the relevant touch gestures mentioned below. If you enter the wrong PIN, the standard iOS haptic feedback will be generated to indicate a failed attempt and the digits that you entered will be erased; otherwise, you will be taken to a screen representing the 'Home' screen with a welcome message.

### Version 2.0+

The system recognises the following gestures:
* Swipe up: increment current number and play haptic pattern for that number 
* Swipe down: decrement current number and play haptic pattern for that number 
* Double tap: select current number and play short haptic pulse 
* Two-finger tap: undo last selected number and play short haptic pulse 
* Long press: play “dots” or short haptic pulses to indicate how many digits have been selected

The current number will always be between 0 and 9 inclusive, e.g., swiping up from 0 takes you to 1 and swiping down from 0 takes you to 9. 

Only 4-digit PIN entry is supported, with the authentication process either starting from zero or from a random number.

### Version 1.0

The system recognises the following gestures:
* Swipe up: increment current number and play haptic pattern for that number 
* Swipe down: decrement current number and play haptic pattern for that number 
* Swipe right: select current number and play short haptic pulse 
* Swipe left: undo last selected number and play short haptic pulse

The current number will always be between 0 and 9 inclusive, e.g., swiping up from 0 takes you to 1 and swiping down from 0 replays the haptic pattern for 0. 

4-digit and 6-digit PIN entry is supported. The authentication process will start from zero.

## Built With

* [Swift](https://developer.apple.com/swift) 
* [Core Haptics](https://developer.apple.com/documentation/CoreHaptics) 
* [Xcode](https://developer.apple.com/xcode) 

## Versioning

For the versions available, see the [tags on this repository](https://github.com/gdcodes/HapticLock/releases). 

## Licensing 

HapticLock is MIT licensed. See [LICENSE](https://github.com/gdcodes/HapticLock/blob/main/LICENSE) for the full license text.

## References

<a id="1">[1]</a> 
C. Chen, S. H. Chua, D. Chung, S. T. Perrault,
S. Zhao, and W. Kei. Eyes-free gesture passwords: a comparison of various eyes-free input methods. In Proceedings of the Second International Symposium of Chinese CHI, Chinese CHI ’14, New York, NY, USA, Apr. 2014. Association for Computing Machinery. [DOI](https://doi.org/10.1145/2592235.2592248).

<a id="2">[2]</a> 
Y. Abdelrahman, M. Khamis, S. Schneegass, and
F. Alt. Stay Cool! Understanding Thermal Attacks on Mobile-based User Authentication. In Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems, CHI ’17, New York, NY, USA, May 2017. Association for Computing Machinery. [DOI](https://dl.acm.org/doi/10.1145/3025453.3025461).
