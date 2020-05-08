
import Foundation
import UIKit

class DiagonalBorderView: UIView {
    
    private let diagonalBorder = DiagonalBorder()
    
    var cornerSize: CGFloat = CGFloat(7) {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var diagonalBorderView: Bool = true {
        didSet{
           setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if(diagonalBorderView){
            let path = diagonalBorder.makePoints(frame: rect, cornerSize: cornerSize)
            let blurEffectView = makeBlurView(path: path)
            self.addSubview(blurEffectView)
            self.sendSubviewToBack(blurEffectView)
        }
    }
    
    private func makeBlurView(path: CGPath?) -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.fillRule = .nonZero
        caShapeLayer.path = path
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.mask = caShapeLayer
        blurEffectView.layer.masksToBounds = true
        return blurEffectView
    }
}
