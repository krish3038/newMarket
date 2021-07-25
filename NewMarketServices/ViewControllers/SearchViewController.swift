//
//  SearchViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var searchBackGroundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var serchresult: [Policy] = [Policy]()
    var selectedClaimDetails: Policy? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        headerView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        //Custom UIDesign Configuration
        self.customUIDesignConfiguration()
        
        // Get all policy details from server call
        self.getSearchHistory(userID: "", searchString:"")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Get Claim SearchHistory service integration
    func getSearchHistory(userID: String, searchString: String){
        self.showActivityIndicator()
        SearchHandler.getSearchHistory(userID: "", searchString: "") { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let policies:Policies =  response as? Policies {
                    if policies.policyList != nil {
                        weakSelf.serchresult = policies.policyList!
                        print("Policy List\(String(describing: response))")
                        print("Serchresult List\(weakSelf.serchresult)")
                        //TableView reload
                        DispatchQueue.main.async {
                            if (weakSelf.serchresult.count > 0) {
                                weakSelf.searchHistoryTableView.reloadData()
                            }
                        }
                    }
                }
            }else {
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
            }
        }
    }
    
    // MARK: - Get Claims From SearchString service integration
    func getClaimsFromSearchString(userID: String, searchString: String){
        self.showActivityIndicator()
        SearchHandler.getClaimsFromSearchString(userID: userID, searchString: searchString) { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let policies:Policies =  response as? Policies {
                    if policies.policyList != nil {
                        weakSelf.serchresult = policies.policyList!
                        print("Policy List\(String(describing: response))")
                        print("Serchresult List\(weakSelf.serchresult)")
                        //TableView reload
                        DispatchQueue.main.async {
                            if (weakSelf.serchresult.count > 0) {
                                weakSelf.searchHistoryTableView.reloadData()
                            }
                        }
                    }
                }
            }else {
                //weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
            }
        }
    }
    
    // MARK: - UI Design configuration
    func customUIDesignConfiguration() {
        
        //SearchBGView design configuration
        searchBackGroundView.cornerRadius = 26.5
        searchBackGroundView.borderWidth = 0.5
        searchBackGroundView.borderColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }
    
    
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        if (searchTextField.text == "Claims History Search" || searchTextField.text == "") {
          self.showSimpleAlert(title: "", message: "Please entry Claim details to search", actionTitle: "Ok")
        }else  if (searchTextField.text!.count > 0) {
            self.getClaimsFromSearchString(userID: "", searchString: searchTextField.text!)
        }
    }
    
    @IBAction func logoBtnAction(_ sender: UIButton) {
         self.popToDashboardViewController()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func menuBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func movetoClaimJourneyStageVC(policy: Policy) {
        self.performSegue(withIdentifier: "ClaimJourneyID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClaimJourneyID" {
            let claimJourneyVC = segue.destination as! ClaimJourneyViewController
            if selectedClaimDetails != nil {
               claimJourneyVC.policyDetails = selectedClaimDetails
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serchresult.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let claimTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ClaimsHistoryTableViewCell", for: indexPath) as! ClaimsHistoryTableViewCell
        //Set up the cell contents
        claimTableViewCell.setDataforCell(index: indexPath.row, policy: serchresult[indexPath.row])
        claimTableViewCell.selectionStyle = .none
        return claimTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("searchHistoryTableView -- didSelectRowAt --->\(indexPath.row)")
        print("searchHistoryTableView -- didSelectRowAt Policy --->\(serchresult[indexPath.row])")
        selectedClaimDetails = serchresult[indexPath.row]
        self.movetoClaimJourneyStageVC(policy: selectedClaimDetails!)
    }
}

extension SearchViewController: UITextFieldDelegate {
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        
        if (textField.text == "Claims History Search") {
            textField.text = ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        if (textField.text == "") {
            textField.text = "Claims History Search"
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
}
