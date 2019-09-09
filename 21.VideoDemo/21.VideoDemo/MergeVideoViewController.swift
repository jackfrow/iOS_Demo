//
//  MergeVideoViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/7.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import MediaPlayer
import Photos

class MergeVideoViewController: UIViewController {

    var firstAsset : AVAsset?
    var secondAsset : AVAsset?
    var audioAsset : AVAsset?
    var loadingAssetOne = false
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func LoadAsset1(_ sender: Any) {
        
        if savedPhotosAvailable() {
            
            loadingAssetOne = true
            VideoHelper.showPicker(delegate: self, sourceType: .savedPhotosAlbum)
            
        }
        
    }
    
    @IBAction func LoadAsset2(_ sender: Any) {
        
        loadingAssetOne = false
        VideoHelper.showPicker(delegate: self, sourceType: .savedPhotosAlbum)
        
    }
    
    @IBAction func LoadAudio(_ sender: Any) {
        
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Select Audio"
        
        self.present(mediaPickerController, animated: true, completion: nil)
        
    
        
    }
    
    @IBAction func Merge(_ sender: Any) {
        
        guard let firstAsset = firstAsset, let secondAsset = secondAsset else{
            return
        }
        indicator.startAnimating()
        
        // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        let mixCompostion = AVMutableComposition()
        
        // 2 - Create two video tracks
        
        guard let compositionTrack = mixCompostion.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
            return
        }
        
        let firstTimeRange = CMTimeRange(start: .zero, duration: firstAsset.duration)
        let secondTimeRange = CMTimeRange(start: .zero, duration: secondAsset.duration)
        
        //appen video
        
        do {
            try compositionTrack.insertTimeRange(firstTimeRange, of: firstAsset.tracks(withMediaType: .video)[0], at: .zero)
            try compositionTrack.insertTimeRange(secondTimeRange, of: secondAsset.tracks(withMediaType: .video)[0], at: firstAsset.duration)
        } catch  {
            print("Failed to append")
            return
        }

        
    // 3 - Audio track
        if let loadedAudioAsset = audioAsset {
            let audioTrack = mixCompostion.addMutableTrack(withMediaType: .audio, preferredTrackID: 0)
            do {
                try audioTrack?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: CMTimeAdd(firstAsset.duration, secondAsset.duration)), of: loadedAudioAsset.tracks(withMediaType: .audio)[0], at: .zero)
            } catch  {
                print("Failed to load Audio track")
            }
        }
        
    //4 - Get path
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).mov")
    // 5 - Create Exporter
        guard let exporter  = AVAssetExportSession(asset: mixCompostion, presetName: AVAssetExportPresetHighestQuality)  else {
            return
        }
        exporter.outputURL = url
        exporter.outputFileType = .mov
        exporter.shouldOptimizeForNetworkUse = true
        
        // 6 - Perform the Export
        exporter.exportAsynchronously {
            DispatchQueue.main.async {
                self.exportDidFinish(exporter)
            }
        }
        
    }
    
    
    func exportDidFinish(_ session: AVAssetExportSession)  {
        //clean asset
        indicator.stopAnimating()
        firstAsset = nil
        secondAsset = nil
        audioAsset = nil
        
        
        guard  session.status == .completed,let outputURL = session.outputURL else {
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
    
    
    //MARK:- Help
   func savedPhotosAvailable() -> Bool {
     guard !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return true }
     
     let alert = UIAlertController(title: "Not Available", message: "No Saved Album found", preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
     present(alert, animated: true, completion: nil)
     return false
   }
   

}

extension MergeVideoViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let mediaType =  info[.mediaType] as? String,mediaType == (kUTTypeMovie as String),let url = info[.mediaURL] as? URL
            else { return }
        let avasset = AVAsset(url: url)
        var message = ""
        if loadingAssetOne {
            firstAsset = avasset
             message = "Video one loaded"
        }else{
            secondAsset = avasset
             message = "Video two loaded"
        }
        
        let alert = UIAlertController(title: "Asset Loaded", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alert, animated: true, completion: nil)
        
    }
    
}

extension MergeVideoViewController: UINavigationControllerDelegate{
    
}

extension MergeVideoViewController: MPMediaPickerControllerDelegate{
 
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        dismiss(animated: true, completion: nil)
        
        let selectSongs = mediaItemCollection.items
        guard let first = selectSongs.first else { return }
        let url = first.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
        self.audioAsset = (url == nil) ? nil : AVAsset(url: url!)
        let title = (url == nil) ? "Asset Not Available" : "Asset Loaded"
        let message = (url == nil) ? "Audio Not Loaded" : "Audio Loaded"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
         self.present(alert, animated: true, completion: nil)
        
    }
    
}
