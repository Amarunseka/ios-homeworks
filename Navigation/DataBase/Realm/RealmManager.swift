//
//  RealmManager.swift
//  Navigation
//
//  Created by Миша on 12.07.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private init(){}
    
    
    // MARK: - Schedule
    func saveUserModel(model: UserRealmModel) {
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(model)
            }
        } catch {
            print("Error")
        }
    }
    
    func fetchUserLogin(email: String) -> String? {
        do {
            let realm = try Realm()
            let userEmail = realm.objects(UserRealmModel.self).filter("userEmail = '\(email.lowercase)'")

            return !userEmail.isEmpty ? "\(userEmail[0].userLogin)" : nil
            
        } catch {
            print("Error")
            return nil
        }
    }
}
