//
//  ClaimAndPolicyViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/7/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimAndPolicyViewController: BaseViewController {
    
    
    @IBOutlet weak var scrollButton: UIButton!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnPolicyNo: UIButton!
    @IBOutlet weak var btnClaimNo: UIButton!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblPolicyEffectiveDate: UILabel!
    @IBOutlet weak var lblPolicyExpiryDate: UILabel!
    @IBOutlet weak var lblDateOfLoss: UILabel!
    
    @IBOutlet weak var auditView: UIView!
    @IBOutlet weak var auditTableView: UITableView!
    
    //    @IBOutlet weak var lblClaim1: UILabel!
    //    @IBOutlet weak var lblClaim2: UILabel!
    //    @IBOutlet weak var lblPolicy: UILabel!
    
    var panGesture = UIPanGestureRecognizer()
    var initialSetup = true
    
    var claimInvestigateDetails:ClaimInvestigate?
    var claimNo:String = ""
    var policyNo:String = ""
    
    var claimPDFPath : String = ""
    var policyPDFPath : String = ""
    
    
    ////////////////////////////////////////////////////
    @IBOutlet weak var pdfViewCtrlClaim: FSPDFViewCtrl!
    var extensionsManagerClaim: UIExtensionsManager!
    
    @IBOutlet weak var pdfViewCtrlPolicy: FSPDFViewCtrl!
    var extensionsManagerPolicy: UIExtensionsManager!
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    ////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ClaimAndPolicyViewController.draggedView(_:)))
        scrollButton.isUserInteractionEnabled = true
        scrollButton.addGestureRecognizer(panGesture)
        
        //Service - Get Claim Investigate Details
        //  self.getClaimInvestigateDetails(userID: "", claimNumber: claimNo)
     
        self.getClaimInvestigateRecord(claimNo: claimNo) { (result) in
            self.updatePDFData()
        }
        //////////////////////////////////////////
        // Copy PDF from Bundle to Documents directory.
        try! self.copyfileToUserDocumentDirectory(forResource: "Sample", ofType: "pdf")
        try! self.copyfileToUserDocumentDirectory(forResource: "Genetic_Programming", ofType: "pdf")
        //        try! self.copyfileToUserDocumentDirectory(forResource: "Mississauga_Advantages", ofType: "pdf")
        //        try! self.copyfileToUserDocumentDirectory(forResource: "multimedia", ofType: "pdf")
        /////////////////////////////////////////
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rightViewWidth.constant = (self.baseView.frame.width/2) - 85

