//
//  BaseViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/1/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSimpleAlert(title:String, message:String, actionTitle:String) -> Void {
       // DispatchQueue.main.async {
            let alertCtrl:UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let okAction:UIAlertAction = UIAlertAction.init(title: actionTitle, style: .cancel, handler: nil)
            alertCtrl.addAction(okAction)
            self.present(alertCtrl, animated: true, completion: nil)
       // }
    }
    
    func showAlertWithAction(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This method is used to show loading indicator when application is busy with some request
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let existView = self.view.viewWithTag(1000)
            if existView != nil {
                existView?.removeFromSuperview()
            }
            
            let loadingView:UIView = UIView.init(frame: CGRect(x:0, y: 0, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height))
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            loadingView.tag = 1000
            loadingView.isUserInteractionEnabled = true
            
            let loadingActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            
            loadingActivityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44)
            loadingActivityIndicator.startAnimating()
            loadingActivityIndicator.center = loadingView.center
            loadingActivityIndicator.color = UIColor.white
            
            loadingView.addSubview(loadingActivityIndicator)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.addSubview(loadingView)

        }
    }
    
    /// This method is used to stop loading indicator
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let view = appDelegate.window?.viewWithTag(1000)
            if view != nil {
                view?.removeFromSuperview()
            }
        }
    }
    
    func popToDashboardViewController() {
         print("/n  PopToDashboardViewController method /n NavigationController---> ChildViewControllers --->/n ", self.navigationController?.childViewControllers as Any)
        for vc  in  (self.navigationController?.childViewControllers)! {
            if vc.isKind(of: DashboardViewController.self){
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
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
