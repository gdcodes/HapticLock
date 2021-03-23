import UIKit

class SetupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LoginViewController {
            vc.isModalInPresentation = true
            
            switch(segue.identifier) {
            case ("fourDigitOptionOneFromZero"):
                vc.pin = FourDigitPasscode.optionOne
            case ("fourDigitOptionTwoFromZero"):
                vc.pin = FourDigitPasscode.optionTwo
            case ("fourDigitOptionThreeFromZero"):
                vc.pin = FourDigitPasscode.optionThree
            case ("fourDigitOptionOneFromRand"):
                vc.pin = FourDigitPasscode.optionOne
                vc.currentNum = Int.random(in: 0...9)
            case ("fourDigitOptionTwoFromRand"):
                vc.pin = FourDigitPasscode.optionTwo
                vc.currentNum = Int.random(in: 0...9)
            case ("fourDigitOptionThreeFromRand"):
                vc.pin = FourDigitPasscode.optionThree
                vc.currentNum = Int.random(in: 0...9)
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
}
