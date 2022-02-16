//
//  ProductsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit
import Combine
//create protocol
protocol ProductDetails
{
    func productsDetails()
}
class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: ProductDetails?
    var productdetailid: Int = 0
    static var shareProduct = ProductsViewController()
    private var products = [ProductData]()
    
    private var api = ProductManager()
    private var cancellable = Set<AnyCancellable>()

    @IBOutlet weak var productsTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    fileprivate func getProducts()
    {
        api.products()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (products) in
                self?.products = products
                self?.productsTable.reloadData()
            }
            .store(in: &cancellable)
    }
    
//    fileprivate func getProductDetails()
//    {
//        api.productsDetails(id: <#T##Int#>)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] (products) in
//                self?.products = products
//                self?.productsTable.reloadData()
//            }
//            .store(in: &cancellable)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.startAnimating()
        getProducts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return products.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
         cell.selectionStyle = .none
         cell.product = products[indexPath.row]
        return cell
    }
//   extract using indexpath , product detail id var
//    didselect - navigate to next
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row >= 0)
        {
//            call api, pass prod  id
            
            productdetailid = indexPath.row + 1
//            getProductDetails()
//            ProductModel.shareProduct.productDetailVCId = productdetailid
            let storyBoard: UIStoryboard = UIStoryboard(name: "Product", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
