//
//  HouseKeepingCheckViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 7/4/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

protocol HouseKeepingCheckVCDelegate: class {
    func didAgreedTap()
    func didPaidTap()
    func didNoTap()
}

class HouseKeepingCheckViewController: BaseViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    var name = ["Fortitude","Dokata", "Followeer2"]
    var Status = ["Confirmed","Pending", "Confirmed"]
    
    weak var delegate: HouseKeepingCheckVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        applyTheme()
        // noButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 0.5)
        noButton.backgroundColor = UIColor.black
        
        secondLabel.isHidden = true
        paidButton.isHidden = true
        
        thirdLabel.isHidden = true
        noButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // hit service
    }
    
    func getHouseKeepCheckData(claimNo : String) {
        let claimHouseKeepServiceObj = ClaimHousekeepCheckService()
        //        let loginReq = SessionManager.shared.loginReq
        var loginReq = LoginReq()
        loginReq.userName = "GaingKim"
        loginReq.UserPwd = "1234"
        claimHouseKeepServiceObj.getHouseKeepCheckData(credentials: loginReq, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil{
                    guard let claimHousekeepCheckResponsetData = data as? ClaimHousekeepCheckResponse else{
                        return
                    }
                } else{
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
    
    func applyTheme() {
        agreeButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        paidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agreedAction(_ sender: Any) {
        delegate?.didAgreedTap()
        secondLabel.isHidden = false
        paidButton.isHidden = false
        agreeButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    @IBAction func paidAction(_ sender: Any) {
        delegate?.didPaidTap()
        
        thirdLabel.isHidden = false
        noButton.isHidden = false
        paidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
    }
    
    @IBAction func noAction(_ sender: Any) {
        delegate?.didNoTap()
        noButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 1)
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

extension HouseKeepingCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //Index Cell
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "confirmationTableViewCell", for: indexPath) as! confirmationTableViewCell
        //Set up the cell contents
        //        customCell.setDataforCell(index: indexPath.row, )
        if (indexPath.row % 2 == 0)
        {
            customCell.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        } else {
            customCell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
        }
        //let object = Confirmobjects[indexPath.row]
        customCell.lblCarriername.text = name[indexPath.row]
        customCell.lblConfirmation.text = Status[indexPath.row]
        customCell.selectionStyle = .none
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("InfoTableViewCell -- didSelectRowAt --->\(indexPath.row)")
    }
}
