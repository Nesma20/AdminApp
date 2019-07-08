//
//  MyLineChartView.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/8/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Charts

extension LineChartView {
    
    func setupLineChartView() {
        self.chartDescription?.text = "" // Chart Description
        
        //self.leftAxis.drawLabelsEnabled = false // Hide Left Axis Label
        self.rightAxis.drawLabelsEnabled = false // Hide Right Axis Label
        
        self.xAxis.drawLabelsEnabled = false // Hide Top Axis Label
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.labelPosition = .bottom
        
        //self.leftAxis.enabled = false // Hide Left Axis Lines
        //self.rightAxis.enabled = false // Hide Right Axis Lines
        //self.xAxis.enabled = false // Hide Right Axis Lines
        
        self.legend.enabled = false //Hide Legend of Chart
        
        
    }
    
}
