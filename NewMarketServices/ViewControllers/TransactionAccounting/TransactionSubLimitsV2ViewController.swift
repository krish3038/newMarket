//
// TransactionSubLimitsPart2ViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 8/2/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum TransactionSubLimitsFieldTag: Int {
    case Address = 600
    case Postcode
    case BuildingValue
    case ContentStockMachinery
    case PDTotal
    case BI
    case TotalValue
    case Section
    case Premium
    case CountryTax
    case TaxTotal
}

public struct SubLimitsItem {
    var Address: String?
    var Postcode: String?
    var BuildingValue: String?
    var ContentStockMachinery: String?
    var PDTotal: String?
    var BI: String?
    var TotalValue: String?
    var Section: String?
    var Premium: String?
    var CountryTax: String?
    var TaxTotal: String?
    
    public init(Address: String?, Postcode: String?,BuildingValue: String?, ContentStockMachinery: String?, PDTotal: String?, BI: String?,TotalValue: String?, Section:String?, Premium: String?, CountryTax: String?, TaxTotal: String?) {
        self.Address = Address
        self.Postcode = Postcode
        self.BuildingValue = BuildingValue
        self.ContentStockMachinery = ContentStockMachinery
        self.PDTotal = PDTotal
        self.BI = BI
        self.TotalValue = TotalValue
        self.Section = Section
        self.Premium = Premium
        self.CountryTax = CountryTax
        self.TaxTotal = TaxTotal
        
    }
}

public struct SubLimitsSection {
    var  items : [SubLimitsItem]?
    public init(items: [SubLimitsItem]?) {
        self.items = items
    }
}
public struct SubLimitsModel {
    var  SubLimits : [SubLimitsItem]?
    public init( SubLimits:[SubLimitsItem]){
        self.SubLimits =  SubLimits
    }
}

protocol TransactionSubLimitsPart2Delegate: NSObjectProtocol {
    func textFieldFocused(textField : UITextField)
}

class TransactionSubLimitsPart2ViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var cellSize : CGSize? = nil
    
    weak var delegate: TransactionSubLimitsPart2Delegate?

    
    let subLimitsModel = SubLimitsModel.init(SubLimits: [SubLimitsItem.init(Address: "42 Giulford RD", Postcode: "EX31 9QR", BuildingValue: "$ 122,094,000.00", ContentStockMachinery: "$ 120,000.00", PDTotal: "$ 123,215,000.00", BI: "$ 1,200,000.00", TotalValue: "$ 123,415,000", Section: "1", Premium: "31,1236", CountryTax: "12%", TaxTotal: "3,748")])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

}


extension TransactionSubLimitsPart2ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 1
        return (subLimitsModel.SubLimits?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableCollectionViewCell", for: indexPath) as! EditableCollectionViewCell
        cell.editableTextField.delegate = self
        cell.indexPath = indexPath
        setTextFieldTagsForCell(indexPath: indexPath, cell: cell)
        
        let item : SubLimitsItem = subLimitsModel.SubLimits![indexPath.section]
        populateDataForCell(item: item, indexPath: indexPath, cell: cell)
        return cell
    }
    
    func setTextFieldTagsForCell(indexPath: IndexPath, cell: EditableCollectionViewCell) {
        var tagValue = 0
        switch indexPath.row {
        case 0:
            tagValue = TransactionSubLimitsFieldTag.Address.rawValue
        case 1:
            tagValue = TransactionSubLimitsFieldTag.Postcode.rawValue
        case 2:
            tagValue = TransactionSubLimitsFieldTag.BuildingValue.rawValue
        case 3:
            tagValue = TransactionSubLimitsFieldTag.ContentStockMachinery.rawValue
        case 4:
            tagValue = TransactionSubLimitsFieldTag.PDTotal.rawValue
        case 5:
            tagValue = TransactionSubLimitsFieldTag.BI.rawValue
        case 6:
            tagValue = TransactionSubLimitsFieldTag.TotalValue.rawValue
        case 7:
            tagValue = TransactionSubLimitsFieldTag.Section.rawValue
        case 8:
            tagValue = TransactionSubLimitsFieldTag.Premium.rawValue
        case 9:
            tagValue = TransactionSubLimitsFieldTag.CountryTax.rawValue
        case 10:
            tagValue = TransactionSubLimitsFieldTag.TaxTotal.rawValue
        default:
            print("")
        }
        cell.editableTextField.tag = tagValue
    }
    

    
    func populateDataForCell(item: SubLimitsItem, indexPath: IndexPath, cell: EditableCollectionViewCell) {
        var value = ""
        switch indexPath.row {
        case 0:
            value = item.Address!
        case 1:
            value = item.Postcode!
        case 2:
            value = item.BuildingValue!
        case 3:
            value = item.ContentStockMachinery!
        case 4:
            value = item.PDTotal!
        case 5:
            value = item.BI!
        case 6:
            value = item.TotalValue!
        case 7:
            value = item.Section!
        case 8:
            value = item.Premium!
        case 9:
            value = item.CountryTax!
        case 10:
            value = item.TaxTotal!
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
        //97  60
        let AddressCellSize = ((mainCollectionView.bounds.width*15/100) * 0.60)-0.1
        let PostalCodeCellSize = ((mainCollectionView.bounds.width*15/100)*0.40)-0.1

        let cell55Percentage = ((mainCollectionView.bounds.width*55/100)/5)-0.1
        let cell30Percentage = ((mainCollectionView.bounds.width*30/100)/4)-0.1

        switch indexPath.row {
        case 0:
            cellSize = CGSize(width:AddressCellSize , height:50) as CGSize
        case 1:
            cellSize = CGSize(width:PostalCodeCellSize , height:50) as CGSize
        case 2:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 3:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 4:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 5:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 6:
            cellSize = CGSize(width:cell55Percentage , height:50) as CGSize
        case 7:
            cellSize = CGSize(width:cell30Percentage , height:50) as CGSize
        case 8:
            cellSize = CGSize(width:cell30Percentage , height:50) as CGSize
        case 9:
            cellSize = CGSize(width:cell30Percentage , height:50) as CGSize
        case 10:
            cellSize = CGSize(width:cell30Percentage , height:50) as CGSize
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


extension TransactionSubLimitsPart2ViewController: UITextFieldDelegate {
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
