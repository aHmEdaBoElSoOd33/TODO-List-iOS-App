//
//  CategoryCell.swift
//  ToDo List
//
//  Created by Ahmed on 04/01/2023.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var tasksCount: UILabel!
    @IBOutlet weak var lableTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
