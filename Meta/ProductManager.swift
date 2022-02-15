//
//  ProductManager.swift
//  Meta
//
//  Created by Anasuya Dev on 03/02/22.
//

import Foundation
import Combine

class ProductManager
{
    var cancellable = Set<AnyCancellable>()
//    var productDetailVCId: Int = 0
    static var shareProduct = ProductsViewController()
    
    func products() -> Future<[ProductData], Never>
    {
        return Future{ promise in
            let taskPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: "https://fakestoreapi.com/products")!)
            taskPublisher.map {
                $0.data
            }
            .decode(type: [ProductData].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(_):
                    promise(.success([ProductData]()))
                }
            } receiveValue: { (products) in
                promise(.success(products))
            }.store(in: &self.cancellable)
        }
    }
    
    func productsDetails(productDetailVCId: Int) -> Future<[ProductData], Never>
    {
//        productDetailVCId = ProductsViewController.shareProduct.productdetailid
        return Future{ [self] promise in
            let taskPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: "http://fakestoreapi.com/products/\(productDetailVCId)")!)
//            print(taskPublisher)
            taskPublisher.map {
                $0.data
            }
            .decode(type: [ProductData].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(_):
                    promise(.success([ProductData]()))
                }
            } receiveValue: { (products) in
                promise(.success(products))
            }.store(in: &self.cancellable)
        }
    }
}
