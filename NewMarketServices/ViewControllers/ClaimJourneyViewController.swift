//
//  ClaimJourneyViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/10/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import MMDrawerController
enum RequestClaimStage:Int
{
    case ConflictOfInterest = 0
    case ClaimEvaluation
    case ClaimSettlement
    case PremiumCheck
    case HouseKeeping
}

class ClaimJourneyViewController: BaseViewController {
    
    @IBOutlet weak var MainStageView: UIView!
    @IBOutlet weak var claimStageContainerView: UIView!
    @IBOutlet weak var segmentContainerView: UIView!
    @IBOutlet weak var segmentContainer: UIView!
    @IBOutlet weak var segmentTitle: UILabel!
    @IBOutlet weak var segmentNo: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var claimStageContainer: UIView!
    
    @IBOutlet weak var insuredCompanyNameLabel: UILabel!
    @IBOutlet weak var claimNumberLabel: UILabel!
    @IBOutlet weak var btnclaimNo: UIButton!
    
    @IBOutlet weak var policyNumberLabel: UILabel!
    @IBOutlet weak var btnPolicyNo: UIButton!
    @IBOutlet weak var policyEffectiveDateLabel: UILabel!
    @IBOutlet weak var policyExpiryDateLabel: UILabel!
    @IBOutlet weak var dateOfLossLabel: UILabel!
    
    @IBOutlet weak var auditButton: UIButton!
    
    
    @IBOutlet weak var PDFView: UIView!
    
    @IBOutlet weak var pdfTopSpaceToHeaderView: NSLayoutConstraint!
    var panGesture = UIPanGestureRecognizer()
    var spinningWheel :  SpinningWheelDynamicV16? = nil
    
    ////////////////////////////////////////////////////
    @IBOutlet weak var pdfViewCtrlClaim: FSPDFViewCtrl!
    var extensionsManagerClaim: UIExtensionsManager!
    
    @IBOutlet weak var pdfViewCtrlPolicy: FSPDFViewCtrl!
    var extensionsManagerPolicy: UIExtensionsManager!
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    ////////////////////////////////////////////////////
    
    
    var claimDetails : Claim? = nil
    var policyDetails : Policy? = nil
    var claimNumber :String?
    
    var reqClaimStage : RequestClaimStage?
    
    var additionalInfos: AdditionalInfos? = nil
    let segmentTitles = ["Conflict of Interest", "Claim Evaluation", "Claim Settlement", "Premium Check", "Housekeeping Check"]
    //let segmentTitles = ["Conflict of Interest", "Claim Evaluation", "Claim Settlement", "Premium Check", "Housekeeping Check"]
    var selectedIndex: Int = 0 {
        didSet {
            
            segmentNo.text = "\(selectedIndex + 1)"
            segmentTitle.text = segmentTitles[selectedIndex]
            
        }
    }
    
    private lazy var ClaimEvaluationVC: ClaimEvaluationViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "iPadScreens", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ClaimEvaluationVC") as! ClaimEvaluationViewController
        
