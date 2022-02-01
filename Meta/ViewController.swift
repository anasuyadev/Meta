//
//  ViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 17/01/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func signInButton(_ sender: UIButton) {
//        let vc = SignInViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
//        let vc = SignUpViewController()
//        navigationController?.pushViewController(vc, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

