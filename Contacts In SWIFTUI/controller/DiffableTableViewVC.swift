//
//  DiffableTableViewVC.swift
//  Contacts In SWIFTUI
//
//  Created by Hossam on 9/29/20.
//

import UIKit
import SwiftUI

class ContactSource: UITableViewDiffableDataSource<SectionType,Contact> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

class DiffableTableViewVC: UITableViewController {
    
    lazy var source:ContactSource = .init(tableView: self.tableView) { (_, indexPath, contact) -> UITableViewCell? in
        let cell = ContactCell()
//        cell.textLabel?.text = contact.name
        cell.viewModel.name=contact.name
        cell.viewModel.isFavorite=contact.isFavorite
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
        setupSource()
    }
    
   @objc func handleAdd()  {
    var formView = ContactFormView { (name,type) in
        self.dismiss(animated: true, completion: nil)
        
        var snapshot = self.source.snapshot()
        snapshot.appendItems([.init(name: name)], toSection: type)
        self.source.apply(snapshot)
    }
    formView.didCancelContact = {
        self.dismiss(animated: true, completion: nil)
    }
    let hosting = UIHostingController(rootView: formView)
    present(hosting, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "DELETE") { (action, view, completion) in
            completion(true)
            
            var snapshot = self.source.snapshot()
            guard let c = self.source.itemIdentifier(for: indexPath) else {return}
            snapshot.deleteItems([c])
            self.source.apply(snapshot)
        }
        
        let favorite = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            completion(true)
            
            var snapshot = self.source.snapshot()
            guard var c = self.source.itemIdentifier(for: indexPath) else {return}
            c.isFavorite.toggle()
            snapshot.reloadItems([c])
            self.source.apply(snapshot)
        }
        
        return .init(actions: [delete,favorite])
    }
    
   
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tx = section == 0 ? SectionType.ceo.rawValue.uppercased() : SectionType.passants.rawValue.uppercased()
        
        let la = UILabel(text: tx, font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
        return la
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupSource()  {
        var snapshot = source.snapshot()
        snapshot.appendSections([.ceo,.passants])
        snapshot.appendItems([.init(name: "hosam"),.init(name: "mohamed"),.init(name: "zxcxzcxz")], toSection: .ceo)
        snapshot.appendItems([.init(name: "second gggg")], toSection: .passants)
        
        source.apply(snapshot)
    }
}

