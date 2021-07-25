//
//  MyCasesViewController.swift
//  NewMarketServices
//
//  Created by Vinay Kumar Yedla on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

struct ClaimStageRequest
{
    static let CLAIM_SETTLEMENT = "Claim Settlement"
    static let CLAIM_EXPERT_OPINION = "Claim Expert Opinion"
    static let CLAIM_QUERY = "Claim Query"
    static let CLAIM_SEGMENTATION = "Claim Segmentation"
    static let CONFLICT_OF_INTEREST = "Conflict Of Interest"
    static let PREMIUM_CHECK = "premium Check"
    static let HOUSE_KEEPING = "House Keeping"
}

struct ClaimTaskStatusRequest
{
    static let PENDING = "Pending"
    static let COMPLETED = "Completed"
    static let INPROGRESS = "Inprogress"
    static let CLOSED = "Closed"
}

class MyCasesViewController: BaseViewController {
    
    
    @IBOutlet weak var myCasesTableView:UITableView!
    @IBOutlet weak var myCasesHeaderView:UIView!
    
    
    var sectionsData : [Section]?
    var myCasesDetails : [EachCase]?
    var myCase : MyCases?
    var myEachCase : EachCase?
    var requestClaimStage : RequestClaimStage?
    
    var myCases : [MyCases]? {
        didSet {
            
            guard let cases = myCases else { return }
            
            var allSectionsData = [Section]()
            for (_ , eachCase) in cases.enumerated() {
                
                //                let isSectionEnabled = (index == 0) ? true : false
                let isSectionEnabled = false
                let eachSectionData = Section(collapsable: true , isOpened: isSectionEnabled, myCase: eachCase)
                allSectionsData.append(eachSectionData)
            }
            
            sectionsData = allSectionsData
            myCasesTableView.reloadData()
            
        }
    }
    
    private var tapEnabled : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpUI() {
        myCasesTableView.delegate = self
        myCasesTableView.dataSource = self
        
        myCasesHeaderView.borderColor = UIColor.white
        myCasesHeaderView.borderWidth = 1.0
    }
    
    func getData() {
        
        getMycases()
        
        //        getMyCasesFromJSON { (data, error) in
        //            DispatchQueue.main.async {
        //                self.stopActivityIndicator()
        //                if error == nil {
        //                    let mycaseJsonData: MyCasesResponse =  (data as? MyCasesResponse)!
        //                    self.myCases = mycaseJsonData.jsonObj
        //
        //                }
        //                else {
        //                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
        //                        }])
        //                }
        //            }
        //        }
    }
    
