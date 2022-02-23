//
//  ProductTableViewCell.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

//    var productId: Int
    var product: ProductData! {
        didSet{
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            priceLabel.text = "$\(product.price)"
            self.setProductImage(productImageURL: URL (string: product.image)!, productId: String(product.id) as NSString)
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
        
       }
    
    func setProductImage(productImageURL: URL, productId: NSString)
    {
        let url = URL(string: product.image)!
        DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url) {
                   DispatchQueue.main.async {
                       self.productImage!.setImage(from: data, placeholder: UIImage(named: "productPlaceholder"), index: productId)
                   }
               }
           }
    }
}

class ImageCache {

    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    func imageFor(data: Data, indexPath: NSString) -> UIImage?
    {
        if let imageInCache = self.cache.object(forKey: indexPath)
        {
            print("AG: Image cache")
            return imageInCache
        }
        guard let image = UIImage(data: data) else { return nil}
        self.cache.setObject(image, forKey: indexPath)
        print("AG: Setting image")
        return image
    }
}

extension UIImageView {

    func setImage(from data: Data, placeholder: UIImage? = nil, index: NSString) {
        image = placeholder

        self.image = ImageCache.shared.imageFor(data: data, indexPath: index)
        }
    }

