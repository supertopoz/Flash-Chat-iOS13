//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Jason.Allshorn on 2020/12/01.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct K {
    
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct Errors {
        static let authErrorTitle = "Authentication Error"
        static let errorAlternative = "Opps! Something went wrong"
    }
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}