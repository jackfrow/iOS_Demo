//
//  ZZWaveView.swift
//  ZZWave
//
//  Created by jackfrow on 2019/7/5.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

class ZZWaveView: UIView {

    
    /// 偏移量
    private var offset: CGFloat = 0.0
    /// 波浪速度
    private var speed: CGFloat = 2.0
    
    private lazy var timer: WeakTimer = {
        let timer = WeakTimer(target: self, sel: #selector(animtionTime))
    timer.timer = CADisplayLink(target: timer, selector: #selector(animtionTime))
        return timer
    }()
    
    /// 显示的文字
    var text: String = "RD" {
        didSet {
        bottomTextLabel = createTextLabel()
        topTextLabel = createTextLabel()
        }
    }
    
    /// 颜色
    var color: UIColor = UIColor.red {
        didSet {
            waveLayer.fillColor = color.cgColor
            topTextLayer.fillColor = color.cgColor
        }
    }
    
    
    private lazy var waveLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.fillColor = color.cgColor
        return layer
    }()
    
    private var bottomTextLabel: UILabel! {
        didSet {
            bottomTextLayer.mask = bottomTextLabel.layer
        }
    }
    
    private lazy var bottomTextLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    
    private var topTextLabel: UILabel! {
        didSet {
            topTextLayer.mask = topTextLabel.layer
        }
    }
    private lazy var topTextLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.fillColor = color.cgColor
        return layer
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    private func customUI(){
        bottomTextLabel = createTextLabel()
        topTextLabel = createTextLabel()
        layer.addSublayer(waveLayer)
        layer.addSublayer(bottomTextLayer)
        layer.addSublayer(topTextLayer)
        
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        timer.timer?.add(to: RunLoop.main, forMode: .common)
    }
    
    @objc private func animtionTime() {
        
        let waveHeight: CGFloat = 12.0
        
        offset = offset + speed;
        
        let path = CGMutablePath()
        let turnPath = CGMutablePath() // 反向path
        
        let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * CGFloat(Double.pi) * 2 / bounds.width)))
        path.move(to: CGPoint(x: 0, y: startOffsetY))
        
        turnPath.move(to: CGPoint(x: 0, y: startOffsetY))
        
        var orignOffsetY: CGFloat = 0
        for x in 0...Int(bounds.width) {
            let currOffset = sinf(Float(2 * CGFloat(Double.pi) / bounds.width * CGFloat(x) + offset * CGFloat(Double.pi) * 2 / bounds.width))
            orignOffsetY = waveHeight * CGFloat(currOffset) + bounds.height / 2.0
            
            path.addLine(to: CGPoint(x: CGFloat(x), y: orignOffsetY))
            turnPath.addLine(to: CGPoint(x: CGFloat(x), y: orignOffsetY))
        }
        // 闭合path
        path.addLine(to: CGPoint(x: bounds.width, y: orignOffsetY))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: startOffsetY))
        path.closeSubpath()
        
        // 闭合turnPatn
        turnPath.addLine(to: CGPoint(x: bounds.width, y: orignOffsetY))
        turnPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        turnPath.addLine(to: CGPoint(x: 0, y: 0))
        turnPath.addLine(to: CGPoint(x: 0, y: startOffsetY))
        turnPath.closeSubpath()
        
        bottomTextLayer.path = path
        waveLayer.path = path
        topTextLayer.path = turnPath
    }
    
    //创建label
    private func createTextLabel() -> UILabel {
        let label = UILabel(frame: bounds)
        label.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        label.text = text
        return label
    }
    
}


class WeakTimer: NSObject {
    
    weak var target: NSObjectProtocol?
    var sel: Selector?
    var timer: CADisplayLink?
    
    init(target: NSObjectProtocol?, sel: Selector?) {
        self.target = target
        self.sel = sel
        super.init()
        // 加强安全保护
        guard target?.responds(to: sel) == true else {
            return
        }
        
        // 将target的selector替换为redirectionMethod，该方法会重新处理事件
        let method = class_getInstanceMethod(classForCoder, #selector(WeakTimer.redirectionMethod))!
        
        class_replaceMethod(classForCoder, sel!, method_getImplementation(method), method_getTypeEncoding(method))
    }
    
    @objc func redirectionMethod() {
        // 如果target未被释放，则调用target方法，否则释放timer
        if self.target != nil {
            self.target!.perform(self.sel)
        } else {
            self.timer?.invalidate()
        }
    }
    
    
}
