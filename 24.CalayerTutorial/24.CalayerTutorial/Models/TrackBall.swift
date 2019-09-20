//
//  TrackBall.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/20.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

func pow2(_ lhs: CGFloat) -> CGFloat {
    return pow(lhs, 2)
}

class TrackBall {

    let tolerance = 0.001
    var baseTransform = CATransform3DIdentity
    let trackBallRadius: CGFloat
    let trackBallCenter: CGPoint
    var trackBallStartPoint = (x: CGFloat(0.0), y: CGFloat(0.0), z: CGFloat(0.0))
    
    init(location: CGPoint, inRect bounds: CGRect) {
      if bounds.width > bounds.height {
        trackBallRadius = bounds.height * 0.5
      } else {
        trackBallRadius = bounds.width * 0.5
      }
      
      trackBallCenter = CGPoint(x: bounds.midX, y: bounds.midY)
      setStartPointFromLocation(location)
    }
    
    //若触摸点在球面上,则x2+y2+z2 = r2
    func setStartPointFromLocation(_ location: CGPoint) {
      trackBallStartPoint.x = location.x - trackBallCenter.x
      trackBallStartPoint.y = location.y - trackBallCenter.y
      let distance = pow2(trackBallStartPoint.x) + pow2(trackBallStartPoint.y)
      trackBallStartPoint.z = distance > pow2(trackBallRadius) ? CGFloat(0.0) : sqrt(pow2(trackBallRadius) - distance)
    }
    
    
    func finalizeTrackBallForLocation(_ location: CGPoint) {
      baseTransform = rotationTransformForLocation(location)
    }
    
    
      func rotationTransformForLocation(_ location: CGPoint) -> CATransform3D {
        
        var trackBallCurrentPoint = (x: location.x - trackBallCenter.x, y: location.y - trackBallCenter.y, z: CGFloat(0.0))
        
        let withinTolerance = fabs(Double(trackBallCurrentPoint.x - trackBallStartPoint.x)) < tolerance && fabs(Double(trackBallCurrentPoint.y - trackBallStartPoint.y)) < tolerance
        
        if withinTolerance {
          return CATransform3DIdentity
        }
        
        let distance = pow2(trackBallCurrentPoint.x) + pow2(trackBallCurrentPoint.y)
        
        if distance > pow2(trackBallRadius) {
          trackBallCurrentPoint.z = 0.0
        } else {
          trackBallCurrentPoint.z = sqrt(pow2(trackBallRadius) - distance)
        }
        
        let startPoint = trackBallStartPoint
        let currentPoint = trackBallCurrentPoint
        let x = startPoint.y * currentPoint.z - startPoint.z * currentPoint.y
        let y = -startPoint.x * currentPoint.z + trackBallStartPoint.z * currentPoint.x
        let z = startPoint.x * currentPoint.y - startPoint.y * currentPoint.x
        var rotationVector = (x: x, y: y, z: z)
        
        let startLength = sqrt(Double(pow2(startPoint.x) + pow2(startPoint.y) + pow2(startPoint.z)))
        let currentLength = sqrt(Double(pow2(currentPoint.x) + pow2(currentPoint.y) + pow2(currentPoint.z)))
        let startDotCurrent = Double(startPoint.x * currentPoint.x + startPoint.y + currentPoint.y + startPoint.z + currentPoint.z)
        let rotationLength = sqrt(Double(pow2(rotationVector.x) + pow2(rotationVector.y) + pow2(rotationVector.z)))
        let angle = CGFloat(atan2(rotationLength / (startLength * currentLength), startDotCurrent / (startLength * currentLength)))
        
        let normalizer = CGFloat(rotationLength)
        rotationVector.x /= normalizer
        rotationVector.y /= normalizer
        rotationVector.z /= normalizer
        
        let rotationTransform = CATransform3DMakeRotation(angle, rotationVector.x, rotationVector.y, rotationVector.z)
        return CATransform3DConcat(baseTransform, rotationTransform)
        
    }
    
}
