//
//  LoginViewController.swift
//  NewMarketServices
//
//  Created by admin on 05/06/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    var count = 0
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.backgroundColor = ThemeManager.currentTheme().backgroundColor
        addPaddingForTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
        print( "\(#function)")
        
        userName.text = "Isabelle"
        password.text = "1234"
    }
    
    func addPaddingForTextFields() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        userName.leftView = paddingView
        userName.leftViewMode = .always
        
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.password.frame.height))
        password.leftView = paddingView1
        password.leftViewMode = .always
        
    }
    
    /**
     Notifies the view controller that its view is about to be removed from a view hierarchy.
     This method is called in response to a view being removed from a view hierarchy.
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print( "\(#function)")
        removeKeyboardObserver()
    }
    
    /// This method is used to add notification observer for keyboard
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        count += 1
        print( "\(#function) -> \(count)")
    }
    
    /// This method is used to remove notification observer for keyboard
    fileprivate func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        count -= 1
        print( "\(#function) -> \(count)")
    }
    
    /// This is Keyboard's notification observer method. It will execute while keyboard appears on the screen.
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    /// This is Keyboard's notification observer method. It will execute while keyboard disappears from the screen.
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    /// This method is used to adjust the bottom constraint based on keyboard appearance.
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height + 50) * (show ? 1 : -1)
        //5
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            if changeInHeight > 0 {
                self.bottomConstraint.constant = changeInHeight
            }else {
                self.bottomConstraint.constant = 70
            }
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginAction(_ sender: Any?) {
        
        if (userName.text?.isEmpty)! && (password.text?.isEmpty)! {
            self.showAlertWithAction(title: "", message: EMPTY_LOGIN_FIELDS, actionTitles: ["OK"], actions: [{action1 in
                self.userName.becomeFirstResponder()
                }])
        }
        else {
            if (userName.text?.isEmpty)!{
                self.showAlertWithAction(title: "", message: EMPTY_USERNAME_ERROR, actionTitles: ["OK"], actions: [{action1 in
                    self.userName.becomeFirstResponder()
                    }])
            }
            else if (password.text?.isEmpty)!{
                self.showAlertWithAction(title: "", message: EMPTY_PASSWORD_ERROR, actionTitles: ["OK"], actions: [{action1 in
                    self.password.becomeFirstResponder()
                    }])
            } else{
                UserDefaults.standard.set(userName.text, forKey: "UserName")
                //self.performSegue(withIdentifier: SegueIdentifier.kMoveToDashBoard, sender: self)
                //saveThemeFor(user: userName.text!)
                //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //                appDelegate.showDashboard()
                
                self.showActivityIndicator()
                self.loginUser()
                
                /*self.showActivityIndicator()
                 LoginHandler.getloginWith(username: self.userName.text!, password: self.password.text!) { [weak self]  (isSuccess, errorMessage, response) in
                 self?.stopActivityIndicator()
                 guard let weakSelf = self else {
                 return
                 }
                 if isSuccess! {
                 weakSelf.userName.text = ""
                 weakSelf.password.text = ""
                 weakSelf.performSegue(withIdentifier: SegueIdentifier.kMoveToDashBoard, sender: self)
                 }else {
                 weakSelf.showAlertWithAction(title: "", message: errorMessage, actionTitles: ["OK"], actions: [{action1 in
                 weakSelf.userName.becomeFirstResponder()
                 }])
                 }
                 }*/
            }
        }
    }
    
    func saveThemeFor(user: String) {
        if user == Theme.Broker.rawValue {
            ThemeManager.applyTheme(theme: .Broker)
        }
        else if user == Theme.CarrierAndFollower.rawValue {
            ThemeManager.applyTheme(theme: .CarrierAndFollower)
        }
        else if user == Theme.Policyholder.rawValue {
            ThemeManager.applyTheme(theme: .Policyholder)
        }
        else if user == Theme.TechnicalAccountant.rawValue {
            ThemeManager.applyTheme(theme: .TechnicalAccountant)
        }
    }
    
    @IBAction func recoverPasswordAction(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginUser(){
        let loginService = LoginService()
        var loginReq = LoginReq()
        loginReq.userName = self.userName.text!
        loginReq.UserPwd = self.password.text!
        loginService.login(credentials: loginReq) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
//                    let loginData: [LoginResponse] =  (data as? [LoginResponse])!
                    guard let loginData = data as? [LoginResponse] else{
                        return
                    }
                    let sessionManager = SessionManager.shared
                    sessionManager.loginResponseData = loginData[0]
                    var loginReq = LoginReq()
                    loginReq.userName = self.userName.text!
                    loginReq.UserPwd = self.password.text!
                    sessionManager.loginReq = loginReq
                    self.saveThemeFor(user: (sessionManager.loginResponseData?.userRole)!)
                    //                    self.performSegue(withIdentifier: SegueIdentifier.kMoveToDashBoard, sender: self)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.showDashboard()
                    print("login sucess")
                }
                else {
                    self.showAlertWithAction(title: "", message: error?.localizedDescription, actionTitles: ["OK"], actions: [{action1 in
                        self.userName.becomeFirstResponder()
                        }])
                }
            }
        }
    }
    
    func mypolicy(){
        let mycaseService = MyPolicyService()
        var loginReq = LoginReq()
        loginReq.userName = self.userName.text!
        loginReq.UserPwd = self.password.text!
        mycaseService.getPolicy(credentials: loginReq) { (data, error) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if error == nil {
                    guard let mypolicyJsonData = data as? MyPolicyResponse else{
                        return
                    }
//                    let mypolicyJsonData: MyPolicyResponse =  (data as? MyPolicyResponse)!
                    let mypolicyArray = mypolicyJsonData.myPolicyList
                    print(mypolicyArray?.count ?? 0)
                    
                }
                else {
                    self.showSimpleAlert(title: "", message: (error?.localizedDescription)!, actionTitle: "OK")
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    // MARK:- UITextField Delegate
    /// Asks the delegate if editing should begin in the specified text field.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    /// Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName {
            password.becomeFirstResponder()
            return false
        }
        else {
            password.resignFirstResponder()
            self.loginAction(nil)
            return true
            
        }
    }
}
