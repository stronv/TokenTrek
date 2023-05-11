//
//  CustomMarkerView.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 04.05.2023.
//

import Foundation
import Charts

class CustomMarkerView: MarkerView { 
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(2)
        let radius: CGFloat = 8
        
        let rectangle = CGRect(
            x: point.x - radius,
            y: point.y - radius,
            width: radius * 2,
            height: radius * 2
        )
        context.addEllipse(in: rectangle)
        context.drawPath(using: .fillStroke)
    }
}
