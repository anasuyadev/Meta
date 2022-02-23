//
//  TableViewCell.swift
//  Meta
//
//  Created by Anasuya Dev on 20/01/22.
//

import UIKit

class TableViewCell: UITableViewCell, EditHomeDelegate {

    let shareVC = EditProfileViewController()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shareVC.homeDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func editNameHome(_ nameHome: String)
    {
        titleLabel.text = nameHome
       
    }

}
