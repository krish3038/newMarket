//
//  FinancialOverviewPart1ViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/30/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum FinancialOverviewFieldTag: Int {
    case Section = 500
    case Premium
    case London
    case Overseas
    case Fronting
    case ThirdParty
    case Ohter
}

public struct FOItem {
    var Section: String?
    var Premium: String?
    var London: String?
    var Overseas: String?
    var Fronting: String?
    var thirdParty: String?
    var Other: String?
    
    public init(Section: String?, Premium: String?,London: String?, Overseas: String?, Fronting: String?, thirdParty: String?,Other: String?) {
        self.Section = Section
        self.Premium = Premium
        self.London = London
        self.Overseas = Overseas
        self.Fronting = Fronting
        self.thirdParty = thirdParty
        self.Other = Other
    }
}

public struct FOSection {
    var  items : [FOItem]?
    public init(items: [FOItem]?) {
        self.items = items
    }
}
public struct FOModel {
    var  foSection : [FOItem]?
    public init( foSection:[FOItem]){
        self.foSection =  foSection
    }
}

protocol FinancialOverviewPart1Delegate: NSObjectProtocol {
    func textFieldFocused(textField : UITextField)
}

class FinancialOverviewPart1ViewController: BaseViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    weak var delegate: FinancialOverviewPart3Delegate?
    var cellSize : CGSize? = nil
    
  let fomodel = FOModel.init(foSection: [FOItem.init(Section: "1", Premium: "135000", London: "12150", Overseas: "14850", Fronting: "N/A", thirdParty: "N/A", Other: "N/A")])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureCollectionView()
    }
    func configureCollectionView() {
        //_ = baseView.frame
        cellSize = CGSize(width:(mainCollectionView.bounds.width/7) , height:50)
        print("Cell cellSize---->\(String(describing: cellSize))")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize!
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        mainCollectionView.register(UINib(nibName: "EditableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditableCollectionViewCell")
        let cell65Percentage = ((mainCollectionView.bounds.width*65/100)/4)
        let cell45Percentage = ((mainCollectionView.bounds.width*35/100)/3)
        print("collectionView Width -->\(mainCollectionView.bounds.width)")
        print("cell65Percentage -->\(cell65Percentage)")
        print("cell45Percentage -->\(cell45Percentage)")
        mainCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FinancialOverviewPart1ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 1
        return (fomodel.foSection?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableCollectionViewCell", for: indexPath) as! EditableCollectionViewCell
        cell.editableTextField.delegate = self
        cell.indexPath = indexPath
        setTextFieldTagsForCell(indexPath: indexPath, cell: cell)
        enableEditingForTextFields(indexPath: indexPath, cell: cell)
        changeTextColor(indexPath: indexPath, cell: cell)
        
        let foItem : FOItem = fomodel.foSection![indexPath.section]
        populateDataForCell(item: foItem, indexPath: indexPath, cell: cell)
       return cell
    }
    
    func enableEditingForTextFields(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        if cell.editableTextField.tag == FinancialOverviewFieldTag.Section.rawValue {
            cell.editableTextField.isEnabled = false
        }
        else {
            if ThemeManager.currentTheme() == .Broker {
                cell.editableTextField.isEnabled = true
            }
            else {
                cell.editableTextField.isEnabled = false
            }
        }
    }
    
    func changeTextColor(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        let color = UIColor(red: 85/255, green: 85/255, blue: 84/255, alpha: 1.0)
        if ThemeManager.currentTheme() == .Broker {
            cell.editableTextField.textColor = ThemeManager.currentTheme().backgroundColor
            if cell.editableTextField.tag == FinancialOverviewFieldTag.Section.rawValue {
                cell.editableTextField.textColor = color
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
            tagValue = FinancialOverviewFieldTag.Section.rawValue
        case 1:
            tagValue = FinancialOverviewFieldTag.Premium.rawValue
        case 2:
            tagValue = FinancialOverviewFieldTag.London.rawValue
        case 3:
            tagValue = FinancialOverviewFieldTag.Overseas.rawValue
        case 4:
            tagValue = FinancialOverviewFieldTag.Fronting.rawValue
        case 5:
            tagValue = FinancialOverviewFieldTag.ThirdParty.rawValue
        case 6:
            tagValue = FinancialOverviewFieldTag.Ohter.rawValue
        default:
            print("")
        }
        cell.editableTextField.tag = tagValue
    }
    
    func populateDataForCell(item: FOItem, indexPath: IndexPath, cell: EditableCollectionViewCell) {
        var value = ""
        switch indexPath.row {
        case 0:
            value = item.Section!
        case 1:
            value = item.Premium!
        case 2:
            value = item.London!
        case 3:
            value = item.Overseas!
        case 4:
            value = item.Fronting!
        case 5:
            value = item.thirdParty!
        case 6:
            value = item.Other!
        default:
            print("")
        }
        cell.editableTextField.text = value
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
        
        let cell65Percentage = ((mainCollectionView.bounds.width*68/100)/4)-0.1
        let cell45Percentage = ((mainCollectionView.bounds.width*32/100)/3)-0.1
        switch indexPath.row {
        case 0:
            cellSize = CGSize(width:cell65Percentage , height:50) as CGSize
        case 1:
            cellSize = CGSize(width:cell65Percentage , height:50) as CGSize
        case 2:
            cellSize = CGSize(width:cell65Percentage , height:50) as CGSize
        case 3:
            cellSize = CGSize(width:cell65Percentage , height:50) as CGSize
        case 4:
            cellSize = CGSize(width:cell45Percentage , height:50) as CGSize
        case 5:
            cellSize = CGSize(width:cell45Percentage , height:50) as CGSize
        case 6:
            cellSize = CGSize(width:cell45Percentage , height:50) as CGSize
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

extension FinancialOverviewPart1ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldFocused(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField)
        
        let selectedCell: EditableCollectionViewCell = textField.superview?.superview as! EditableCollectionViewCell
        let index = selectedCell.indexPath
        var foItem : FOItem = fomodel.foSection![index!.section]

        switch textField.tag {
        case FinancialOverviewFieldTag.Section.rawValue:
            foItem.Section = textField.text
        case FinancialOverviewFieldTag.Premium.rawValue:
            foItem.Premium = textField.text
        case FinancialOverviewFieldTag.London.rawValue:
            foItem.London = textField.text
        case FinancialOverviewFieldTag.Overseas.rawValue:
            foItem.Overseas = textField.text
        case FinancialOverviewFieldTag.Fronting.rawValue:
            foItem.Fronting = textField.text
        case FinancialOverviewFieldTag.ThirdParty.rawValue:
            foItem.thirdParty = textField.text
        case FinancialOverviewFieldTag.Ohter.rawValue:
            foItem.Other = textField.text
        default:
            print("")
        }
    }
}
