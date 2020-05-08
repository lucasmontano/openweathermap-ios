import UIKit

class BookmarkViewController: UIViewController {

    @IBOutlet weak var mainView: DiagonalBorderView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: Animation apresentation
extension BookmarkViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimator()
    }
}
