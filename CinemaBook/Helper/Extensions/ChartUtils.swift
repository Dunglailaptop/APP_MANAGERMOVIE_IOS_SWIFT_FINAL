//
//  ChartUtils.swift
//  Techres - TMS
//
//  Created by Thanh Phong on 05/08/2021.
//  Copyright © 2021 ALOAPP. All rights reserved.
//

import UIKit
import Charts

class ChartUtils: NSObject {
    static func customLineChart(chartView : LineChartView, entries: [ChartDataEntry]) {
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.axisMaximum = Double(entries.count)
       
        chartView.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 7), size: 7)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        let customFormatter = CustomChartView()
        chartView.leftAxis.valueFormatter = customFormatter as! AxisValueFormatter
    }
    
    static func customPieChart(chartView : PieChartView, total: Int) {
        chartView.entryLabelColor = .black
        chartView.transparentCircleRadiusPercent = CGFloat(0.1)
        chartView.drawHoleEnabled = false
        //gone chú thích
        chartView.legend.enabled = false
        chartView.legend.horizontalAlignment = .center
        //gone text center
        chartView.drawCenterTextEnabled = false
        chartView.drawHoleEnabled = false
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 12.0)! ]
        let myAttrString = NSAttributedString(string: Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(Float(total))), attributes: myAttribute)
        chartView.centerAttributedText = myAttrString
        chartView.clearsContextBeforeDrawing = true
        chartView.animate(yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInOutBack)
        chartView.entryLabelFont = UIFont.init(name: "HelveticaNeue", size: 4)
    }
    
    static func customBarChart(chartView : BarChartView) {
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 8), size: 8)
        chartView.xAxis.labelRotatedHeight = CGFloat(50.0)
        chartView.xAxis.labelRotationAngle = -75.0
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        let customFormatter = CustomChartView()
        chartView.leftAxis.valueFormatter = customFormatter as! AxisValueFormatter
    }
    
    static func customBarChart2(chartView : BarChartView,barChartItems:[BarChartDataEntry],xLabel:[String]=[],color:[UIColor]?=nil,drawValuesOnDataSet:Bool=false) {
        chartView.noDataText = "Chưa có dữ liệu !!"
        //Bar Chart
        let barChartDataSet = BarChartDataSet(entries: barChartItems, label: "")
        barChartDataSet.valueColors = [ColorUtils.green_600(),ColorUtils.red_400(),ColorUtils.orange_brand_900()]
        barChartDataSet.valueFont = UIFont.systemFont(ofSize: 9, weight: .semibold)
        barChartDataSet.valueFormatter = CustomValueFormater()
        color != nil ? barChartDataSet.setColors(color!,alpha: 1) : barChartDataSet.setColors(ColorUtils.blue_brand_700())
        
    
        barChartDataSet.drawValuesEnabled = drawValuesOnDataSet
        barChartDataSet.drawIconsEnabled = false
        chartView.data = BarChartData(dataSet: barChartDataSet)
        

        
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.axisLineWidth = 1
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.valueFormatter = CustomAxisValueFormatter()
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 10)
        chartView.xAxis.drawAxisLineEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisLineWidth = 1
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.axisMaximum = Double(barChartItems.count)
        chartView.xAxis.labelRotationAngle = -27
        chartView.xAxis.labelRotatedHeight = 35
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xLabel)
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        
        
        let visibleXRange = 8 // Number of values to show in y-Axis
        chartView.setVisibleXRangeMaximum(Double(visibleXRange))
        chartView.xAxis.setLabelCount(visibleXRange, force: false)
        chartView.xAxis.granularity = 1
        chartView.xAxis.labelCount = visibleXRange
        chartView.dragEnabled = true
     
        
        // MARK: Handle click show tooltip
        // Set the extraTopOffset property to add padding
        chartView.extraTopOffset = 30.0 // Adjust the value as per your requirement
        chartView.marker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))

    }
    
    ////variable  dataPointnth is used to get label for the report type of week
    static func getXLabel(dateTime:String, reportType:Int, dataPointnth:Int) -> String {
        var x_label = ""
        let datetimeSeparator = dateTime.components(separatedBy: [" "])
            
            dLog(dateTime)
            switch(reportType){
                case REPORT_TYPE_TODAY:
                let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                x_label = String(format: "%@:00", substringTime.first ?? "")
         
                case REPORT_TYPE_YESTERDAY:
                let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                x_label = String(format: "%@:00", substringTime.first ?? "")
                
                case REPORT_TYPE_THIS_WEEK:
                    switch dataPointnth {
                        case 0:
                            x_label = "Thứ 2"
                            break
                        case 1:
                            x_label = "Thứ 3"
                            break
                        case 2:
                            x_label = "Thứ 4"
                            break
                        case 3:
                            x_label = "Thứ 5"
                            break
                        case 4:
                            x_label = "Thứ 6"
                            break
                        case 5:
                            x_label = "Thứ 7"
                            break
                        default:
                            x_label = "Chủ nhật"
                    }
                    break
                
                case REPORT_TYPE_LAST_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])
                    
                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THREE_MONTHS:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[2],substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_LAST_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_THREE_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_ALL_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label.append(String(format: "%@",substringDate[0]))
                    break
                
                default:
                    break
            }
        
        return x_label
        
    }
    
    static func setLabelCountForChart(reportType:Int,totalDataPoint:Int) -> Int{
        
        switch reportType {
            case REPORT_TYPE_TODAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_YESTERDAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_THIS_WEEK:
                return totalDataPoint
            
            case REPORT_TYPE_THIS_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_LAST_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_THREE_MONTHS:
                return (totalDataPoint)/11
            
            case REPORT_TYPE_THIS_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_LAST_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_THREE_YEAR:
                return (totalDataPoint)/5
            
            case REPORT_TYPE_ALL_YEAR:
                return (totalDataPoint)
            
            default:
                return totalDataPoint
        }

    }
}
public class CustomAxisValueFormatter: NSObject, AxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        var yValue = value/1000
        if(yValue >= 0 && yValue < 1000 ){
            return String(format: "%@ K", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: yValue))
        }else if(yValue >= 1000 && yValue < 1000000 ){
            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: yValue/1000))
        }else if(yValue >= 1000000){
            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: yValue/1000000))
        }
        else if(value < 0 && value > -1000) {
            return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value <= -1000 && value > -1000000 ){
            return String(format: "%@ Ng", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
        }else if(value <= -1000000){
            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }else if(value <= -1000000000){
            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000000))
        }
        return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: yValue))
        
    }
}
private class CustomMarkerView: MarkerView {
    private let label: UILabel

    override init(frame: CGRect) {
        // Create a label to display the tooltip text
        label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = ColorUtils.blueTransparent008()
        label.layer.cornerRadius = 5
        label.clipsToBounds = true

        super.init(frame: frame)

        // Add the label to the marker view
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Customization of the tooltip text
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        label.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(Int(entry.y)))
       
        // Adjust the width of the tooltip based on the label's content
        label.sizeToFit()
        
        // Update the frame of the tooltip
        var frame = label.frame
        frame.size.width += 15 // Add some padding
        frame.size.height += 10 // Add some vertical padding
        label.frame = frame
    }

    // Customization of the tooltip position
    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        var offset = CGPoint(x: -bounds.size.width / 5 + 5, y: bounds.size.height)
                
        let chartHeight = super.chartView?.bounds.height ?? 0
            let minY = bounds.size.height
            let maxY = chartHeight - bounds.size.height
            
            if offset.y < minY {
                offset.y = minY
            } else if offset.y > maxY {
                offset.y = maxY
            }
            
            return offset
    }
}
private class CustomValueFormater:ValueFormatter{
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return Utils.stringVietnameseMoneyFormatWithNumberDouble(amount:value)
    }

}
