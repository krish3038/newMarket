//
//  ClaimEvaluationViewController.swift
//  NewMarketServices
//
//  Created by Guest_mobility on 26/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimEvaluationViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var CEView: UIView!
    //Claim Acknowleged
    @IBOutlet weak var CAHeaderView: UIView!
    @IBOutlet weak var CAHeaderButton: UIButton!
    @IBOutlet weak var CAHeaderLabel: UILabel!
    @IBOutlet weak var CASubLabel: UILabel!
    @IBOutlet weak var CAView: UIView!
    
    //Additional Information
    @IBOutlet weak var AIHeaderView: UIView!
    @IBOutlet weak var AIHeaderButton: UIButton!
    @IBOutlet weak var AIHeaderLabel: UILabel!
    @IBOutlet weak var AISubLabel: UILabel!
    @IBOutlet weak var AIView: UIView!
    
    //Expert Opinion
    @IBOutlet weak var EOHeaderView: UIView!
    @IBOutlet weak var EOHeaderButton: UIButton!
    @IBOutlet weak var EOHeaderLabel: UILabel!
    @IBOutlet weak var EOSubLabel: UILabel!
    @IBOutlet weak var EOView: UIView!
    
    //Claim  Segmentation
    @IBOutlet weak var CSHeaderView: UIView!
    @IBOutlet weak var CSSubLabel: UILabel!
    @IBOutlet weak var CSHeaderLabel: UILabel!
    @IBOutlet weak var CSView: UIView!
    
    //Claim  Query
    @IBOutlet weak var CQHeaderView: UIView!
    @IBOutlet weak var CQHeaderButton: UIButton!
    @IBOutlet weak var CQHeaderLabel: UILabel!
    @IBOutlet weak var CQView: UIView!
    
    @IBOutlet weak var CEHeight: NSLayoutConstraint!
    @IBOutlet weak var CAViewHeight: NSLayoutConstraint! //130
    @IBOutlet weak var AIViewHeight: NSLayoutConstraint! //400
    @IBOutlet weak var EOViewHeight: NSLayoutConstraint! //160
    @IBOutlet weak var CQViewHeight: NSLayoutConstraint! //100
    @IBOutlet weak var CQContentLabelHeight: NSLayoutConstraint! //50
    @IBOutlet weak var CQContentLabel: UILabel!
    
    
    @IBOutlet weak var csTableView: UITableView!
    @IBOutlet weak var AITableView: UITableView!
    
    private var claimSegmentationArray = [ClaimSegmentationTableInfo]()
    private var additionalInformationArray = [AdditionalDetailsTableInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        applyTheme()
        
        CAHeaderButton.cornerRadius = CAHeaderButton.bounds.height/2
        AIHeaderButton.cornerRadius = CAHeaderButton.bounds.height/2
        EOHeaderButton.cornerRadius = CAHeaderButton.bounds.height/2
        CQHeaderButton.cornerRadius = CAHeaderButton.bounds.height/2
        
        //AISubLabel.isHidden = true
        CQContentLabelHeight.constant = 0
    }
    
    func applyTheme() {
        CAHeaderButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        AIHeaderButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        EOHeaderButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        CQHeaderButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        CAHeaderLabel.textColor = ThemeManager.currentTheme().backgroundColor
        AIHeaderLabel.textColor = ThemeManager.currentTheme().backgroundColor
        EOHeaderLabel.textColor = ThemeManager.currentTheme().backgroundColor
        CQHeaderLabel.textColor = ThemeManager.currentTheme().backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // evaluation service
        self.showActivityIndicator()
        guard let eachCaseObject = ClaimInvestigateManager.shared.selectedMyCaseTask else { return }
        getClaimEvaluationData(claimNo: eachCaseObject.ClaimNo!)
    }
    
    func getClaimEvaluationData(claimNo : String) {
        let claimEvaluationServiceObj = ClaimEvaluationService()
        //        let loginReq = SessionManager.shared.loginReq
        var loginReq = LoginReq()
        loginReq.userName = "GaingKim"
        loginReq.UserPwd = "1234"
        claimEvaluationServiceObj.getClaimEvaluationData(credentials: loginReq, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil{
                    guard let claimEvaluationResponsetData = data as? ClaimEvaluationResponse else{
                        return
                    }
                    self.updateUI(evaluationData: claimEvaluationResponsetData)
                    
                    //ClaimSegmentation Table Data
                    if (claimEvaluationResponsetData.claimSegmentationInfo?.count)! > 0 {
                        self.claimSegmentationArray = (claimEvaluationResponsetData.claimSegmentationInfo?[0].tableInfo)!
                        if self.claimSegmentationArray.count > 0 {
                            self.csTableView.reloadData()
                        } else{
                            self.addDataToTablesWhenDataNotAvailable(isClaimTable: true)
                        }
                    } else{
                        self.addDataToTablesWhenDataNotAvailable(isClaimTable: true)
                    }
                    
                    //Additional Information Table Data
                    if (claimEvaluationResponsetData.additionalInfo?.count)! > 0 {
                        self.additionalInformationArray = (claimEvaluationResponsetData.additionalInfo?[0].tableInfo)!
                        if self.additionalInformationArray.count > 0 {
                            self.AITableView.reloadData()
                        } else{
                            self.addDataToTablesWhenDataNotAvailable(isClaimTable: false)
                        }
                    } else{
                        self.addDataToTablesWhenDataNotAvailable(isClaimTable: false)
                    }
                } else{
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
    
    func addDataToTablesWhenDataNotAvailable(isClaimTable : Bool) {
        if isClaimTable {
            self.claimSegmentationArray.removeAll()
            var claimSegmentationModelObj = ClaimSegmentationTableInfo()
            claimSegmentationModelObj.claimSegmentationTableInfoName = "No Data"
            claimSegmentationModelObj.claimSegmentationTableInfoRole = "No Data"
            claimSegmentationModelObj.claimSegmentationTableInfoDate = "No Data"
            self.claimSegmentationArray.append(claimSegmentationModelObj)
            self.csTableView.reloadData()
        } else{
            self.additionalInformationArray.removeAll()
            var additionalModelObj = AdditionalDetailsTableInfo()
            additionalModelObj.additionalTableInfoPartyName = "No Data"
            additionalModelObj.additionalTableInfoPartyType = "No Data"
            additionalModelObj.additionalTableInfoDetails = "No Data"
            additionalModelObj.additionalTableInfoStatus = "No Data"
            additionalModelObj.additionalTableInfoReceivedOn = "No Data"
            self.additionalInformationArray.append(additionalModelObj)
            self.AITableView.reloadData()
        }
    }
    
    func updateUI(evaluationData : ClaimEvaluationResponse){
        //Claim  Segmentation
        
        let csType : String = (evaluationData.claimSegmentationInfo?.count)! > 0 ? (evaluationData.claimSegmentationInfo?[0].claimSegmentationType)! : ""
        self.CSSubLabel.text = csType == "" ? "No Data Available." : "The claim has been segmented as: \(csType) Claim has been assigned to the following parties for adjudication"
        
        //Claim Acknowleged
        guard let ackText : String = evaluationData.claimAckBy else{
            return
        }
        self.CASubLabel.text = ackText == "" ? "No Data Available." : "The claim has been acknowledged by:\(ackText) Claim will be processed as per the contract."
        
        //Expert Opinion
        guard let experOpinionText : String = evaluationData.claimExpertOpinion else{
            return
        }
        self.EOSubLabel.text = experOpinionText == "" ? "No Data Available." : experOpinionText
        
        //Claim  Query
        guard let claimQueryText : String = evaluationData.claimQuery else{
            return
        }
        self.CQContentLabel.text = claimQueryText == "" ? "No Data Available." : claimQueryText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapCAHeaderButtonAction(_ sender: UIButton) {
        
        if CAViewHeight.constant == 0 {
            CAViewHeight.constant = 130
        }else {
            CAViewHeight.constant = 0
        }
    }
    
    @IBAction func onTapAIHeaderButtonAction(_ sender: UIButton) {
        
        if AIViewHeight.constant == 0 {
            AIViewHeight.constant = 350
        }else {
            AIViewHeight.constant = 0
        }
    }
    @IBAction func onTapEOHeaderButtonAction(_ sender: UIButton) {
        
        if EOViewHeight.constant == 0 {
            EOViewHeight.constant = 200
        }else {
            EOViewHeight.constant = 0
        }
    }
    @IBAction func onTapCQHeaderButtonAction(_ sender: UIButton) {
        
        if CQViewHeight.constant == 0 {
            CQViewHeight.constant = 100
            //CQContentLabel.isHidden = false
        }else {
            CQViewHeight.constant = 0
            //CQContentLabel.isHidden = true
        }
    }
}

extension ClaimEvaluationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //        if tableView.tag == 100 {
        //            return 1
        //        }else {
        //            return 1
        //        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.tag == 100 ? self.claimSegmentationArray.count  : self.additionalInformationArray.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell =  UITableViewCell()
        if tableView.tag == 100 {
            let customCell: ClaimSegmentationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ClaimSegmentationTableViewCell")) as! ClaimSegmentationTableViewCell
            let claimSegmentationModelObj = self.claimSegmentationArray[indexPath.row]
            customCell.nameLabel.text = claimSegmentationModelObj.claimSegmentationTableInfoName
            customCell.roleLabel.text = claimSegmentationModelObj.claimSegmentationTableInfoRole
            customCell.dateLabel.text = claimSegmentationModelObj.claimSegmentationTableInfoDate
            customCell.selectionStyle = .none
            cell = customCell
        }else {
            let customCell: InfoTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell")) as! InfoTableViewCell
            let additionalInformationModelObj = self.additionalInformationArray[indexPath.row]
            customCell.partyNameLabel.text = additionalInformationModelObj.additionalTableInfoPartyName
            customCell.partyTypeLabel.text = additionalInformationModelObj.additionalTableInfoPartyType
            customCell.detailsLabel.text = additionalInformationModelObj.additionalTableInfoDetails
            customCell.infoReceivedLabel.text = additionalInformationModelObj.additionalTableInfoStatus
            customCell.infoReceivedDateLabel.text = additionalInformationModelObj.additionalTableInfoReceivedOn
            customCell.selectionStyle = .none
            cell = customCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 100 {
            return 50
        }else {
            return 50
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = UIView()
        if tableView.tag == 100 {
            let customCell: ClaimSegmentationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ClaimSegmentationTableViewCell")) as! ClaimSegmentationTableViewCell
            customCell.contentView.backgroundColor = UIColor(hex: 0xD8D8D8)
            customCell.nameLabel.text = "Name"
            customCell.roleLabel.text = "Role"
            customCell.dateLabel.text = "Date"
            header = customCell.contentView
        }else {
            let customCell: InfoTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell")) as! InfoTableViewCell
            customCell.contentView.backgroundColor = UIColor(hex: 0xD8D8D8)
            customCell.partyNameLabel.text = "Party Name"
            customCell.partyTypeLabel.text = "Party Type"
            customCell.detailsLabel.text = "Details"
            customCell.infoReceivedLabel.text = "Status"
            customCell.infoReceivedDateLabel.text = "Received on"
            
            header = customCell.contentView
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {
            return 50
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {
            return 0
        }else {
            return 0
        }
    }
}
