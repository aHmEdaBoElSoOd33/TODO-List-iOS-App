//
//  ItemVC.swift
//  ToDo List
//
//  Created by Ahmed on 04/01/2023.
//

import UIKit
import RealmSwift


class ItemVC: UITableViewController {
    
    //MARK: - Variables
    
    var category : Category?{
        didSet{
            itemsArray = category?.Item
        }
    }
    var textFeild = UITextField()
    let realm = try! Realm()
    var itemsArray : List<Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = category?.name
        // realm file
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.labelTxt.text = itemsArray[indexPath.row].name
        if itemsArray[indexPath.row].checked{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        cell.cellContent.layer.backgroundColor = UIColor.white.cgColor
        cell.cellContent.layer.borderWidth = 0.1
        cell.cellContent.layer.cornerRadius = 15
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.7
        cell.cellContent.layer.shadowOffset = .zero
        cell.cellContent.layer.shadowRadius = 4
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var item = itemsArray[indexPath.row]
        try! self.realm.write {
            //self.realm.add(newItem)
            item.checked = !item.checked
        }
        
        if item.checked {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! realm.write {
            let item = itemsArray[indexPath.row]
            realm.delete(item)
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if itemsArray.count != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          =  category!.name+" List Is Empty"
            noDataLabel.textColor     = UIColor.lightGray
            noDataLabel.font = .boldSystemFont(ofSize: 20)
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - IBActions
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { textfeild in
            textfeild.placeholder = "Add Item"
            self.textFeild = textfeild
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            var newItem = Item()
            newItem.name = self.textFeild.text!
            
            
            try! self.realm.write {
                
                self.category?.Item.append(newItem)
            }
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default,handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}
