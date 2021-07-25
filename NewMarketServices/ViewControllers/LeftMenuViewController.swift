//
//  LeftMenuViewController.swift
//  NewMarketServices
//
//  Created by admin on 23/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class LeftMenuViewController: BaseViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var tableTopBorderView: UIView!
    
    @IBOutlet weak var lblForName: UILabel!
    @IBOutlet weak var lblForRole: UILabel!
    @IBOutlet weak var lblForCompanyName: UILabel!
    
    let menuTitles = ["Profile", "Settings", "Disclosure", "Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1.0
        
        tableTopBorderView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        menuTableView.backgroundColor = .clear
        menuTableView.tableFooterView = UIView()
       self.updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Workaround for DrawerController issue with iOS 8 https://stackoverflow.com/questions/36159870/ios-mmdrawercontrollers-left-menu-table-view-content-is-shifted-down-after-disp/36467437
        self.navigationController?.view.layoutSubviews()
    }
    
    
    private func updateUI()
    {
        let loginDetails = SessionManager.shared.loginResponseData
        guard loginDetails != nil else {
            return
        }
        lblForName.text = loginDetails?.name
        lblForRole.text = loginDetails?.userRole
        lblForCompanyName.text = loginDetails?.userCompanyName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self), for: indexPath) as! MenuTableViewCell
        cell.titleLabel.text = menuTitles[indexPath.row]
        cell.configureDisplayFor(indexPath: indexPath)
        cell.configureSelectedBackgroundView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showLogin()
            self.mm_drawerController.toggle(.left, animated: true, completion: nil)
        }
    }
}

