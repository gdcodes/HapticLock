import UIKit
import CoreHaptics
import HapticMorse

class ViewController: UIViewController {

    private var hapticManager: HapticMorse.HapticManager?
    var currentNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapticManager = HapticMorse.HapticManager()

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {

        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
            
            if currentNum <= 8 {
                currentNum += 1
            }
            
            // ONLY For Development
            Toast.show(message: "You swiped UP! Current number: \(currentNum)", controller: self)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            print("Swipe Down")
            
            if currentNum >= 1 {
                currentNum -= 1
            }
            
            // ONLY For Development
            Toast.show(message: "You swiped DOWN! Current number: \(currentNum)", controller: self)
        }
        
        hapticManager?.playTacton(currentNum)
    }
}
