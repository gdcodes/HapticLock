import UIKit
import CoreHaptics
import HapticMorse

class LoginViewController: UIViewController {

    private var hapticManager: HapticMorse.HapticManager?
    private var observer: NSKeyValueObservation?
    private var pinEntry = PinEntry()
    private var feedbackGenerator = UINotificationFeedbackGenerator()
    var pin: String = "0000"
    var attemptNum: Int = 0
    var currentNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapticManager = HapticMorse.HapticManager()

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTwoFingerTap))
        twoFingerTap.numberOfTapsRequired = 1
        twoFingerTap.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoFingerTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(sender:)))
        self.view.addGestureRecognizer(longPress)
 
        observer = pinEntry.observe(\.entry) { [weak self] object, change in
            guard let self = self else { return }
            if object.entry.count == self.pin.count {
                self.attemptNum += 1
                if self.pin == object.entry {
                    // ONLY For Development
                    print(object.entry)
                    print("SUCCESS! AUTHENTICATED.")
                    print("WITH \(self.attemptNum) ATTEMPT(S).")
                    
                    // Reset observable data
                    self.resetPinEntry()
                    // Display home screen
                    if let scene = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController {
                        scene.modalPresentationStyle = .fullScreen
                        self.present(scene, animated:true, completion:nil)
                    }
                } else {
                    // ONLY For Development
                    print("FAILED TO AUTHENTICATE.")
                    self.hapticManager?.stop()
                    self.feedbackGenerator.notificationOccurred(.error)
                    self.resetPinEntry()
                }
            }
        }
    }
    
    @objc func handleTwoFingerTap() {
        undoLastEntry()
        self.feedbackGenerator.notificationOccurred(.success)

        // ONLY For Development
        print(pinEntry.entry.description)
    }
    
    @objc func handleDoubleTap() {
        selectEntry()
        self.feedbackGenerator.notificationOccurred(.success)
            
        // ONLY For Development
        print(pinEntry.entry.description)
    }
    
    // Play haptic patten to indicate how many digits have been entered
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            hapticManager?.playTacton(pinEntry.entry.count, "Size")
        }
    }

    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) -> Void {

        switch(gesture.direction) {
        case(UISwipeGestureRecognizer.Direction.up):
            if currentNum < Digit.maxValue {
                currentNum += 1
            } else {
                // If user swipes up at 9, move to 0
                currentNum = 0
            }
            
            hapticManager?.playTacton(currentNum)
            
            // ONLY For Development
            print("Swipe Up")
        case(UISwipeGestureRecognizer.Direction.down):
            if currentNum > Digit.minValue {
                currentNum -= 1
            } else {
                // If user swipes down at 0, move to 9
                currentNum = 9
            }
            
            hapticManager?.playTacton(currentNum)
            
            // ONLY For Development
            print("Swipe Down")
        default:
            break
        }
    }
    
    func selectEntry() {
        if pinEntry.entry.count < pin.count {
            pinEntry.entry += String(currentNum)
        }
    }
    
    func undoLastEntry() {
        if !pinEntry.entry.isEmpty {
            pinEntry.entry.removeLast();
        }
    }
    
    func resetPinEntry() {
        pinEntry.entry = ""
    }
}
