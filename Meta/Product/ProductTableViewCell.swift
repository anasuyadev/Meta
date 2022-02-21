//
//  ProductTableViewCell.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    var product: ProductData! {
        didSet{
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            priceLabel.text = "$\(product.price)"
        }
    }
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UITextView!
//    @IBOutlet weak var titleLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let url = URL(string: product.image)!
        DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url) {
                   DispatchQueue.main.async {
                       self.productImage!.image = UIImage(data: data)
                   }
               }
           }
       }
}
