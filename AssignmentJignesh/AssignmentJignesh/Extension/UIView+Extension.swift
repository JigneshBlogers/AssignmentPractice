
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    @discardableResult
    func activityIndicatory(animate:Bool = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: self.frame)
        mainContainer.center = self.center
        mainContainer.backgroundColor = UIColor.init(rgb: 0xFFFFFF)
        mainContainer.alpha = 0.5
        mainContainer.tag = 123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = self.center
        viewBackgroundLoading.backgroundColor = UIColor(rgb: 0x444444)
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.style =
            UIActivityIndicatorView.Style.large
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if animate {
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            self.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        } else {
            for subview in self.subviews where subview.tag == 123 {
                subview.removeFromSuperview()
            }
        }
        return activityIndicatorView
    }
}
