//
//  PremiumCheckViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 7/4/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

protocol  PremiumCheckVCDelegate: class {
    func didPremiumPaidByPolicyHolderTap()
    func didReinstatementPremiumApplicableForClaimTap()
    func didReinstatementPremiumNotApplicableForClaimTap()
    func didConfirmPremiumPaidByPolicyHolderTap()
}

class PremiumCheckViewController: BaseViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var firstPaidButton: UIButton!
    @IBOutlet weak var applicableButton: UIButton!
    @IBOutlet weak var notApplicableButton: UIButton!
    @IBOutlet weak var secondPaidButton: UIButton!
    
    weak var delegate: PremiumCheckVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        secondLabel.isHidden = true
        applicableButton.isHidden = true
        notApplicableButton.isHidden = true
        
        thirdLabel.isHidden = true
        secondPaidButton.isHidden = true
        
        //Background color - alpha .5
        applyTheme()
        notApplicableButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 0.5)
        notApplicableButton.backgroundColor = UIColor.black
        
    }
    
    func applyTheme() {
        firstPaidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        applicableButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        secondPaidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // hit service
    }
    
    func getPremiumCheckData(claimNo : String) {
        let claimPremiumCheckServiceObj = ClaimPremiumCheckService()
        //        let loginReq = SessionManager.shared.loginReq
        var loginReq = LoginReq()
        loginReq.userName = "GaingKim"
        loginReq.UserPwd = "1234"
        claimPremiumCheckServiceObj.getPremiumCheckData(credentials: loginReq, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil{
                    guard let claimPremiumCheckResponsetData = data as? ClaimPremiumCheckResponse else{
                        return
                    }
                } else{
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstPaidButtonAction(_ sender: UIButton) {
        secondLabel.isHidden = false
        applicableButton.isHidden = false
        notApplicableButton.isHidden = false
        
        //Background color - alpha 1
        firstPaidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        delegate?.didPremiumPaidByPolicyHolderTap()
    }
    @IBAction func applicableButtonAction(_ sender: UIButton) {
        thirdLabel.isHidden = false
        secondPaidButton.isHidden = false
        //Background color - alpha 1
        applicableButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        delegate?.didReinstatementPremiumNotApplicableForClaimTap()
    }
    @IBAction func notApplicableButtonAction(_ sender: UIButton) {
        //Background color - alpha 1
        notApplicableButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 1)
        delegate?.didReinstatementPremiumNotApplicableForClaimTap()
    }
    @IBAction func secondPaidButtonAction(_ sender: UIButton) {
        //Background color - alpha 1
        secondPaidButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        delegate?.didConfirmPremiumPaidByPolicyHolderTap()
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
