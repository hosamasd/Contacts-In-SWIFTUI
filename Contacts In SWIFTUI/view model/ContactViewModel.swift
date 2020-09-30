//
//  ContactViewModel.swift
//  Contacts In SWIFTUI
//
//  Created by Hossam on 9/29/20.
//

import SwiftUI

class ContactViewModel: ObservableObject {
    @Published var name=""
    @Published var isFavorite=false
}

