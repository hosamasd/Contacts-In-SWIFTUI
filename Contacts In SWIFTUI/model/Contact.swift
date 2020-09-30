//
//  Contact.swift
//  Contacts In SWIFTUI
//
//  Created by Hossam on 9/29/20.
//

import UIKit

class Contact:NSObject {
    let name:String
    var isFavorite = false
    
    init(name:String) {
        self.name=name
    }
}

enum SectionType:String {
    case ceo,passants
}
