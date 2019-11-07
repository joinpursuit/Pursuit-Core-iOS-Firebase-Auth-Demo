import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var validUserCredentials: (email: String, password: String)? {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              emailFieldIsValid() else {
                return nil
        }
        
        return (email, password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInUser(_ sender: Any) {
        guard let validCredentials = validUserCredentials else { return }
        FirebaseAuthService.manager.loginUser(withEmail: validCredentials.email,
                                              andPassword: validCredentials.password) { [weak self] (result) in
                                                let alertTitle: String
                                                let alertMessage: String
                                                switch result {
                                                case let .success(user):
                                                    alertTitle = "Login Success"
                                                    alertMessage = "Logged in user with email \(user.email ?? "no email") and id \(user.uid)"
                                                case let .failure(error):
                                                    alertTitle = "Login Failure"
                                                    alertMessage = "An error occurred while logging in: \(error)"
                                                }
                                                self?.presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
        }
    }
    
    @IBAction func createNewUserAccount(_ sender: Any) {
        guard let validCredentials = validUserCredentials else { return }
        FirebaseAuthService.manager.createNewUser(withEmail: validCredentials.email,
                                                  andPassword: validCredentials.password) { [weak self] (result) in
                                                    let alertTitle: String
                                                    let alertMessage: String
                                                    switch result {
                                                    case let .success(user):
                                                        alertTitle = "Success - New Account Created"
                                                        alertMessage = "Created user with email \(user.email ?? "no email") and id \(user.uid)"
                                                    case let .failure(error):
                                                        alertTitle = "Create user failure"
                                                        alertMessage = "An error occurred while creating an account: \(error)"
                                                    }
                                                    self?.presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
        }
    }
    
    private func emailFieldIsValid() -> Bool {
        return true
    }
    
    private func presentGenericAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
