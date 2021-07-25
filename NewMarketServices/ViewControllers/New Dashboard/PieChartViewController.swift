//
//  PieChartViewController.swift
//  NewMarketServices
//
//  Created by admin on 18/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPieChartData()
    }
    
    func setPieChartData() {
        pieChart.usePercentValuesEnabled = false //true //Display percentage for input value
        pieChart.drawSlicesUnderHoleEnabled = false
        pieChart.holeRadiusPercent = 0.65
        pieChart.chartDescription?.enabled = false//true
        pieChart.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        pieChart.drawCenterTextEnabled = true
        pieChart.holeColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1) //Center circle color
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "75")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Medium", size: 70)!,
                                  .paragraphStyle : paragraphStyle, .foregroundColor: NSUIColor.white, ], range: NSRange(location: 0, length: centerText.length))
        
        /*centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 60)!,
         .paragraphStyle : paragraphStyle, .foregroundColor: NSUIColor.white, .backgroundColor: NSUIColor.darkGray], range: NSRange(location: 0, length: centerText.length))*/
        
        
        pieChart.centerAttributedText = centerText;
        
        pieChart.drawHoleEnabled = true //Center circle
        
        pieChart.rotationAngle = 0
        pieChart.rotationEnabled = false//true
        pieChart.highlightPerTapEnabled = true//false
        
        let l = pieChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside =  false
        l.xEntrySpace = 10//7
        l.yEntrySpace =  0//0
        l.yOffset = 20 //0
        l.font = UIFont(name: "HelveticaNeue-Light", size: 18)!
        l.textColor = NSUIColor.white
        //        pieChart.legend = l
        
        pieChart.legend.enabled = true
        // pieChart.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        
        self.setDataCount(Int(4), range: UInt32(75))
        pieChart.delegate = self
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        //        let entries = (0..<count).map { (i) -> PieChartDataEntry in
        //            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        //            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
        //                                     label: nil)
        //        }
        let values = [10, 19, 10, 36]
        let labels = ["Pending - Housekeeping", "Pending - Conflict of Interest", "New Claims", "Pending - Claim Settlement"]
        var entries = [PieChartDataEntry]()
        for index in 0...count-1 {
            let entry = PieChartDataEntry(value: Double(values[index]), label: labels[index])
            //let entry = PieChartDataEntry(value: Double(values[index]), label: "")
            entries.append(entry)
        }
        
        //let set = PieChartDataSet(values: entries, label: "Open Task")
        let set = PieChartDataSet(values: entries, label: nil)
        set.sliceSpace = 0 //2 //space between sectors
        
        
        //        set.colors = ChartColorTemplates.vordiplom()
        //            + ChartColorTemplates.joyful()
        //            + ChartColorTemplates.colorful()
        //            + ChartColorTemplates.liberty()
        //            + ChartColorTemplates.pastel()
        //            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        set.colors = [UIColor(red: 161/255, green: 161/255, blue: 162/255, alpha: 1)] + [UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)]  + [UIColor(red: 0/255, green: 83/255, blue: 172/255, alpha: 1)] + [UIColor(red: 255/255, green: 249/255, blue: 190/255, alpha: 1)]
        
        set.valueLineColor = UIColor.white  //sector -  line color
        set.entryLabelColor = UIColor.white //sector - label color
        set.entryLabelFont = UIFont(name: "HelveticaNeue-Light", size: 0)! // Workaround for hiding sector label
        
        set.valueLinePart1OffsetPercentage =  1.0 //0.8
        set.valueLinePart1Length = 0.2//0.2
        set.valueLinePart2Length = 0.9//0.4
        //set.xValuePosition = .outsideSlice
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = ""//" %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 40, weight: .semibold))
        data.setValueTextColor(.white)
        
        pieChart.data = data
        pieChart.highlightValues(nil)
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

extension PieChartViewController : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}
