//
//  TableViewController.swift
//  ToDo List
//
//  Created by Ahmed on 04/01/2023.
//

import UIKit
import RealmSwift
class CategoryVC: UITableViewController {

    //MARK: - Variables
    
    var categoryArray : Results<Category>!
    var textFeild = UITextField()
    // Open the default realm.
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        categoryArray = realm.objects(Category.self)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
     
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.lableTxt.text = "\(categoryArray[indexPath.row].name)"
        cell.tasksCount.text = "\(categoryArray[indexPath.row].Item.count)"
        cell.cellContent.layer.backgroundColor = UIColor.white.cgColor
        cell.cellContent.layer.borderWidth = 0.1
        cell.cellContent.layer.cornerRadius = 15
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.7
        cell.cellContent.layer.shadowOffset = .zero
        cell.cellContent.layer.shadowRadius = 4
         
        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    @IBAction func addCategory(_ sender: Any) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { textfeild in
            textfeild.placeholder = "Add Category"
            self.textFeild = textfeild
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let categoryname = Category()
            categoryname.name = self.textFeild.text!
            //self.categoryArray.append(categoryname)
            
            
            try! self.realm.write {
                self.realm.add(categoryname)
            }
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default,handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goItemVC", sender: self)
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! realm.write {
            let item = categoryArray[indexPath.row]
            realm.delete(item)
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if categoryArray.count != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.font = .boldSystemFont(ofSize: 25)
            noDataLabel.textColor     = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
 
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedCat = categoryArray[tableView.indexPathForSelectedRow!.row]
        let vc = segue.destination as! ItemVC
        vc.category = selectedCat 
    }
 
}
