//
//  UserStorage.swift
//  Navigation
//
//  Created by Миша on 02.03.2022.
//

import Foundation

class UserStorage {
    private lazy var defaults = UserDefaults.standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    static let shared: UserStorage = .init()
    
    var users: [String: UserInfo] = [:] {
        didSet {
            save()
        }
    }
    
    func saveUser(login: String, email: String) {
        
        let addUsers = UserInfo(login: login, email: email)
        self.users[email] = addUsers
        
    }
    
    private func save(){
        
        do {
            let data = try encoder.encode(users)
            defaults.setValue(data, forKey: "user")
        }
        catch {
            print("Ошибка кодирования", error)
        }
    }
    
    private init() {
        guard let data = defaults.data(forKey: "user") else {
            return
        }
        do {
            users = try decoder.decode([String: UserInfo].self, from: data)
        }
        catch {
            print("Ошибка декодирования", error)
        }
    }
}
