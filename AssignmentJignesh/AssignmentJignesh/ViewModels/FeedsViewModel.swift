
import UIKit
import Alamofire
import SwiftyJSON

class HomFeedViewModel {

    func fetchRequestFeedsUsers(completionHandler: @escaping (Error?) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let task = session.dataTask(with: url) { data, response, error in
     
            guard error == nil else {
                print ("error: \(error!)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            if let jsonData = jsonStr.data(using: .utf8)
            {
            // Use `jsonData`
            let decoder = JSONDecoder()
            do {
            let facts = try decoder.decode(Facts.self, from: jsonData)
            print(facts.title)
            facts.rows.forEach{
            print($0)
            }
            } catch {
            print(error.localizedDescription)
            }
            } else {
            // Respond to error
            }
        }
        task.resume()
    }
}

protocol FeedsViewModelProtocol {
    var title: Dynamic<String> { get }
    var selectedData: ListModel? { get set }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    func didSelectItemAt(indexPath: IndexPath)
}

