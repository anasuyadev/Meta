//
//  ProductsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit
import Combine

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var products = [ProductData]()
    private var api = ProductManager()
    private var cancellable = Set<AnyCancellable>()

    @IBOutlet weak var productsTable: UITableView!
    
    fileprivate func getProducts()
    {
        api.products()
            .receive(on: DispatchQueue.main)
            .sink { (products) in
                self.products = products
                self.productsTable.reloadData()
            }
            .store(in: &cancellable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getProducts()
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return products.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell

         cell.product = products[indexPath.row]
        return cell
    }
}
