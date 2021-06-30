//
//  KeychainManager.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/24.
//

import Foundation
import JWTDecode

class KeychainManager {
    
    @discardableResult class func save(jwt: String) -> Bool {
        guard let idData = jwt.data(using: String.Encoding.utf8) else { return false }
        return Keychain.save(key: "jwt", data: idData)
    }
    
    class func loadUser() -> User? {
        guard let jwtData = Keychain.load(key: "jwt") else { return nil }
        guard let jwtString = String(data: jwtData, encoding: .utf8) else { return nil }

        guard let userID = try? decode(jwt: jwtString).body["id"] as? Int else { return nil }
        let userEmail = try? decode(jwt: jwtString).body["email"] as? String ?? "user1@email.com"
        guard let userName = try? decode(jwt: jwtString).body["displayName"] as? String else { return nil }
        guard let userProfileImage = try? decode(jwt: jwtString).body["profilePhoto"] as? String else { return nil }
        
        let user = User(id: userID, email: userEmail!, name: userName, profileImage: userProfileImage)
        return user
    }
    
    @discardableResult class func delete() -> Bool {
        return Keychain.delete(key: "jwt")
    }
    
}
