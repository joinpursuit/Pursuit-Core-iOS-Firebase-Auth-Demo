import Foundation
import FirebaseAuth

enum GenericError: Error {
    case unknown
}

class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    let firebaseAuth = Auth.auth()
    private init() {}
    
    func loginUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                onCompletion(.success(user))
            } else {
                onCompletion(.failure(error ?? GenericError.unknown))
            }
        }
    }
    
    func createNewUser(withEmail email : String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                onCompletion(.success(createdUser))
            } else {
                onCompletion(.failure(error ?? GenericError.unknown))
            }
        }
    }
}
