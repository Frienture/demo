//
//  DatabaseManager.swift
//  demo
//
//  Created by macbookpro on 19/9/2021.
//

import Foundation
import Firebase
import UIKit

final class DatabaseManager {
    
    static func safeId(id: String) -> String {
        var safeId = id.replacingOccurrences(of: ".", with: "-")
        safeId = safeId.replacingOccurrences(of: "@", with: "-")
        safeId = safeId.replacingOccurrences(of: "#", with: "-")
        safeId = safeId.replacingOccurrences(of: "$", with: "-")
        safeId = safeId.replacingOccurrences(of: "[", with: "-")
        safeId = safeId.replacingOccurrences(of: "]", with: "-")
        
        return safeId
    }
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    /// Inserts new user to database
    public func insertUser(with user: Users) {
        database.child("username").setValue([
            "user": "ABC",
        ])
        
        self.database.child("username").observeSingleEvent(of: .value, with: { snapshot in
            if var usersCollection = snapshot.value as? [[String:String]] {
                //append to user dictionary
                let newElement = [
                    "name": user.name
                ]
                usersCollection.append(newElement)
                self.database.child("users").setValue(usersCollection)
                
            }
            else {
                //create the array
                let newCollection :[[String:String]] = [
                    [
                        "name": user.name
                    ]
                ]
                
                self.database.child("users").setValue(newCollection)
            }
        })
    }
    
    /// Insert new Group to database
    public func insertGroup(with createGroup: Group){
        
        let newGroupData: [String: Any] = [
            "max": createGroup.max,
            "name":createGroup.name,
            "createUser": createGroup.createUser
            
        ]
        database.child("\(createGroup.id)").setValue(newGroupData)
        
        self.database.child("Groups").observeSingleEvent(of: .value, with: { snapshot in
            if var usersCollection = snapshot.value as? [[String:String]] {
                //append to user dictionary
                let newElement = [
                    "id": "\(createGroup.id)",
                    "max": createGroup.max,
                    "name":createGroup.name,
                    "createUser": createGroup.createUser
                ]
                usersCollection.append(newElement)
                self.database.child("Groups").setValue(usersCollection)
                
            }
            else {
                //create the array
                let newCollection :[[String:String]] = [
                    [
                        "id": "\(createGroup.id)",
                        "max": createGroup.max,
                        "name": createGroup.name,
                        "createUser": createGroup.createUser
                    ]
                ]
                
                self.database.child("Groups").setValue(newCollection)
            }
        })
    }
    
    
    public enum DatabaseError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
}

// MARK: - Creating Group

extension DatabaseManager {
    
    ///Fetches and returns Group Info
    public func getAllGroupInfo(for id: String, completion: @escaping (Result<[GroupInfo], Error>) -> Void) {
        database.child("Groups").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else{
                completion(.failure(DatabaseError.failedToFetch))
                
                return
            }
            
            let groups: [GroupInfo] = value.compactMap({
                dictionary in
                guard let id = dictionary["id"] as? String,
                      let name = dictionary["name"] as? String,
                      let max = dictionary["max"] as? String else {
                    return nil
                }
                
                return GroupInfo(id: id,
                                 name: name,
                                 max: max,
                                 imageURL: UIImage(named: "tennis-origins")!)
            })
            
            completion(.success(groups))
        })
    }
    
}


