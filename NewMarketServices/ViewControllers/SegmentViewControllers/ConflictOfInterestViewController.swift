//
//  ConflictOfInterestViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 7/4/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ConflictOfInterestViewController: BaseViewController {
    
    @IBOutlet weak var lblConflictOfInterest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showActivityIndicator()
        guard let eachCaseObject = ClaimInvestigateManager.shared.selectedMyCaseTask else { return }
        getConflictOfInterestData(claimNo: eachCaseObject.ClaimNo!)
    }
    
    func getConflictOfInterestData(claimNo : String){
        let conflictService = ConflictOfInterestServcie()
        var loginReq = LoginReq()
        loginReq.userName = "GaingKim"
        loginReq.UserPwd = "1234"
        conflictService.getConflictOfInterestData(credentials: loginReq, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    guard let conflictJsonData = data as? ConflictOfInterestResponse else{
                        return
                    }
                    let mypolicyArray : [ConflictOfInterestStatus] = conflictJsonData.conflictOfInterestStatus!
                    let status = mypolicyArray[0].status!
                    self.lblConflictOfInterest.text = "The Load carrier has \(status ? "" : "not") confirmed that ,there is no conflict of interest in processing the claim."
                }
                else {
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // lblConflictOfInterest.sizeToFit()
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
