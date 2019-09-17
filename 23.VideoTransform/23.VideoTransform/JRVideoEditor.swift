//
//  JRVideoEditor.swift
//  23.VideoTransform
//
//  Created by yy on 2019/9/11.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

//过渡方向
enum JRTransition:NSInteger {
      case Opacity
      case SwipeLeft
      case SwipeUp
      case SwipeDown
}

class JRVideoEditor: NSObject {

    //音视频资源
    var assets:[AVAsset]!
    //时间范围
    var timeRanges:[CMTimeRange]!
    
    //默认过渡动画时间2秒，淡入
    var transtionTime:CMTime = CMTimeMake(value: 2, timescale: 1)
    var transtionType:JRTransition = .Opacity
    
    //所有音视频资源合集
    var compostion:AVMutableComposition!
    //所有视屏资源合集
    var videoComposition:AVMutableVideoComposition!
    
    //处理所有的资源文件
    func buildComposition()  {
        
        if assets.count == 0 && assets == nil{
            return
        }
        compostion = AVMutableComposition()
        
        buildCompositionVideoTracks()
        buildCompositionAudioTracks()
        buildVideoComposition()
        
    }
    
    func buildCompositionVideoTracks()  {
        
        //使用invalid，系统会自动分配一个有效的trackId
              let trackId = kCMPersistentTrackID_Invalid
        
        //创建AB两条视频轨道,对两条轨道重叠部分的视图层做处理，就可以实现一些界面效果.
        guard let trackA = compostion.addMutableTrack(withMediaType: .video, preferredTrackID: trackId) else {
            return
        }
        guard let trackB = compostion.addMutableTrack(withMediaType: .video, preferredTrackID: trackId) else {
            return
        }
        
        
        let videoTracks = [trackA,trackB]
        //视屏片段插入时间轴的起始点
        var cursorTime = CMTime.zero
        
        for (index,value) in assets.enumerated() {
            //交叉使用A,Bd轨道
            let trackIndex = index % 2
            let currentTrack = videoTracks[trackIndex]
            
            //获取视屏资源中的视屏轨道(一个视屏资源可能会有多条轨道,这里只取第一条)
            guard let assetTrack = value.tracks(withMediaType: .video).first else {
                continue
            }

            
            do {
                //将提取到的视频轨道插入到空白轨道的指定位置
                try currentTrack.insertTimeRange(CMTimeRange(start: .zero, duration: value.duration), of: assetTrack, at: cursorTime)
                //光标移动到末尾处,以便下一段视屏的拼接
                cursorTime = CMTimeAdd(cursorTime, value.duration)
                 //光标回退转场动画时长的距离，这一段前后视频重叠部分组合成转场动画
                cursorTime = CMTimeSubtract(cursorTime, transtionTime)
                
            } catch  {
                print("insert error")
            }
            
        }
        
        
    }
    
    func buildCompositionAudioTracks()  {
        
        
        let trackId = kCMPersistentTrackID_Invalid
            guard let trackAudio = compostion.addMutableTrack(withMediaType: .audio, preferredTrackID: trackId) else {
                return
            }
            var cursorTime = CMTime.zero
            for (_,value) in assets.enumerated() {
                //获取视频资源中的音频轨道
                guard let assetTrack = value.tracks(withMediaType: .audio).first else {
                    continue
                }
                do {
                    try trackAudio.insertTimeRange(CMTimeRange(start: .zero, duration: value.duration), of: assetTrack, at: cursorTime)
                    cursorTime = CMTimeAdd(cursorTime, value.duration)
                } catch {
                    
                }
            }
        
    }
    
    func buildVideoComposition() {
    
           //创建默认配置的videoComposition
        videoComposition = AVMutableVideoComposition(propertiesOf: compostion)
         filterTransitionInstructions(of: videoComposition)
        videoComposition.renderSize = compostion.naturalSize
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        
       }
    