        // Add View Controller as Child View Controller
        // self.add(asChildViewController: viewController)
        self.addChildContainer(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var ConflictOfInterestVC: ConflictOfInterestViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "iPadScreens", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ConflictOfInterestVC") as! ConflictOfInterestViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var ClaimPaymentVC: ClaimPaymentViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "iPadScreens", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ClaimPaymentVC") as! ClaimPaymentViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var PremiumCheckVC: PremiumCheckViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "iPadScreens", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "PremiumCheckVC") as! PremiumCheckViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var HouseKeepingCheckVC: HouseKeepingCheckViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "iPadScreens", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "HouseKeepingCheckVC") as! HouseKeepingCheckViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        
        do {
            //iPhone
            //var spinningWheel = try SpinningWheelDynamicV7(frame: CGRect(x: 50, y: 100, width: 240, height: 240), delegate: self, sections: 6)
            //iPad
            spinningWheel = try SpinningWheelDynamicV16(frame: CGRect(x: 5, y: 20, width: 320, height: 640), delegate: self, sections: 6,  listSeries: ["Completed", "Completed" ,"Completed", "Completed", "Completed"])
            self.rightView.addSubview(spinningWheel!)
        } catch {
            print(error)
        }
        
        if policyDetails == nil
        {
            //self.updateUIData(policy: policyDetails!)
            //self.showActivityIndicator()
            //self.getClaimInvestigateRecord(claimNo: claimNumber!)
        }
        
        //Mark: - Get Segmentation details from server
        //  self.getSegmentationDetails(userID: "", claimNumber: "")
        
        
        
    }
    
    func applyTheme() {
        headerView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        claimNumberLabel.textColor = ThemeManager.currentTheme().backgroundColor
        btnclaimNo.titleLabel?.textColor = ThemeManager.currentTheme().backgroundColor
        policyNumberLabel.textColor = ThemeManager.currentTheme().backgroundColor
        btnPolicyNo.titleLabel?.textColor = ThemeManager.currentTheme().backgroundColor
        auditButton.setTitleColor(ThemeManager.currentTheme().backgroundColor, for: .normal)
    }
    
    @IBAction func btnPolicyNoTapped(_ sender: Any) {
        
        //        [UIView animateWithDuration:1.0 animations:^{
        //            button.frame = CGRectMake(position.x+80,position.y,size.width,size.height);
        //            }];
        
        
        UIView.animate(withDuration: 1.0) {
            if( self.pdfTopSpaceToHeaderView.constant >  0){
                self.pdfTopSpaceToHeaderView.constant =  0
            }
            else{
                self.pdfTopSpaceToHeaderView.constant =  UIScreen.main.bounds.height - (self.headerView.frame.origin.y + self.headerView.frame.height)
            }
        }
        
        
        //  PDFView.addMotionEffect(.init())
        
    }
    
    
    private func updateUIData(policy: Policy?) {
        if policy != nil {
            self.insuredCompanyNameLabel.text = policy?.companyName
            self.claimNumberLabel.text = policy?.claimNumber
            self.policyNumberLabel.text = policy?.policyNumber
            self.policyEffectiveDateLabel.text = DateUtilities.formattedDate((policy?.policyEffectiveDate)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
            self.policyExpiryDateLabel.text = DateUtilities.formattedDate((policy?.policyExpiryDate)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
            self.dateOfLossLabel.text = policy?.dateOfLoss
        }
    }
    
    private func getClaimInvestigateRecord(claimNo : String){
        let claimInvestigateService = ClaimInvestigateService()
        let loginReq = SessionManager.shared.loginReq
        claimInvestigateService.getClaimInvestigateRecord(credentials: loginReq!, claimNo: claimNumber!) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    let claimInvestigateData : ClaimInvestigateResponse = (data as? ClaimInvestigateResponse)!
                    let claimInvestigateRecord = claimInvestigateData.claimInvestigateList
                    let claimInvestigationManager = ClaimInvestigateManager.shared
                    claimInvestigationManager.claimInvestigateData = (claimInvestigateRecord?.count)! > 0 ? claimInvestigateRecord?[0] : nil
                    print(claimInvestigateRecord?.count ?? 0)
                    self.updateUI(claimInvestigate: claimInvestigationManager.claimInvestigateData)
                    
                } else{
                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                        }])
                }
            }
        }
    }
    
    private func updateUI(claimInvestigate:ClaimInvestigateRecord?)
    {
        if claimInvestigate != nil {
            self.insuredCompanyNameLabel.text = claimInvestigate?.insuredCompanyName
            self.btnclaimNo.titleLabel?.text = claimInvestigate?.claimNumber
            self.btnPolicyNo.titleLabel?.text = claimInvestigate?.policyNumber
            //   self.policyTypeLabel.text = claimInvestigate.
            self.policyEffectiveDateLabel.text = DateUtilities.formattedDate((claimInvestigate?.policyEffectiveDate!)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
            self.policyExpiryDateLabel.text = DateUtilities.formattedDate((claimInvestigate?.policyExpiryDate!)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
            self.dateOfLossLabel.text = DateUtilities.formattedDate((claimInvestigate?.claimDateofLoss!)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if policyDetails != nil
        {
            selectedIndex = 0
            add(asChildViewController: ConflictOfInterestVC)
        }
        else
        {
            selectedIndex = reqClaimStage!.rawValue
            wheelDidSpin(bySelectedIndex: reqClaimStage!.rawValue)
            spinningWheel?.rotateTo(index: selectedIndex)
        }
        
        pdfTopSpaceToHeaderView.constant = UIScreen.main.bounds.height - (headerView.frame.origin.y + headerView.frame.height)
        
        print(pdfTopSpaceToHeaderView.constant)
        
    }
    
   
    @IBAction func mainMenuAction(_ sender: Any) {
        self.mm_drawerController.toggle(.left, animated: true, completion: nil)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoBtnAction(_ sender: UIButton) {
        self.popToDashboardViewController()
    }
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        segmentContainer.addSubview(viewController.view)
        
        MainStageView.bringSubview(toFront: segmentContainerView)
        segmentContainerView.isHidden = false
        claimStageContainerView.isHidden = true
        
        // Configure Child View
        viewController.view.frame = segmentContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func addChildContainer(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        claimStageContainer.addSubview(viewController.view)
        
        MainStageView.bringSubview(toFront: claimStageContainerView)
        segmentContainerView.isHidden = true
        claimStageContainerView.isHidden = false
        
        
        // Configure Child View
        viewController.view.frame = claimStageContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    private func removeChildContainer(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    private func getSegmentationDetails (userID: String?, claimNumber: String?) {
        self.showActivityIndicator()
        SegmentationHandler.getSegmentations(userID: userID, claimNumber: claimNumber) { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let info:AdditionalInfos =  response as? AdditionalInfos {
                    weakSelf.additionalInfos = info
                }
            }else {
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
            }
        }
    }
    
}

extension ClaimJourneyViewController: SpinningWheelDelegate {
    func wheelDidRotateBy(angle: CGFloat) {
        print("wheelDidRotateBy---->\(angle)")
    }
    
    func wheelDidSpin(bySelectedIndex: Int) {
        print ("WheelDidSpin --->bySelectedIndex----->\(bySelectedIndex)")
        self.selectedIndex = bySelectedIndex
        
        childViewControllers.forEach({
            remove(asChildViewController: $0)
        })
        switch bySelectedIndex {
        case 0:
            add(asChildViewController: ConflictOfInterestVC)
        case 1:
            addChildContainer(asChildViewController: ClaimEvaluationVC)
        case 2:
            add(asChildViewController: ClaimPaymentVC)
        case 3:
            add(asChildViewController: PremiumCheckVC)
        case 4:
            add(asChildViewController: HouseKeepingCheckVC)
            HouseKeepingCheckVC.delegate = self
            //        case 6:
            //            add(asChildViewController: ClaimPaymentVC)
            //        case 7:
            //            add(asChildViewController: ClaimPaymentVC)
            //        case 8:
            //            add(asChildViewController: PremiumCheckVC)
            //        case 9:
            //            add(asChildViewController: HouseKeepingCheckVC)
        //            HouseKeepingCheckVC.delegate = self
        default:
            print("default case")
        }
    }
    
    
    @IBAction func home(sender:UIButton){
        
        performSegue(withIdentifier: "unwindToNewDashboardSegue", sender: self)
        
    }
}


extension ClaimJourneyViewController: HouseKeepingCheckVCDelegate {
    func didAgreedTap() {
        print("didAgreedTap")
    }
    
    func didPaidTap() {
        print("didPaidTap")
    }
    
    func didNoTap() {
        print("didNoTap")
    }
}

