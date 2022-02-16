//
//  ProductDetailsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 03/02/22.
//

import UIKit
import Combine

class ProductDetailsViewController: UIViewController {
    
    var product: ProductData?

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
//call api in viewwillappear
    override func viewWillAppear(_ animated: Bool) {
        print(product!.title)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.titleLabel.text = product!.title
        self.descriptionLabel.text = product!.description
        self.categoryLabel.text = product!.category
        self.priceLabel.text = "\(product!.price)"
        let url = URL(string: product!.image)!
        DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url) {
                   DispatchQueue.main.async {
                       self.productImage!.image = UIImage(data: data)
                   }
               }
           }
    }
}
