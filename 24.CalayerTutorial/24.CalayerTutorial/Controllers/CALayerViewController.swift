//
//  CALayerViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/17.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {
    
    @IBOutlet weak var viewForLayer: UIView!
    
    let layer = CALayer()
    let star = UIImage(named: "star")?.cgImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpLayer()
        viewForLayer.layer.addSublayer(layer)
        
       
    }
    
    func setUpLayer()  {
        
        layer.frame = viewForLayer.bounds
        layer.contents = star
        layer.contentsGravity = .center
        layer.isGeometryFlipped = false
        layer.cornerRadius = 100.0
        layer.borderWidth = 12.0
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = swiftOrangeColor.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3.0
        layer.magnificationFilter = .linear
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "DisplayLayerControls":
               
                if let destination = segue.destination as? CALayerControlsViewController {
                    destination.layerViewController = self
                }
                
            default:
                break
            }
        }
    }

}
