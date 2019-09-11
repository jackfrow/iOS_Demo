//
//  CommonVideoController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CommonVideoController: UIViewController {


    
    var videoAsset: AVAsset?//store select asset.
    
    func showPicker()  {
        
        if savedPhotosAvailable() {
            VideoHelper.showPicker(delegate: self, sourceType: .savedPhotosAlbum)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(userActive)
        userActive.color = UIColor.red

        
    }
    

    
    //video output
    func outPutFile()  {
        
        userActive.startAnimating()
        
        //1 - check if there have select asset.
        guard let videoAsset = videoAsset else {
            
            let alert = UIAlertController(title: "Error", message: "Please Load a Video Asset First", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                      present(alert, animated: true, completion: nil)
            return
        }
        
         // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        let mixComposition = AVMutableComposition()
        
        //3 - Video track
        guard  let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
            return
        }
        
        do {
            try videoTrack.insertTimeRange(CMTimeRangeMake(start: .zero, duration: videoAsset.duration), of: videoAsset.tracks(withMediaType: .video)[0], at: .zero)
        } catch  {
            print("faild to insert videoTrack")
            return
        }
        
        //2.2 - videoAssetTrack
        let videoAssetTrack = videoAsset.tracks(withMediaType: .video)[0]
        
        //3.1 - Create AVMutableVideoCompositionInstruction
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange =  CMTimeRange(start: .zero, duration: videoAsset.duration)
        
        //3.2 - Create an AVMutableVideoCompositionLayerInstruction for the video track and fix the orientation.
        let videoLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoAssetTrack)
        
        mainInstruction.layerInstructions = [videoLayerInstruction]
        
        // 4 - Add  VideoComposition
        let mainComposition = AVMutableVideoComposition()
        
        applyVideoEffetctsToComposition(composition: mainComposition, size: videoAssetTrack.naturalSize)
        
        //4.1 - configure VideoComposition
        mainComposition.renderSize = videoAssetTrack.naturalSize
        mainComposition.frameDuration = CMTime(value: 1, timescale: 30)
        mainComposition.instructions = [mainInstruction]
        
        //5 - Get path
              guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
              
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .long
              dateFormatter.timeStyle = .short
              let date = dateFormatter.string(from: Date())
              let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).mov")
          // 6 - Create Exporter
              guard let exporter  = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)  else {
                  return
              }
              exporter.outputURL = url
              exporter.outputFileType = .mov
              exporter.shouldOptimizeForNetworkUse = true
              exporter.videoComposition = mainComposition
              
              // 6 - Perform the Export
              exporter.exportAsynchronously {
                  DispatchQueue.main.async {
                      self.exportDidFinish(exporter)
                  }
              }
        
    }
    
    
    func exportDidFinish(_ session: AVAssetExportSession)  {
        
        
            self.userActive.stopAnimating()
                    
                    //clean asset
            self.videoAsset = nil
                    
                    guard  session.status == .completed,let outputURL = session.outputURL else {
                        
            //            print("error = \(session.error?.localizedDescription ?? "error")")
                        
                        return
                    }
                    
                    let saveVideoToPhotos = {
                    
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputURL)
                        }) { (saved, error) in
                            let success = saved && (error == nil)
                            let title = success ? "Success" : "Error"
                            let message = success ? "Video saved" : "Failed to save video"
                            
                            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    // Ensure permission to access Photo Library
                    if PHPhotoLibrary.authorizationStatus() != .authorized{
                        PHPhotoLibrary.requestAuthorization { (status) in
                            if status == .authorized{
                                saveVideoToPhotos()
                            }
                        }
                    }else{
                        saveVideoToPhotos()
                    }
            
        
    
        
    }
    
    
    //RenderEffect
    func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition,size: CGSize)  {
        //implement by subclass.
    }
    
    lazy var userActive: UIActivityIndicatorView = {
        
            let view = UIActivityIndicatorView()
           view.center = CGPoint(x: 375/2.0, y: UIScreen.main.bounds.size.height / 2.0 + 50)
           view.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
           return view
    }()

    
}


extension CommonVideoController: UINavigationControllerDelegate{
    
}

extension CommonVideoController: UIImagePickerControllerDelegate{
    
@objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let mediaType =  info[.mediaType] as? String,mediaType == (kUTTypeMovie as String),let url = info[.mediaURL] as? URL
            else { return }
        
        let avasset = AVAsset(url: url)
        videoAsset = avasset
        let message = "video asset loaded"
        
        let alert = UIAlertController(title: "Asset Loaded", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alert, animated: true, completion: nil)
        
    }
    
 @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Asset Cancel", message: "Asset Cancel", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)

    }
    
}
