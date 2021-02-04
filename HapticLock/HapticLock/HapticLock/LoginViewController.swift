import UIKit
import CoreHaptics
import HapticMorse

class LoginViewController: UIViewController {

    private var hapticManager: HapticMorse.HapticManager?
    private var observer: NSKeyValueObservation?
    private var pinEntry = PinEntry()
    private var feedbackGenerator = UINotificationFeedbackGenerator()
    var pin: String = "0000"
    private var currentNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapticManager = HapticMorse.HapticManager()

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
 
        observer = pinEntry.observe(\.entry) { [weak self] object, change in
            guard let self = self else { return }
            if object.entry.count == self.pin.count {
                if self.pin == object.entry {
                    // ONLY For Development
                    print(object.entry)
                    print("SUCCESS! AUTHENTICATED.")
                    
                    // Reset observable data
                    self.resetPinEntry()
                    // Display home screen
                    guard let scene = self.storyboard?.instantiateViewController(withIdentifier: "Home") else { return }
                    scene.modalPresentationStyle = .fullScreen
                    self.present(scene, animated:true, completion:nil)
                } else {
                    // ONLY For Development
                    print("FAILED TO AUTHENTICATE.")
                    self.feedbackGenerator.notificationOccurred(.error)
                }
            }
        }
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {

        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            if currentNum < Digit.maxValue {
                currentNum += 1
            }
            
            hapticManager?.playTacton(currentNum)
            
            // ONLY For Development
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            if currentNum > Digit.minValue {
                currentNum -= 1
            }
            
            hapticManager?.playTacton(currentNum)
            
            // ONLY For Development
            print("Swipe Down")
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if pinEntry.entry.count < pin.count {
                pinEntry.entry += String(currentNum)
            }
                
            // ONLY For Development
            print(pinEntry.entry.description)
            
        } else {
            undoLastEntry()
            
            // ONLY For Development
            print(pinEntry.entry.description)
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
