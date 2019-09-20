//
//  CATextLayerViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/18.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class CATextLayerViewController: UIViewController {
    
    @IBOutlet weak var viewForLayer: UIView!

    @IBOutlet weak var fontSizeSliderValueLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var wrapTextSwitch: UISwitch!
    @IBOutlet weak var alignmentModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var truncationModeSegmentedControl: UISegmentedControl!
    
    enum Font: Int {
       case helvetica, noteworthyLight
     }
    enum AlignmentMode: Int {
      case left, center, justified, right
    }
    enum TruncationMode: Int {
      case start, middle, end
    }
    
    var noteworthyLightFont: AnyObject?
    var helveticaFont: AnyObject?
    let baseFontSize: CGFloat = 24.0
    let textLayer = CATextLayer()
    var fontSize: CGFloat = 24.0
    var previouslySelectedTruncationMode = TruncationMode.end
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createFonts()
        setUpTextLayer()
        viewForLayer.layer.addSublayer(textLayer)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textLayer.frame = viewForLayer.bounds
        textLayer.fontSize = fontSize
    }
    
    
    // MARK: - Quick reference
    func createFonts() {
      var fontName: CFString = "Noteworthy-Light" as CFString
      noteworthyLightFont = CTFontCreateWithName(fontName, baseFontSize, nil)
      fontName = "Helvetica" as CFString
      helveticaFont = CTFontCreateWithName(fontName, baseFontSize, nil)
    }
    
    func setUpTextLayer()  {
        
        textLayer.frame = viewForLayer.bounds
        var string = ""
        
        for _ in 1...20 {
             string += "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce auctor arcu quis velit congue dictum. "
        }
        
        textLayer.string = string
        textLayer.font = helveticaFont
        textLayer.foregroundColor = UIColor.darkGray.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = .left
        textLayer.truncationMode = .end
        textLayer.contentsScale = UIScreen.main.scale
        
        
    }
    
    
     // MARK: - IBActions
    
    @IBAction func fontSegmentedControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case Font.helvetica.rawValue:
          textLayer.font = helveticaFont
        case Font.noteworthyLight.rawValue:
          textLayer.font = noteworthyLightFont
        default:
          break
        }
        
    }
    
    @IBAction func fontSizeSliderChanged(_ sender: UISlider) {
        fontSizeSliderValueLabel.text = "\(Int(sender.value * 100.0))%"
         fontSize = baseFontSize * CGFloat(sender.value)
    }
    
    @IBAction func wrapTextSwitchChanged(_ sender: UISwitch) {
        alignmentModeSegmentedControl.selectedSegmentIndex = AlignmentMode.left.rawValue
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        
        if sender.isOn {
          if let truncationMode = TruncationMode(rawValue: truncationModeSegmentedControl.selectedSegmentIndex) {
            previouslySelectedTruncationMode = truncationMode
          }
          
            truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
          textLayer.isWrapped = true
        } else {
          textLayer.isWrapped = false
          truncationModeSegmentedControl.selectedSegmentIndex = previouslySelectedTruncationMode.rawValue
        }
    }
    
    
    @IBAction func alignmentModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = true
        textLayer.isWrapped = true
        truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        textLayer.truncationMode = CATextLayerTruncationMode.none
        
        switch sender.selectedSegmentIndex {
        case AlignmentMode.left.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
        case AlignmentMode.center.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
        case AlignmentMode.justified.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.justified
        case AlignmentMode.right.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.right
        default:
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
        }
    }
    
    
    @IBAction func truncationModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        
        wrapTextSwitch.isOn = false
         textLayer.isWrapped = false
        alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
         
         switch sender.selectedSegmentIndex {
         case TruncationMode.start.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.start
         case TruncationMode.middle.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.middle
         case TruncationMode.end.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.end
         default:
            textLayer.truncationMode = CATextLayerTruncationMode.none
         }
        
    }
    
    
}
