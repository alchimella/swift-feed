//
//  AuthViewController.swift
//  swift-feed
//
//  Created by Abi  Radzhabova on 24/10/21.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBAction func signInTouch(_ sender: Any) {
        authService.wakeUpSession()
    }
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
        
    }
}
