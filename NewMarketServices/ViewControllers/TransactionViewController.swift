//
//  TransactionViewController.swift
//  NewMarketServices
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class TransactionViewController: BaseViewController {

    @IBOutlet weak var financialTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var policyNumberLabel: UILabel!
    @IBOutlet weak var policyNumberValue: UILabel!
    @IBOutlet weak var auditButton: UIButton!
    
    @IBOutlet weak var submitStackView: UIStackView!
    @IBOutlet weak var confirmStackView: UIStackView!
    
    var pointToBaseView:CGPoint?
    var scrollViewOffSetPoint:CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForKeyboardNotifications()
        applyTheme()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        submitStackView.isHidden = true
        confirmStackView.isHidden = false
    }
    
    @IBAction func resetAction(_ sender: Any) {
        
    }
    
    @IBAction func confirmTAAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelTAAction(_ sender: Any) {
        submitStackView.isHidden = false
        confirmStackView.isHidden = true
    }
    
    func applyTheme() {
        headerView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        policyNumberLabel.textColor = ThemeManager.currentTheme().backgroundColor
        policyNumberValue.textColor = ThemeManager.currentTheme().backgroundColor
        auditButton.setTitleColor(ThemeManager.currentTheme().backgroundColor, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterForKeyboardNotification()
    }
    
    fileprivate func registerForKeyboardNotifications() {
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func deregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide , object: nil)
    }
    
    @objc
    func keyboardWillAppear(notification: NSNotification?) {
        
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        let visiblePoint = (scrollView.frame.height - keyboardHeight)
        scrollViewOffSetPoint = scrollView.contentOffset
        if ((pointToBaseView?.y)! > visiblePoint){
            let offSetopint = (pointToBaseView?.y)! - visiblePoint
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y+offSetopint), animated: true)
        }
    }
    
    @objc
    func keyboardWillDisappear(notification: NSNotification?) {
        scrollView.contentOffset = scrollViewOffSetPoint!
    }

    func scrollToVisible(txtField: UITextField){
        pointToBaseView = txtField.superview?.convert(txtField.frame.origin, to: scrollView)
        
        // print("currentPoint : \(String(describing: globalPoint))")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "FINANCIAL_OVERVIEW_PART1_ID" {
            let vc = segue.destination as! FinancialOverviewPart1ViewController
            vc.delegate = self
        }
        else if segue.identifier == "FINANCIAL_OVERVIEW_PART2_ID" {
            let vc = segue.destination as! FinancialOverviewPart2ViewController
            vc.delegate = self
        }
        else if segue.identifier == "FINANCIAL_OVERVIEW_PART3_ID" {
            let vc = segue.destination as! FinancialOverviewPart3ViewController
            vc.delegate = self
        }
    }
}

extension TransactionViewController: FinancialOverviewPart3Delegate, FinancialOverviewPart2Delegate, FinancialOverviewPart1Delegate {
    func textFieldFocused(textField: UITextField) {
        scrollToVisible(txtField: textField)
    }
}

//extension TransactionViewController: FinancialOverviewChildControllerDelegate {
//    func textFieldFocused(textField: UITextField) {
//        scrollToVisible(txtField: textField)
//    }
//}

//extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FinancialDetailsTableViewCellID", for: indexPath) as! FinancialDetailsTableViewCell
//        //TODO: set delegate and tag
//        cell.setDelegate(self, index: indexPath)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
//        }
//        else {
//            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//        }
//    }
//}
