//
//  ProductDetailsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 03/02/22.
//

import UIKit
import Combine

class ProductDetailsViewController: UIViewController {
    
//productdetailid
//    var productDetailVCId: Int = 0
//    static var shareProduct = ProductDetailsViewController()
//    single product, not array
    

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
        
        var product: ProductData! {
            didSet{
                titleLabel.text = product.title
                descriptionLabel.text = product.description
                priceLabel.text = "$\(product.price)"
            }
        }
        print(product.title)
//        let url = URL(string: "https://fakestoreapi.com/products/\(productDetailVCId)")!
//
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                if let prod = try? JSONDecoder().decode([ProductData].self, from: data) {
//                    print(prod)
//                } else {
//                    print("Invalid Response")
//                }
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//        self    Meta.ProductDetailsViewController    0x000000013c3085b0    }
//        }

//         let product: ProductData
            
//            var title: String {
//                titleLabel.text = products.title
//            }
//
////            var imageData: Data? {
////                try? Data(contentsOf: self.product.image)
////            }
//
//            var description: String {
//                "Description: \(product.description)"
//            }
//
//
//            var price: String {
//                "Price: \(product.price)"
//            }
    }
}
