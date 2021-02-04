import UIKit

class SetupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LoginViewController {
            vc.isModalInPresentation = true
            
            switch(segue.identifier) {
            case ("fourDigitOptionOne"):
                vc.pin = FourDigitPasscode.optionOne
            case ("fourDigitOptionTwo"):
                vc.pin = FourDigitPasscode.optionTwo
            case ("fourDigitOptionThree"):
                vc.pin = FourDigitPasscode.optionThree
            case ("sixDigitOptionOne"):
                vc.pin = SixDigitPasscode.optionOne
            case ("sixDigitOptionTwo"):
                vc.pin = SixDigitPasscode.optionTwo
            case ("sixDigitOptionThree"):
                vc.pin = SixDigitPasscode.optionThree
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
}
