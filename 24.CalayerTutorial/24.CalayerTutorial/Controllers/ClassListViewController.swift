//
//  ClassListViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/17.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

let count = 1_000_000_000

class ClassListViewController: UITableViewController {

    var classes: [(String, String,String)] {
      get {
        return [
          ("CALayer", "Manage and animate visual content","LayerSence"),
          ("CAScrollLayer", "Display portion of a scrollable layer","ScrollLayerScene"),
          ("CATextLayer", "Render plain text or attributed strings","TextLayerScene"),
          ("AVPlayerLayer", "Display an AV player ","PlayerLayerScene"),
          ("CAGradientLayer", "Apply a color gradient over the background","GradientLayerScene"),
          ("CAReplicatorLayer", "Duplicate a source layer","ReplicatorLayerScene"),
          ("CATiledLayer", "Asynchronously draw layer content in tiles","TiledLayerScene"),
          ("CAShapeLayer", "Draw using scalable vector paths","ShapeLayerScene"),
//          ("CAEAGLLayer", "Draw OpenGL content",""),
          ("CATransformLayer", "Draw 3D structures","TransformLayerScene"),
          ("CAEmitterLayer", "Render animated particles","")
        ]
      }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Layer tutorial"
        
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell")!
            let row = indexPath.row
            cell.textLabel!.text = classes[row].0
            cell.detailTextLabel!.text = classes[row].1
            cell.imageView!.image = UIImage(named: classes[row].0)
            return cell
    
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let name = classes[indexPath.row].2
        
        guard let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()else{
            return
        }
        vc.navigationItem.title = classes[indexPath.row].0
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
  
}