    func getMyCasesFromJSON(completion: @escaping (Any?, Error?) -> Void) {
        do
        {
            if let file = Bundle.main.url(forResource: "MyCasesDetails", withExtension: "json")
            {
                let data = try Data(contentsOf: file)
                let parseResponse =  parseCases(data: data)
                if parseResponse is NetworkErrorType {
                    completion(nil, parseResponse as? NetworkErrorType)
                }else{
                    completion(parseResponse, nil)
                }
            }
            
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
    private func parseCases(data:Any) -> Any? {
        do {
            return try MyCasesResponse.decode(data: data as! Data)
            
        }
        catch {
            return  NetworkErrorType.JSONParseError
        }
        
    }
    
    func getMycases(){
        let mycaseService = MyCasesService()
        let loginReq = SessionManager.shared.loginReq
        
        self.showActivityIndicator()
        mycaseService.getMyCases(credentials: loginReq!) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    let mycaseJsonData: MyCasesResponse =  (data as? MyCasesResponse)!
                    self.myCases = mycaseJsonData.myCasesList
                }
                else {
                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                        }])
                }
            }
        }
    }
    
    func moveToClaimJourneyStage(claimStage : String)
    {
        switch claimStage
        {
        case ClaimStageRequest.CLAIM_SETTLEMENT:
            requestClaimStage = RequestClaimStage.ClaimSettlement
        case ClaimStageRequest.CLAIM_EXPERT_OPINION:
            requestClaimStage = RequestClaimStage.ClaimEvaluation
        case ClaimStageRequest.CLAIM_QUERY:
            requestClaimStage = RequestClaimStage.ClaimEvaluation
        case ClaimStageRequest.CLAIM_SEGMENTATION:
            requestClaimStage = RequestClaimStage.ClaimEvaluation
        case ClaimStageRequest.PREMIUM_CHECK:
            requestClaimStage = RequestClaimStage.PremiumCheck
        case ClaimStageRequest.HOUSE_KEEPING:
            requestClaimStage = RequestClaimStage.HouseKeeping
        default:
            requestClaimStage = RequestClaimStage.ConflictOfInterest
        }
        self.performSegue(withIdentifier: "ClaimJourneyVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ClaimJourneyVC" {
            let claimJourneyVC = segue.destination as! ClaimJourneyViewController
            if myCase != nil
            {
                claimJourneyVC.claimNumber = myCase?.ClaimNo
                claimJourneyVC.reqClaimStage = requestClaimStage
            }
        }
        else
        {
            let claimPolicyVC = segue.destination as! ClaimAndPolicyViewController
            if myCase != nil
            {
                claimPolicyVC.claimNo = (myCase?.ClaimNo)!
                claimPolicyVC.policyNo = (myCase?.PolicyNo)!
            }
        }
    }
    
}

extension MyCasesViewController: UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sectionsCount  = sectionsData?.count else {
            return 1
        }
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sectionsData?[section].isOpened == true {
            guard let eachCasesCount = sectionsData?[section].myCase.details?.count else {
                //Section row
                return 1
            }
            // add section row also
            return eachCasesCount + 1
        }else {
            
            guard let _ = sectionsData?.count else { return 0 }
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = indexPath.row == 0 ? "MyCaseSectionCell" : "MyCaseDetailsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyCasesCell
        
        if indexPath.row == 0 {
            //Section header data
            cell.myCaseSection = sectionsData?[indexPath.section].myCase
            if let _ = sectionsData, let opened = sectionsData?[indexPath.section].isOpened {
                cell.isSectionCellSelected = (opened) ? true : false
            }
            cell.delegate = self
        }else {
            //Section cells data
            cell.myCaseEachCaseDetails = sectionsData?[indexPath.section].myCase.details![indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCase = myCases?[indexPath.section]
        let claimInvestigate = ClaimInvestigateManager.shared
        if indexPath.row != 0 {
            myEachCase = sectionsData?[indexPath.section].myCase.details![indexPath.row - 1]
            claimInvestigate.selectedMyCaseTask = myEachCase
            if (myEachCase?.Name == ClaimStageRequest.CONFLICT_OF_INTEREST) {
                if (myEachCase?.Status == ClaimTaskStatusRequest.INPROGRESS) || (myEachCase?.Status == ClaimTaskStatusRequest.PENDING) {
                    self.performSegue(withIdentifier: "ClaimPolicyVC", sender: self)
                    return
                }
                else
                {
                    self.moveToClaimJourneyStage(claimStage: (myEachCase?.Name)!)
                }
            }
            else
            {
                self.moveToClaimJourneyStage(claimStage: (myEachCase?.Name)!)
                
            }
        }
    }
}


extension MyCasesViewController :MyCasesTableDelegate {
    func didTapHeader(cell: MyCasesCell) {
        
        let indexPath = myCasesTableView.indexPath(for: cell)
        
        if indexPath?.row == 0 {
            if let opened = sectionsData?[(indexPath?.section)!].isOpened{
                sectionsData?[(indexPath?.section)!].isOpened = !opened
                cell.headerView.backgroundColor =  UIColor(hex: 0x101E4E)
                
                let sectionsToReload = IndexSet(integer: (indexPath?.section)!)
                myCasesTableView.reloadSections(sectionsToReload, with: .fade)
            }
        }
    }
}



















