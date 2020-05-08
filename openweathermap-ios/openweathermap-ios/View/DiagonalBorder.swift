
import Foundation
import UIKit

class DiagonalBorder {
    
    func makePoints(frame: CGRect, cornerSize: CGFloat) -> CGPath?{
        if let context = UIGraphicsGetCurrentContext() {
            let topLeftCornerPoint = cornerSize
            let topRightDiagonalStartPointX = frame.width - cornerSize
            let topRightDiagonalEndPointX = frame.width - cornerSize - cornerSize
            let topRightDiagonalEndPointY = -cornerSize
            let rightTopStartPointX = frame.width
            let rightTopStartPointY = cornerSize
            let rightBottomEndPointX = frame.width
            let rightBottomEndPointY = frame.height - cornerSize
            let rightBottonDiagonalStartPointX = frame.width - cornerSize
            let rightBottonDiagonalStartPointY = frame.height
            let bottonStartPointX = cornerSize
            let bottonStartPointY = frame.height
            let leftBottonDiagonalStartPointX = -cornerSize
            let lefttBottonDiagonalStartPointY = frame.height - (cornerSize + CGFloat(cornerSize))
            let leftTopStartPointX = Int(0)
            let leftTopStartPointY = Int(cornerSize)
            let leftTopDiagonalStartPointX = Int(cornerSize)
            let leftTopDiagonalStartPointY = Int(0)
            
            context.beginPath()
            //top right corner
            context.move(to: CGPoint(x:0,y:0))
            context.addLine(to: CGPoint(x: topLeftCornerPoint, y: 0))
            //top line
            context.addLine(to:  CGPoint(x: topRightDiagonalStartPointX, y: 0))
            
            //top right diagonal corner
            context.addLine(to:  CGPoint(x: topRightDiagonalEndPointX, y: topRightDiagonalEndPointY))
            context.addLine(to:  CGPoint(x: rightTopStartPointX, y:  rightTopStartPointY))
            
            //bottom right diagonal corner
            context.addLine(to:  CGPoint(x: rightBottomEndPointX, y: rightBottomEndPointY))
            context.addLine(to:  CGPoint(x: rightBottonDiagonalStartPointX, y: rightBottonDiagonalStartPointY ))
            
            //bottom left corner
            context.addLine(to:  CGPoint(x: bottonStartPointX, y: bottonStartPointY ))
            context.addLine(to:  CGPoint(x: leftBottonDiagonalStartPointX, y: lefttBottonDiagonalStartPointY ))
            
            //finish top left corner
            context.addLine(to:  CGPoint(x: leftTopStartPointX, y:  leftTopStartPointY))
            context.addLine(to:  CGPoint(x: leftTopDiagonalStartPointX, y: leftTopDiagonalStartPointY))
            
            context.setFillColor(UIColor.clear.cgColor)
            context.closePath()
            return context.path
        }
        return UIGraphicsGetCurrentContext()?.path
    }
}
