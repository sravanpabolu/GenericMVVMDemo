//
//  ViewController.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import UIKit

class ViewController: UIViewController {

    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCompletion()
        getUsers()
    }
}

extension ViewController {
    func getUsers() {
        userViewModel.getUsers()
    }
    
    fileprivate func initializeCompletion() {
        userViewModel.completion = { [weak self] in
            guard let self = self else { return }
            
            if let error = self.userViewModel.errorString {
                //SHOW ALERT
                self.showErrorAlert(message: error)
                return
            }
            
            guard let users = self.userViewModel.users else {
                self.showErrorAlert(message: "Users Data error")
                return
            }
            
            print("Users: \n \(users)")
        }
    }
}

extension ViewController {
    func showErrorAlert(message: String) {
        //SHOW ALERT
        print("Error: \(message)")
    }
}

