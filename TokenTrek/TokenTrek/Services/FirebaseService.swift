//
//  FirebaseService.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 31.05.2023.
//

import Foundation
import Firebase

protocol FirebaseServiceProtocol {
    func signUp(email: String, password: String, completion: @escaping (SignUpResult) -> Void)
    func signIn(email: String, password: String, completion: @escaping (SignInResult) -> Void)
    func signOut()
    func updateFavoriteCoins(_ coins: [String])
}

final class FirebaseService: FirebaseServiceProtocol {
    
    static let shared: FirebaseService = .init()

    func signUp(email: String, password: String, completion: @escaping (SignUpResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    let db = Firestore.firestore()
                    
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    
                    UserDefaults.standard.set(result.user.uid, forKey: "uid")
                    
                    db.collection("users").document(uid).setData([
                        "email": email,
                        "password": password,
                        "favoriteCoins": [""],
                        "uid": result.user.uid
                    ]) { error in
                        if error != nil {
                            completion(.failure(error!))
                        }
                    }
                }
                completion(.succes)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (SignInResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("Sign In Succesful")
                print(result?.user.uid ?? "")
                UserDefaults.standard.set(result?.user.uid, forKey: "uid")
                completion(.succes)
            } else {
                print(error?.localizedDescription ?? "")
                completion(.failure(error!))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "uid")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateFavoriteCoins(_ coins: [String]) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.updateData([
            "favoriteCoins": coins
        ]) { error in
            if let error = error {
                print("Error updating favorite coins: \(error.localizedDescription)")
            } else {
                print("Favorite coins updated successfully")
            }
        }
    }
    
    func getFavoriteCoins(comletion: @escaping ([String]) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let favoriteCoins = data?["favoriteCoins"] as? [String] {
                    comletion(favoriteCoins)
                }
            } else {
                comletion([])
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
