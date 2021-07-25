//
//  FinancialOverviewPart2ViewController.swift
//  NewMarketServices
//
//  Created by admin on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum FinancialOverviewPart2FieldTag: Int {
    case Order = 200
    case Brokerage
    case Premium
}

protocol FinancialOverviewPart2Delegate: NSObjectProtocol {
    func textFieldFocused(textField : UITextField)
}

class FinancialOverviewPart2ViewController: BaseViewController {

    @IBOutlet weak var orderTextField: UITextField!
    @IBOutlet weak var brokerageTextField: UITextField!
    @IBOutlet weak var premiumTextField: UITextField!
    
    weak var delegate: FinancialOverviewPart2Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTextFieldTags()
        enableEditingForTextFields()
        changeTextColor()
    }
    
    func setTextFieldTags() {
        orderTextField.tag = FinancialOverviewPart2FieldTag.Order.rawValue
        brokerageTextField.tag = FinancialOverviewPart2FieldTag.Brokerage.rawValue
        premiumTextField.tag = FinancialOverviewPart2FieldTag.Premium.rawValue
    }
    
    func enableEditingForTextFields() {
        if ThemeManager.currentTheme() == .Broker {
            orderTextField.isEnabled = true
            brokerageTextField.isEnabled = true
            premiumTextField.isEnabled = true
        }
        else {
            orderTextField.isEnabled = false
            brokerageTextField.isEnabled = false
            premiumTextField.isEnabled = false
        }
    }
    
    func changeTextColor() {
        if ThemeManager.currentTheme() == .Broker {
            orderTextField.textColor = ThemeManager.currentTheme().backgroundColor
            brokerageTextField.textColor = ThemeManager.currentTheme().backgroundColor
            premiumTextField.textColor = ThemeManager.currentTheme().backgroundColor
        }
        else {
            let color = UIColor(red: 85/255, green: 85/255, blue: 84/255, alpha: 1.0)
            orderTextField.textColor = color
            brokerageTextField.textColor = color
            premiumTextField.textColor = color
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension FinancialOverviewPart2ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldFocused(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == FinancialOverviewPart2FieldTag.Order.rawValue {
            //TODO: update model
        }
        else if textField.tag == FinancialOverviewPart2FieldTag.Brokerage.rawValue {
            //TODO: update model
        }
        else if textField.tag == FinancialOverviewPart2FieldTag.Premium.rawValue {
            //TODO: update model
        }
    }
}
