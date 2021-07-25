//
//  ClaimPaymentViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 7/4/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

protocol  ClaimPaymentVCDelegate: class {
    func didAgreeTap()
    func didDisagreeTap()
}

class ClaimPaymentViewController: BaseViewController {
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var claimPaymentTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!
    
    private  var claimPaymentList: [ClaimSettlementDetails] = []
    
    weak var delegate: ClaimPaymentVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Mark: - Get Segmentation details from server
//        self.getClaimPaymentService(userID: "", claimNumber: "")
        agreeButton.backgroundColor = UIColor.init(red: 27/255, green: 99/255, blue: 203/22, alpha: 0.5)
        //disagreeButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 0.5)
        disagreeButton.backgroundColor = UIColor.black
        agreeButton.isUserInteractionEnabled = true
        disagreeButton.isUserInteractionEnabled = true
        
        agreeButton.isHidden = true
        disagreeButton.isHidden = true
        
        claimPaymentTableView.sectionHeaderHeight = 50
        //self.tableView.sectionHeaderHeight = 70
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showActivityIndicator()
        guard let eachCaseObject = ClaimInvestigateManager.shared.selectedMyCaseTask else { return }
        self.getClaimSettlementData(claimNo: eachCaseObject.ClaimNo!)
    }
    
    func getClaimSettlementData(claimNo : String) {
        let claimSettlementService = ClaimSettlementService()
//        let loginReq = SessionManager.shared.loginReq
        var loginReq = LoginReq()
        loginReq.userName = "GaingKim"
        loginReq.UserPwd = "1234"
        claimSettlementService.getClaimSettlementData(credentials: loginReq, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil{
                    guard let claimSettlementData = data as? ClaimSettlementResponse else{
                        return
                    }
                    let claimSettlementObj = claimSettlementData.claimSettlementData![0]
                    self.updateUI(settlememtData: claimSettlementObj)
                    self.claimPaymentList = claimSettlementObj.claimSettlementDetailsList!
                    if self.claimPaymentList.count > 0{
                        self.claimPaymentTableView.reloadData()
                    }
                } else{
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
    
    func updateUI(settlememtData : ClaimSettlementData){
        let leadName : String = settlememtData.lead!
        let price : String = settlememtData.settlementAmount!
        self.firstLabel.text = "The \(leadName) party has agreed for claim settlement - £ \(price)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agreeButtonAction(_ sender: UIButton) {
        agreeButton.backgroundColor = UIColor.init(red: 27/255, green: 99/255, blue: 203/22, alpha: 1)
        agreeButton.isUserInteractionEnabled = true
        disagreeButton.isUserInteractionEnabled = false
        delegate?.didAgreeTap()
    }
    @IBAction func disagreeButtonAction(_ sender: UIButton) {
        disagreeButton.backgroundColor = UIColor.init(red: 237/255, green: 103/255, blue: 00/22, alpha: 1)
        agreeButton.isUserInteractionEnabled = false
        disagreeButton.isUserInteractionEnabled = false
        delegate?.didDisagreeTap()
    }
    
//    private func getClaimPaymentService(userID: String, claimNumber: String) {
//        ClaimJourneyHandler.getClaimPayment(userID: userID, claimNumber: claimNumber) { [weak self] (isSuccess, errorMessage, response) in
//            guard let weakSelf = self else {
//                return
//            }
//            if isSuccess == true {
//                if let info:ClaimPayments =  response as? ClaimPayments {
//                    weakSelf.claimPaymentList = info.claimPaymentList!
//
//                    if weakSelf.claimPaymentList.count > 0 {
//                        weakSelf.claimPaymentTableView.reloadData()
//                    }
//                }
//            }else {
//                //weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
//            }
//        }
//    }
    
}

extension ClaimPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return claimPaymentList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //Index Cell
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "ClaimPaymentTableViewCell", for: indexPath) as! ClaimPaymentTableViewCell
        //Set up the cell contents
        customCell.setDataforCell(index: indexPath.row, claimPayment: claimPaymentList[indexPath.row])
        customCell.selectionStyle = .none
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("InfoTableViewCell -- didSelectRowAt --->\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "ClaimPaymentTableViewCell") as! ClaimPaymentTableViewCell
        headerCell.backgroundColor = UIColor(hex: 0xD8D8D8)
        
        headerCell.partyName.text = "Party Name"
        headerCell.partyType.text = "party Type"
        headerCell.settlementAmount.text = "settlement Amount"
        headerCell.confirmationStatus.text = "confirmation"
        
        return headerCell
    }
    
    
    
}