//        self.getClaimPDF(claimNo: claimNo)
//        self.getPolicyPDF(claimNo: claimNo)

        leftView.bringSubview(toFront: auditView)
        auditView.isHidden = true
    }
    
    func loadClaimPDF(pdfPath:String) {
        pdfViewCtrlClaim.register(self as IDocEventListener)
        
        // Get the path of the JSON configuration file.
        let configPath = Bundle.main.path(forResource: "uiextensions_config", ofType: "json")
        var data: Data?
        if nil != configPath {
            data = NSData(contentsOfFile: configPath!) as Data?
        }
        
     //   let pdfPath = documentsPath + "/Sample.pdf"
        // Set the document to display.
        print("Open: \(pdfPath)")
        pdfViewCtrlClaim.openDoc(pdfPath, password: nil, completion: nil)
        
        // Initialize a UIExtensionsManager object and set it to pdfViewCtrl.
        extensionsManagerClaim = UIExtensionsManager(pdfViewControl: pdfViewCtrlClaim, configuration: data)
        extensionsManagerClaim.delegate = self
        if nil == extensionsManagerClaim  {
            return
        }
        pdfViewCtrlClaim.extensionsManager = extensionsManagerClaim;
        
        //Hide some tools
        extensionsManagerClaim.setToolbarItemHiddenWithTag(UInt(FS_TOPBAR_ITEM_BACK_TAG), hidden: true)
        //        extensionsManagerClaim.setToolbarItemHiddenWithTag(UInt(FS_TOPBAR_ITEM_MORE_TAG), hidden: true)
        //
        //        extensionsManagerClaim.panelController.setPanelHidden(true, type: .attachment)
    }
    
    func loadPolicyPDF(pdfPath:String) {
        pdfViewCtrlPolicy.register(self as IDocEventListener)
        
        // Get the path of the JSON configuration file.
        let configPath = Bundle.main.path(forResource: "uiextensions_config", ofType: "json")
        var data: Data?
        if nil != configPath {
            data = NSData(contentsOfFile: configPath!) as Data?
        }
       // let pdfPath = documentsPath + "/Genetic_Programming.pdf"
        // Set the document to display.
        print("Open: \(pdfPath)")
        pdfViewCtrlPolicy.openDoc(pdfPath, password: nil, completion: nil)
        
        // Initialize a UIExtensionsManager object and set it to pdfViewCtrl.
        extensionsManagerPolicy = UIExtensionsManager(pdfViewControl: pdfViewCtrlPolicy, configuration: data)
        extensionsManagerPolicy.delegate = self
        if nil == extensionsManagerPolicy  {
            return
        }
        pdfViewCtrlPolicy.extensionsManager = extensionsManagerPolicy;
        
        //Hide some tools
        extensionsManagerPolicy.setToolbarItemHiddenWithTag(UInt(FS_TOPBAR_ITEM_BACK_TAG), hidden: true)
        //        extensionsManagerPolicy.setToolbarItemHiddenWithTag(UInt(FS_TOPBAR_ITEM_MORE_TAG), hidden: true)
        //
        //        extensionsManagerPolicy.panelController.setPanelHidden(true, type: .attachment)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pdfViewCtrlClaim.unregisterDocEventListener(self)
        pdfViewCtrlPolicy.unregisterDocEventListener(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                               .userDomainMask,
                                                               true).first {
            let fileName = "\(name).\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path
            
            if !FileManager.default.fileExists(atPath: fullDestPathString) {
                try FileManager.default.copyItem(atPath: bundlePath, toPath: fullDestPathString)
            }
        }
    }
    
    func updatePDFData()
    {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.getClaimPDF(claimNo: claimNo) { (result) in
            self.claimPDFPath = (result as! NSString) as String
            self.loadClaimPDF(pdfPath: self.claimPDFPath)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getPolicyPDF(policyNo: policyNo) { (result) in
            self.policyPDFPath = result as! String
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.loadPolicyPDF(pdfPath: self.policyPDFPath)
            print("Both functions complete 👍")
        }
    }
    private func getClaimPDF(claimNo : String ,completion: @escaping (_ result:Any?) ->Void){
        
        let claimPDFService = ClaimPdfService()
        let loginReq = SessionManager.shared.loginReq
        
        self.showActivityIndicator()
        claimPDFService.getClaimPdf(credentials: loginReq!, claimNo: claimNo , pdfService:ServiceUrls.PDFType.CLAIM_PDF) { (data, error) in
            DispatchQueue.main.async {
            self.stopActivityIndicator()
            if error == nil {
                let claimPDFResponse : ClaimPdfResponse = (data as? ClaimPdfResponse)!
                let pdfsArray = claimPDFResponse.jsonObj
                
                let pdfs = pdfsArray![0]
                let pdflink = pdfs.ClaimDetails1
                self.getPDFfilePath(fileUrl: pdflink, fileName: "/Claim", completion: { (result) in
                    print("filePath : \(String(describing: result))")
                 //   self.loadClaimPDF(pdfPath: result as! String)
                    completion(result)

                })
            } else{
                self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                    }])
            }
        }
        }
    }
    
    private func getPolicyPDF(policyNo : String, completion: @escaping (_ result:Any?) ->Void){
        let claimPDFService = ClaimPdfService()
        let loginReq = SessionManager.shared.loginReq
        claimPDFService.getClaimPdf(credentials: loginReq!, claimNo: policyNo , pdfService:ServiceUrls.PDFType.POLICY_PDF) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    let policyPDFResponse : PolicyPdfResponse = (data as? PolicyPdfResponse)!
                    let pdfsArray = policyPDFResponse.jsonObj
                    let policyPdfDetails = pdfsArray![0]
                    let policyPdfURL = policyPdfDetails.PolicyDetails1
                    self.getPDFfilePath(fileUrl: policyPdfURL, fileName: "/Policy", completion: { (result) in
                        print("filePath : \(String(describing: result))")
                       // self.loadPolicyPDF(pdfPath: result as! String)
                        completion(result)
                    })
                } else{
                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                        }])
                }
            }
        }
    }
    
    func getPDFfilePath(fileUrl:String?,fileName:String ,completion: @escaping (_ result:Any?) ->Void)
    {
        do {
            //let tempPDF1 = "https://s3-eu-west-1.amazonaws.com/lloyds-project/Claims/231XZ76501_claim1.pdf"
           //let tempPDF2 : String? = "https://s3-eu-west-1.amazonaws.com/lloyds-project/Claims/231XZ76501_claim1.pdf"
            if let link = fileUrl {
                if let url = URL(string: link) {
                    let pdfData = try Data(contentsOf: url)
                    let savePDFPath = self.documentsPath + fileName
                    if !FileManager.default.fileExists(atPath: savePDFPath)
                    {
                        try FileManager.default.createDirectory(at: URL(fileURLWithPath: savePDFPath, isDirectory: true), withIntermediateDirectories: true, attributes: nil)
                    }
                    let pdfFilePath = savePDFPath + fileName + ".pdf"
                    try pdfData.write(to:URL(fileURLWithPath: pdfFilePath, isDirectory: true))
                    completion(pdfFilePath)
                    print("pdfPath = \(pdfFilePath)")
                }
            }
        }
        catch let error {
            // Error handling
            self.showAlertWithAction(title: "", message: error.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                }])
        }
    }
    private func getClaimInvestigateRecord(claimNo : String , completion: @escaping(_ result:Any)->Void){
        let claimInvestigateService = ClaimInvestigateService()
        let loginReq = SessionManager.shared.loginReq
        claimInvestigateService.getClaimInvestigateRecord(credentials: loginReq!, claimNo: claimNo) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    let claimInvestigateData : ClaimInvestigateResponse = (data as? ClaimInvestigateResponse)!
                    let claimInvestigateRecord = claimInvestigateData.claimInvestigateList
                    let claimInvestigationManager = ClaimInvestigateManager.shared
                    claimInvestigationManager.claimInvestigateData = (claimInvestigateRecord?.count)! > 0 ? claimInvestigateRecord?[0] : nil
                    print(claimInvestigateRecord?.count ?? 0)
                    self.updateUI(claimInvestigate: claimInvestigationManager.claimInvestigateData)
                    completion(true)
                } else{
                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                        }])
                }
            }
            
        }
    }
    
    func getClaimInvestigateDetails(userID: String, claimNumber:String){
        self.showActivityIndicator()
        ClaimInvestigateHandler.getClaimInvestigateDetails(userID: userID, claimNumber: claimNumber) { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let claimInvestigates:ClaimInvestigates =  response as? ClaimInvestigates {
                    if claimInvestigates.claimInvestigateList != nil {
                        if ((claimInvestigates.claimInvestigateList?.count)! > 0) {
                            weakSelf.claimInvestigateDetails = claimInvestigates.claimInvestigateList?.first
                        }
                    }
                }
                // weakSelf.claimInvestigateDetails = (response as? ClaimInvestigate)!
                
                DispatchQueue.main.async {
                    //UI update
                    self?.updateUI(claimInvestigate: nil)
                }
            } else {
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
            }
        }
    }
    
    func updateUI(claimInvestigate:ClaimInvestigateRecord?)
    {
        // btnClaimNo.titleLabel?.text = claimInvestigate?.ClaimNo
        btnClaimNo.setTitle(claimInvestigate?.claimNumber, for: .normal)
        //  btnPolicyNo.titleLabel?.text = claimInvestigate?.PolicyNo
        btnPolicyNo.setTitle(claimInvestigate?.policyNumber, for: .normal)
        lblCompanyName.text = claimInvestigate?.insuredCompanyName
        
        lblPolicyEffectiveDate.text = DateUtilities.formattedDate((claimInvestigate?.policyEffectiveDate)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
        
        lblPolicyExpiryDate.text = DateUtilities.formattedDate((claimInvestigate?.policyExpiryDate)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
        
        lblDateOfLoss.text = DateUtilities.formattedDate((claimInvestigate?.claimDateofLoss)!, dateFormat: CustomDateFormat.kDisplayDateFormat)
        
    }
    
    
    @IBAction func saveClaimPDF(_ sender: Any) {
        print("save clicked")
        if (pdfViewCtrlClaim.currentDoc?.isModified())! {
            let sourceURL = URL(fileURLWithPath: pdfViewCtrlClaim.filePath!)
            let fileName = sourceURL.lastPathComponent
            let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            //let saveFlag = pdfViewCtrl.extensionsManagerClaim.docSaveFlag
            let isSuccess = pdfViewCtrlClaim.saveDoc(tempURL.path, flag: FSSaveFlags.init(rawValue: 0))
            print("save: \(isSuccess)")
            showSimpleAlert(title: "Alert", message: "Saved Successfully.", actionTitle: "OK")
            
            pdfViewCtrlClaim.closeDoc({
                let fileManager = FileManager.default
                do {
                    let docPath = try fileManager.replaceItemAt(sourceURL, withItemAt: tempURL)
                    self.pdfViewCtrlClaim.openDoc((docPath?.path)!, password: nil, completion: nil)
                } catch let error {
                    fatalError("\(error)")
                }
            })
        }
        else {
            showSimpleAlert(title: "Alert", message: "You have not modified the document.", actionTitle: "OK")
        }
    }
    
    @IBAction func savePolicyPDF(_ sender: Any) {
        print("save clicked")
        if (pdfViewCtrlPolicy.currentDoc?.isModified())! {
            let sourceURL = URL(fileURLWithPath: pdfViewCtrlPolicy.filePath!)
            let fileName = sourceURL.lastPathComponent
            let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            let isSuccess = pdfViewCtrlPolicy.saveDoc(tempURL.path, flag: FSSaveFlags.init(rawValue: 0))
            print("save: \(isSuccess)")
            showSimpleAlert(title: "Alert", message: "Saved Successfully.", actionTitle: "OK")
            
            pdfViewCtrlPolicy.closeDoc({
                let fileManager = FileManager.default
                do {
                    let docPath = try fileManager.replaceItemAt(sourceURL, withItemAt: tempURL)
                    self.pdfViewCtrlPolicy.openDoc((docPath?.path)!, password: nil, completion: nil)
                } catch let error {
                    fatalError("\(error)")
                }
            })
        }
        else {
            showSimpleAlert(title: "Alert", message: "You have not modified the document.", actionTitle: "OK")
        }
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.baseView)
        if(translation.x == 0){
            return
        }
        //moving to left direction
        if(translation.x < 0){
            
            // if((scrollButton.center.x + translation.x) > (notesBtn.center.x + 200)){
            if((scrollButton.center.x + translation.x) > 500){
                rightViewWidth.constant = rightViewWidth.constant - translation.x
                scrollButton.center = CGPoint(x: scrollButton.center.x - translation.x, y: scrollButton.center.y)
                sender.setTranslation(CGPoint.zero, in: self.baseView)
            }
        }
            //moving to right direction
        else{
            if(rightViewWidth.constant > baseView.center.x/2){
                rightViewWidth.constant = rightViewWidth.constant - translation.x
                scrollButton.center = CGPoint(x: scrollButton.center.x + translation.x, y: scrollButton.center.y)
                sender.setTranslation(CGPoint.zero, in: self.baseView)
            }
        }
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func iDonotKnowBtnAction(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmConflictOfInterestBtnAction(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "PresentQRScannerVC", sender: self)
        
        let conflictOfInrest = ConflictOfInterestServcie()
        let loginReq = SessionManager.shared.loginReq

        conflictOfInrest.sendConflictOfIntrestStatus(credentials: loginReq!, claimNo: claimNo, status: "Approved") { (result, error) in
            
            
        }
    }
    @IBAction func noConflictOfInterestBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoBtnAction(_ sender: UIButton) {
        self.popToDashboardViewController()
    }
    
    @IBAction func AuditBtnTapped(_ sender: Any) {
        
        if(auditView.isHidden == true){
            auditView.isHidden = false
        }
        else{
            auditView.isHidden = true
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmConflictOfInterestID" {
            //let commentsVC = segue.destination as! CommentsViewController
            //scannerVC.delegate = self
        }else if segue.identifier == "NoConfirmConflictOfInterestID" {
            //let commentsVC = segue.destination as! CommentsViewController
            //scannerVC.delegate = self
        }else if segue.identifier == "iDontKnowID" {
            //let commentsVC = segue.destination as! CommentsViewController
            //scannerVC.delegate = self
        }else if segue.identifier == "SearchControllerID" {
            //let commentsVC = segue.destination as! CommentsViewController
            //scannerVC.delegate = self
        }
    }
}

extension ClaimAndPolicyViewController: UIExtensionsManagerDelegate {
    func uiextensionsManager(_ uiextensionsManager: UIExtensionsManager, setTopToolBarHidden
        hidden: Bool) {
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            if hidden {
                // Hide the top toolbar.
                var frame: CGRect = uiextensionsManager.topToolbar!.frame
                frame.origin.y = -frame.size.height
                uiextensionsManager.topToolbar!.frame = frame
            } else {
                var frame: CGRect = uiextensionsManager.topToolbar!.frame
                frame.origin.y = 0//self.pdfViewCtrl.frame.origin.y
                uiextensionsManager.topToolbar!.frame = frame
            }
        }) }
}

