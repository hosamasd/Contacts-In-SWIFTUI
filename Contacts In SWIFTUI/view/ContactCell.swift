//
//  ContactCell.swift
//  Contacts In SWIFTUI
//
//  Created by Hossam on 9/29/20.
//

import UIKit
import SwiftUI

class ContactCell: UITableViewCell {
    let viewModel = ContactViewModel()
    
    lazy var row = ContactRowView(vm: viewModel)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let hosting = UIHostingController(rootView: row)
        addSubview(hosting.view)
        hosting.view.fillSuperview()
        
        viewModel.name = "wdes"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
