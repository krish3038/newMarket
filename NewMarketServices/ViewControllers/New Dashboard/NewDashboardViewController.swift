//
//  NewDashboardViewController.swift
//  NewMarketServices
//
//  Created by admin on 18/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import MMDrawerController

class NewDashboardViewController: BaseViewController {

    @IBOutlet weak var pieContainer: UIView!
    @IBOutlet weak var lineContainer: UIView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var myCasesTopBorderView: UIView!
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var myCasesContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyTheme()
        
//        if (SessionManager.shared.loginResponseData?.userRole == Theme.Policyholder.rawValue){
//            pieContainer.isHidden = true
//            lineContainer.isHidden = true
//        }
    }
    
    func applyTheme() {
        headerView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        swipeView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        myCasesTopBorderView.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mainMenuAction(_ sender: Any) {
        self.mm_drawerController.toggle(.left, animated: true, completion: nil)
    }
    
    @IBAction func bottomViewSwiped(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if(translation.y == 0){
            return
        }
        
        let dragVelocity = topLayoutConstraint.constant + translation.y
        
        if(translation.y < 0){ // Dragging upwards
            if dragVelocity > ((self.pieContainer.frame.height * -1) + (self.pieContainer.frame.height * 0.1)) {  // (height * -1) + (10% of height)
                self.topLayoutConstraint.constant = dragVelocity
                myCasesContainerBottomConstraint.constant = 10

            }
        }
        else { //Dragging downwards
            if (dragVelocity < 0) {
                self.topLayoutConstraint.constant =  dragVelocity
                myCasesContainerBottomConstraint.constant = 10
            }
            else {
                self.topLayoutConstraint.constant = 0
            }
        }
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
  
    @IBAction func unwindToNewDashboard(segue:UIStoryboardSegue) {
        
    }


}
