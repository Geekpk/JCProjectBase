//
//  UIView_Extention.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit


extension UIView {
    func x() -> CGFloat {
        return frame.origin.x
    }
    func y() -> CGFloat {
        return frame.origin.y
    }
    func w() -> CGFloat {
        return frame.size.width
    }
    func h() -> CGFloat {
        return frame.size.height
    }
    
    func drawDottedImage(_ lineW : CGFloat, _ space : CGFloat) {
        JCLog(message: frame)
        layer.removeAllSublayers()
        let shaplayer = CAShapeLayer.init()
        shaplayer.position = CGPoint.init(x: frame.width/2, y: frame.height/2)
        shaplayer.bounds = frame
        shaplayer.lineCap = CAShapeLayerLineCap.round
        shaplayer.lineWidth = h()
        shaplayer.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
        shaplayer.fillColor = UIColor.black.withAlphaComponent(0.8).cgColor
        shaplayer.lineDashPattern = [NSNumber.init(value: Float(lineW)), NSNumber.init(value: Float(space))]
        let mutPaht = CGMutablePath.init()
        mutPaht.move(to: CGPoint.init(x: frame.origin.x, y: frame.origin.y))
        mutPaht.addLine(to: CGPoint.init(x: frame.maxX, y: frame.origin.y))
        shaplayer.path = mutPaht
        layer.addSublayer(shaplayer)
    }
    
}

extension UIScreen {
    func w() -> CGFloat {
        return bounds.size.width
    }
    func h() -> CGFloat {
        return bounds.size.height
    }
}
