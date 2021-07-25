//
//  LineChartViewController.swift
//  NewMarketServices
//
//  Created by admin on 18/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import SwiftChart

class LineChartViewController: UIViewController {

    @IBOutlet weak var lineChart: Chart!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureSegmentControl()
        setLineChartData()
    }
    
    func configureSegmentControl() {
        segmentControl.borderColor = UIColor.white
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .selected)
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        
    }

    func setLineChartData() {
        lineChart.delegate = self
        lineChart.labelColor = UIColor.white
        lineChart.axesColor = UIColor.white
        lineChart.xLabelsSkipLast = false
        
        lineChart.yLabels = [0, 25, 50, 75, 100]
        lineChart.xLabels = [0, 1, 2, 3, 4, 5, 6]
        let dates = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        //chart.xLabelsFormatter = { String(Int(round($1))) + "h" }
        lineChart.xLabelsFormatter = {
            (index: Int, value: Double) -> String in
            return dates[index]
        }
        
        //let series1 = ChartSeries([0, 70, 68, 95, 60, 80, 55, 40])
        let series1 = ChartSeries([0, 70, 68, 95, 60, 80, 40])
        series1.color =  UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)//ChartColors.yellowColor()
        //series1.area = true
        
        let series2 = ChartSeries([20, 60, 20, 80, 70, 95, 50])
        series2.color =  UIColor(red: 0/255, green: 83/255, blue: 172/255, alpha: 1)//ChartColors.redColor()
        //series2.area = true
        
        let series3 = ChartSeries([10, 52, 35, 20, 35, 45, 55])
        series3.color = UIColor(red: 161/255, green: 161/255, blue: 162/255, alpha: 1)//UIColor.gray//ChartColors.purpleColor()
        
        let series4 = ChartSeries([5, 30, 10, 45, 20, 55, 45])
        series4.color = UIColor(red: 255/255, green: 249/255, blue: 190/255, alpha: 1)
        
        lineChart.add([series1, series2, series3, series4])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        lineChart.setNeedsDisplay()
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

extension LineChartViewController: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        print("didTouchChart")
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex) {
                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        print("didFinishTouchingChart")
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        print("didEndTouchingChart")
    }
}
