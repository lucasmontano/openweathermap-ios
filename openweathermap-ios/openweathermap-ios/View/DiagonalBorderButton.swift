import Foundation
import UIKit

class DiagonalBorderButton: UIButton {

    private let diagonalBorder = DiagonalBorder()

    var cornerSize: CGFloat = CGFloat(10) {
        didSet {
            setNeedsDisplay()
        }
    }

    var diagonalBorderView: Bool = true {
        didSet {
           setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
       super.draw(rect)
       if diagonalBorderView {
           let path = diagonalBorder.makePoints(frame: rect, cornerSize: cornerSize)
           let caShapeLayer = CAShapeLayer()
           caShapeLayer.fillRule = .nonZero
           caShapeLayer.path = path
           self.layer.mask = caShapeLayer
           self.layer.masksToBounds = true
        }
    }
}
