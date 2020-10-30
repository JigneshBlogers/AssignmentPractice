
import UIKit
class BaseViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "okay", style: .default) { (_) in }
        alert.addAction(action)
        self.present(alert, animated: false)
    }
}
