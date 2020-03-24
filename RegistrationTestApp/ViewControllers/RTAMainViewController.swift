//
//  RTAMainViewController.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 20/03/2020.
//  Copyright © 2020 PaRaDoX. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class RTAMainViewController: UIViewController {
    
    @IBOutlet var emailTextField: RTACustomTextField!
    @IBOutlet var passwordTextField: RTACustomTextField!
    @IBOutlet var nameTextField: RTACustomTextField!
    
    
    func showBanner(withTitle title: String) {
        let banner = GrowingNotificationBanner(title: nil, subtitle: title, style: .danger)
        banner.subtitleLabel?.textAlignment = .center
        banner.bannerHeight = 120.0
        banner.subtitleLabel?.font = UIFont.init(name: "ArialRoundedMTProCyr-Bold", size: 15.0)
        banner.show()
    }
    
//    MARK: - ACTIONS
    @IBAction func registartionButtonPressed(_ sender: UIButton) {
        
        if self.emailTextField.text().isEmpty {
            self.showBanner(withTitle: "e-mail не указан")
            return
        }

        if !self.emailTextField.text().isValidEmailAddress() {
            self.showBanner(withTitle: "e-mail неверно указан")
            return
        }

        if self.passwordTextField.text().isEmpty {
            self.showBanner(withTitle: "Пароль не указан")
            return
        }

        if self.nameTextField.text().isEmpty {
            self.showBanner(withTitle: "Имя не указано")
            return
        }


        if RTADatabaseManager.sharedInstance.isUserInDB(primaryKey: self.emailTextField.text()) {
            self.showBanner(withTitle: "Пользователь с таким e-mail уже зарегистрирован")
        } else {
            let newUser: RTAUser = RTAUser.init(email: self.emailTextField.text(),
                                                name: self.nameTextField.text(),
                                                password: self.passwordTextField.text())
            RTADatabaseManager.sharedInstance.saveUserEntity(user: newUser)
            self.performSegue(withIdentifier: "showUsersScreen", sender: self)
        }
      
    }
      
    @IBAction func tapGestureDone(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