extension ClaimAndPolicyViewController: IDocEventListener {
    func onDocOpened(_ document: FSPDFDoc?, error: Int32) {
        print("onDocOpened")
        if pdfViewCtrlClaim.currentDoc == document { //Claim
            extensionsManagerClaim.enableTopToolbar(true)
            extensionsManagerClaim.enableBottomToolbar(true)
        }
        else { //Policy
            extensionsManagerPolicy.enableTopToolbar(true)
            extensionsManagerPolicy.enableBottomToolbar(true)
        }
    }
    
    func onDocClosed(_ document: FSPDFDoc?, error: Int32) {
        print("onDocClosed")
        if pdfViewCtrlClaim.currentDoc == document { //Claim
            //extensionsManagerClaim.enableTopToolbar(false)
            //extensionsManagerClaim.enableBottomToolbar(false)
        }
        else { //Policy
            
        }
    }
    
    func onDocSaved(_ document: FSPDFDoc, error: Int32) {
        print("onDocSaved")
        if pdfViewCtrlClaim.currentDoc == document { //Claim
            
        }
        else { //Policy
            
        }
    }
    
}

extension ClaimAndPolicyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let auditTableCell = tableView.dequeueReusableCell(withIdentifier: "AuditTableViewCell", for: indexPath) as! AuditTableViewCell
        //Set up the cell contents
        auditTableCell.selectionStyle = .none
        auditTableCell.lblDateTime.text = "12 Jul 2016, 15:40:00"
        auditTableCell.lblEntryType.text = "Antiparticipant"
        auditTableCell.lblParticipant.text = "Riaxo"
        
        return auditTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let auditTableViewCell = tableView.dequeueReusableCell(withIdentifier:  "AuditTableViewCell") as! AuditTableViewCell
        
        auditTableViewCell.DateTimeView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        auditTableViewCell.EntryTypeView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        auditTableViewCell.participantView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        
        auditTableViewCell.lblDateTime.text = "Date, Time"
        auditTableViewCell.lblEntryType.text = "Entry Type"
        auditTableViewCell.lblParticipant.text = "Participant"
        
        return auditTableViewCell
    }
    
    
}
