
import Foundation
import UIKit

protocol Reusable: class {}

extension UITableViewCell: Reusable {
    class var reuseIdentifire: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifire)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            print("Could not deque cell with identifier")
            return T()
        }
        return cell
    }
}
