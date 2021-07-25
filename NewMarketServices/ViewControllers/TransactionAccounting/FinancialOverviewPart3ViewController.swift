//
//  FinancialOverviewPart3ViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/31/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum FinancialOverviewPart3FieldTag: Int {
    case Lead = 400
    case Market
    case Written
    case Signed
    case Premium
}

protocol FinancialOverviewPart3Delegate: NSObjectProtocol {
    func textFieldFocused(textField : UITextField)
}

class FinancialOverviewPart3ViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var totalValueLabel: UILabel!
    weak var delegate: FinancialOverviewPart3Delegate?
    
    var cellSize : CGSize? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureCollectionView()
    }
    func configureCollectionView() {
        //_ = baseView.frame
        cellSize = CGSize(width:(mainCollectionView.bounds.width/5) , height:50)
        print("Cell cellSize---->\(String(describing: cellSize))")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize!
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //        print("UIScreen.main.bounds---->\(UIScreen.main.bounds)")
        //        //print("mainCollectionView.frame---->\(mainCollectionView.frame)")
        //        //print("mainCollectionView.bounds---->\(mainCollectionView.bounds)")
        //        //print("UIScreen.main.bounds---->\(UIScreen.main.bounds)")
        
        mainCollectionView.register(UINib(nibName: "EditableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditableCollectionViewCell")
        let cell15Percentage = ((mainCollectionView.bounds.width*15/100))-0.1
        let cell25Percentage = ((mainCollectionView.bounds.width*25/100))-0.1
        let cell30Percentage = ((mainCollectionView.bounds.width*60/100)/3)-0.1
        print("collectionView Width -->\(mainCollectionView.bounds.width)")
        print("cell15Percentage -->\(cell15Percentage)")
        print("cell25Percentage -->\(cell25Percentage)")
        print("cell30Percentage -->\(cell30Percentage)")

        mainCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FinancialOverviewPart3ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 1
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableCollectionViewCell", for: indexPath) as! EditableCollectionViewCell
        cell.editableTextField.delegate = self
        cell.indexPath = indexPath
        setTextFieldTagsForCell(indexPath: indexPath, cell: cell)
        enableEditingForTextFields(indexPath: indexPath, cell: cell)
        changeTextColor(indexPath: indexPath, cell: cell)
        
        switch indexPath.row {
        case 0:
            cell.editableTextField.text = "L/F"
            cell.editableTextField.textAlignment = .center
        case 1:
            cell.editableTextField.text = "Fortitude (FRT 2100)"
        case 2:
            cell.editableTextField.text = "20.00%"
        case 3:
            cell.editableTextField.text = "9.00%"
        case 4:
            cell.editableTextField.text = "27,000"
        default:
            cell.editableTextField.text = ""
        }
        return cell
    }
    
    func enableEditingForTextFields(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        if (cell.editableTextField.tag == FinancialOverviewPart3FieldTag.Written.rawValue) || (cell.editableTextField.tag == FinancialOverviewPart3FieldTag.Signed.rawValue) {
            if ThemeManager.currentTheme() == .Broker {
                cell.editableTextField.isEnabled = true
            }
            else {
                cell.editableTextField.isEnabled = false
            }
        }
        else {
            cell.editableTextField.isEnabled = false
        }
    }
    
    func changeTextColor(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        let color = UIColor(red: 85/255, green: 85/255, blue: 84/255, alpha: 1.0)
        if ThemeManager.currentTheme() == .Broker {
            cell.editableTextField.textColor = color
            if (cell.editableTextField.tag == FinancialOverviewPart3FieldTag.Written.rawValue) || (cell.editableTextField.tag == FinancialOverviewPart3FieldTag.Signed.rawValue) {
                cell.editableTextField.textColor = ThemeManager.currentTheme().backgroundColor
            }
        }
        else {
            cell.editableTextField.textColor = color
        }
    }
    
    func setTextFieldTagsForCell(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        var tagValue = 0
        switch indexPath.row {
        case 0:
            tagValue = FinancialOverviewPart3FieldTag.Lead.rawValue
        case 1:
            tagValue = FinancialOverviewPart3FieldTag.Market.rawValue
        case 2:
            tagValue = FinancialOverviewPart3FieldTag.Written.rawValue
        case 3:
            tagValue = FinancialOverviewPart3FieldTag.Signed.rawValue
        case 4:
            tagValue = FinancialOverviewPart3FieldTag.Premium.rawValue
        default:
            print("")
        }
        cell.editableTextField.tag = tagValue
    }

    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell10Percentage = ((mainCollectionView.bounds.width*10/100))-0.1
        let cell35Percentage = ((mainCollectionView.bounds.width*35/100))-0.1
        let cell55Percentage = ((mainCollectionView.bounds.width*55/100)/3)-0.1
        
        switch indexPath.row {
        case 0:
            cellSize = CGSize(width:cell10Percentage , height:50) as CGSize
        case 1:
            cellSize = CGSize(width:cell35Percentage , height:50) as CGSize
        case 2:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 3:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 4:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        default: break
            // cellSize = CGSize(width:(baseView.bounds.width) , height:50) as CGSize
        }
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt --->\(indexPath.section)--->\(indexPath.row)")
    }
}

extension FinancialOverviewPart3ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldFocused(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField)
        
        let selectedCell: EditableCollectionViewCell = textField.superview?.superview as! EditableCollectionViewCell
        let index = selectedCell.indexPath?.section
        //TODO: Get the model using this above index
        //TODO: Update the model from the textfield value
    }
}
