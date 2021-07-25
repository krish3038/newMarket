//
//  CommentsViewController.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class CommentsViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var commentHistoryTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var btnCorporate: UIButton!
    @IBOutlet weak var btnIndividual: UIButton!
    @IBOutlet weak var individualBtnHeight: NSLayoutConstraint!
    
    var arrCommentList:[String] = ["Lorem ipsum dolor sit amet, consectetur adip, Lorem ipsum dolor sit amet, consectetur adip, Lorem ipsum dolor sit amet, consectetur adip, Lorem ipsum dolor sit amet, consectetur adip, Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip","Lorem ipsum dolor sit amet, consectetur adip"]
    
    var arrSelectedList:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        
        commentHistoryTableView.estimatedRowHeight = 200
        commentHistoryTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        btnIndividual.backgroundColor = UIColor.black
        //        btnIndividual.titleLabel?.textColor = UIColor.white
        //        btnCorporate.backgroundColor = UIColor.white
        //        btnCorporate.titleLabel?.textColor = UIColor.black
    }
    
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    @IBAction func returnToClaimAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmConflictOfInterestBtnAction(_ sender: UIButton) {
        self.popToDashboardViewController()
    }
    
    @IBAction func logoBtnAction(_ sender: UIButton) {
        self.popToDashboardViewController()
    }
    @IBAction func btnCorporateTapped(_ sender: Any) {
        btnCorporate.backgroundColor = UIColor.black
        btnCorporate.titleLabel?.textColor = UIColor.white
        
        btnIndividual.backgroundColor = UIColor.white
        btnIndividual.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func btnIndividualTapped(_ sender: Any) {
        btnIndividual.backgroundColor = UIColor.black
        btnIndividual.titleLabel?.textColor = UIColor.white
        
        btnCorporate.backgroundColor = UIColor.white
        btnCorporate.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func btnAuditTapped(_ sender: Any) {
        if(individualBtnHeight.constant == 0){
            individualBtnHeight.constant = 75
            btnIndividual.isHidden = false
            btnCorporate.isHidden = false
        }
        else{
            individualBtnHeight.constant = 0
            btnIndividual.isHidden = true
            btnCorporate.isHidden = true
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if(textView.text == "Add comment"){
            commentTextView.text = ""
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text.count == 0){
            textView.text = "Add comment"
        }
    }
    
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCommentList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let claimTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentListTableViewCell", for: indexPath) as! CommentListTableViewCell
        
        claimTableViewCell.commentLabel.text = arrCommentList[indexPath.row]
        claimTableViewCell.accessoryType = UITableViewCellAccessoryType.none
        
        claimTableViewCell.selectionStyle = .none
        
        guard arrSelectedList.count > 0 else {
            // claimTableViewCell.commentView.backgroundColor = UIColor(red: 106/255, green: 156/255, blue: 231/255, alpha: 1)
            claimTableViewCell.commentView.backgroundColor = UIColor(red: 41/255, green: 47/255, blue: 81/255, alpha: 1)
            return claimTableViewCell
        }
        
        if(arrSelectedList.contains(indexPath.row))
        {
            //claimTableViewCell.commentView.backgroundColor = UIColor(red: 42/255, green: 79/255, blue: 124/255, alpha: 1)
            claimTableViewCell.commentView.backgroundColor = UIColor(red: 38/255, green: 77/255, blue: 176/255, alpha: 1)
        }
        else
        {
            claimTableViewCell.commentView.backgroundColor = UIColor(red: 41/255, green: 47/255, blue: 81/255, alpha: 1)
        }
        return claimTableViewCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard arrSelectedList.count > 0 else {
            arrSelectedList.append(indexPath.row)
            commentHistoryTableView.reloadData()
            return
        }
        
        if(arrSelectedList.contains(indexPath.row)){
            
            if let itemToRemoveIndex = arrSelectedList.index(of: indexPath.row) {
                arrSelectedList.remove(at: itemToRemoveIndex)
            }
        }
        else {
            
            arrSelectedList.append(indexPath.row)
        }
        commentHistoryTableView.reloadData()
    }
    
}
