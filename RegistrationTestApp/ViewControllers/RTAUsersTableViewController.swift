//
//  RTAUsersTableViewController.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 24/03/2020.
//  Copyright © 2020 PaRaDoX. All rights reserved.
//

import UIKit

class RTAUsersTableViewController: UITableViewController {
    
    let users = RTADatabaseManager.sharedInstance.allUsers()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Users"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTProCyr-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RTAUserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RTAUserTableViewCell", for: indexPath) as! RTAUserTableViewCell
        
        let user = self.users[indexPath.row]
        
        cell.emailLabel.text = user.email
        cell.nameLabel.text = user.name
        
        return cell
    }
}
