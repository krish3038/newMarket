//
//  PDFViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 8/1/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    @IBOutlet weak var PDFRightView: UIView!
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollBtn: UIButton!
    @IBOutlet weak var PDFView: UIView!

    
    var panGesture = UIPanGestureRecognizer()

    
    ////////////////////////////////////////////////////
    @IBOutlet weak var pdfViewCtrlClaim: FSPDFViewCtrl!
    var extensionsManagerClaim: UIExtensionsManager!
    
    @IBOutlet weak var pdfViewCtrlPolicy: FSPDFViewCtrl!
    var extensionsManagerPolicy: UIExtensionsManager!
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    ////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(PDFViewController.draggedView(_:)))
        scrollBtn.isUserInteractionEnabled = true
        scrollBtn.addGestureRecognizer(panGesture)
        
        loadClaimPDF()
        loadPolicyPDF()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func loadClaimPDF() {
        pdfViewCtrlClaim.register(self as IDocEventListener)
        
        // Get the path of the JSON configuration file.
        let configPath = Bundle.main.path(forResource: "uiextensions_config", ofType: "json")
        var data: Data?
        if nil != configPath {
            data = NSData(contentsOfFile: configPath!) as Data?
        }
        
        let pdfPath = documentsPath + "/Sample.pdf"
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
    
    func loadPolicyPDF() {
        pdfViewCtrlPolicy.register(self as IDocEventListener)
        
        // Get the path of the JSON configuration file.
        let configPath = Bundle.main.path(forResource: "uiextensions_config", ofType: "json")
        var data: Data?
        if nil != configPath {
            data = NSData(contentsOfFile: configPath!) as Data?
        }
        let pdfPath = documentsPath + "/Genetic_Programming.pdf"
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
    
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.PDFView)
        if(translation.x == 0){
            return
        }
        //moving to left direction
        if(translation.x < 0){
            
            // if((scrollButton.center.x + translation.x) > (notesBtn.center.x + 200)){
            if((scrollBtn.center.x + translation.x) > 500){
                rightViewWidth.constant = rightViewWidth.constant - translation.x
                scrollBtn.center = CGPoint(x: scrollBtn.center.x - translation.x, y: scrollBtn.center.y)
                sender.setTranslation(CGPoint.zero, in: PDFView)
            }
        }
            //moving to right direction
        else{
            if(rightViewWidth.constant > PDFView.center.x/2){
                rightViewWidth.constant = rightViewWidth.constant - translation.x
                scrollBtn.center = CGPoint(x: scrollBtn.center.x + translation.x, y: scrollBtn.center.y)
                sender.setTranslation(CGPoint.zero, in: PDFView)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pdfViewCtrlClaim.unregisterDocEventListener(self)
        pdfViewCtrlPolicy.unregisterDocEventListener(self)
    }
}

    extension PDFViewController: UIExtensionsManagerDelegate {
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
    
    extension PDFViewController: IDocEventListener {
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