    /// 过滤出转场动画指令
    func filterTransitionInstructions(of videoCompostion: AVMutableVideoComposition) -> Void {
    
        
        let instructions = videoComposition.instructions as! [AVMutableVideoCompositionInstruction]
        
        for (index,instruct) in instructions.enumerated() {
            //非转场动画区域只有单轨道(另一个的空的)，只有两个轨道重叠的情况是我们要处理的转场区域
            
            guard  instruct.layerInstructions.count > 1 else {
                continue
            }
            
            var transitionType: JRTransition
            //需要判断转场动画是从A轨道到B轨道，还是B->A
            var  fromLayerInstruction: AVMutableVideoCompositionLayerInstruction
            var toLayerInstruction: AVMutableVideoCompositionLayerInstruction
             
            //获取前一段画面的轨道id
            let beforeTrackId = instructions[index - 1].layerInstructions[0].trackID
            //当前画面第一个轨道id
            let tempTrackId = instruct.layerInstructions[0].trackID
            //跟前一段画面同一轨道的为转场起点，另一轨道为终点
            if beforeTrackId == tempTrackId {
                fromLayerInstruction = instruct.layerInstructions[0] as! AVMutableVideoCompositionLayerInstruction
                toLayerInstruction = instruct.layerInstructions[1] as! AVMutableVideoCompositionLayerInstruction
                transitionType = .Opacity
            }else{
                fromLayerInstruction = instruct.layerInstructions[1] as! AVMutableVideoCompositionLayerInstruction
                toLayerInstruction = instruct.layerInstructions[0] as! AVMutableVideoCompositionLayerInstruction
                transitionType = .SwipeLeft
            }
            
            setupTransition(for: instruct, fromLayer: fromLayerInstruction, toLayer: toLayerInstruction, type: transitionType)
        
        }
        
    }
    
    //设置转场动画
    func setupTransition(for instruction: AVMutableVideoCompositionInstruction,fromLayer: AVMutableVideoCompositionLayerInstruction,toLayer:AVMutableVideoCompositionLayerInstruction ,type: JRTransition)  {
        
//        let identityTransform = CGAffineTransform.identity
        let timeRange = instruction.timeRange
        let videoSize = videoComposition.renderSize
        
        if type == .Opacity {
            fromLayer.setOpacityRamp(fromStartOpacity: 1.0, toEndOpacity: 0, timeRange: timeRange)
        }else{
            fromLayer.setCropRectangleRamp(fromStartCropRectangle: CGRect(origin: .zero, size: videoSize), toEndCropRectangle: CGRect(origin: .zero, size: CGSize(width: 0, height: videoSize.height)), timeRange: timeRange)
        }
        
        //重新赋值
        instruction.layerInstructions = [fromLayer,toLayer]
        
    }
    
    
    // MARK: - 导出合成的视频
    func export(){
        let session = AVAssetExportSession.init(asset: compostion.copy() as! AVAsset, presetName: AVAssetExportPreset1920x1080)
        
        session?.outputURL = JRVideoEditor.createTemplateFileURL()
        session?.outputFileType = AVFileType.mp4
        session?.videoComposition = videoComposition
        
        session?.exportAsynchronously(completionHandler: {[weak self] in
            guard let strongSelf = self else {return}
            let status = session?.status
            if status == AVAssetExportSession.Status.completed {
                strongSelf.saveToAlbum(atURL: session!.outputURL!, complete: { (success) in
                    DispatchQueue.main.async {
                       strongSelf.showSaveResult(isSuccess: success)
                    }
                })
            }
        })
    }
    // MARK: - utils
    private class func createTemplateFileURL() -> URL {
        
//        NSHomeDirectory()
        let path = NSTemporaryDirectory() + "composition.mp4"
        let fileURL = URL(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do { try FileManager.default.removeItem(at: fileURL) } catch {
                
            }
        }
        return fileURL
    }
    private func saveToAlbum(atURL url: URL,complete: @escaping ((Bool) -> Void)){
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }, completionHandler: { (success, error) in
            complete(success)
        })
    }
    private func showSaveResult(isSuccess: Bool) {
        let message = isSuccess ? "已保存到相册" : "保存失败"
        print("exportMessage = \(message)")
    
    }
    
    
}
