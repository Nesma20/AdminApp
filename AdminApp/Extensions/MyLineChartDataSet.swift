//
//  LineChartDataSet.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/8/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Charts

class MyLineChartDataSet: LineChartDataSet {
    
    override init(values: [ChartDataEntry]?, label: String?) {
        super.init(values: values, label: label)
        
        self.colors = [UIColor.primaryEt3am()]
        self.drawCirclesEnabled = false
        self.mode = .cubicBezier
        self.cubicIntensity = 0.2
        self.drawFilledEnabled = true
    }
    
    required init() {
        super.init()
    }
    
}
