
import Foundation
import UIKit

struct Constants {
    struct CommonText {
        static let pullToRefresh = "Pull to refresh"
    }
    struct Title {
        static let viewControllerTitle = "No Title"
    }
    struct FontSize {
    static let titleLabelOFCanadaCell:CGFloat = 20
        static let descriptionLabelOFCanadaCell:CGFloat = 18
    }
    
    struct APIEndPoint {
       static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    struct ErrorMessages {
        static let invalidURL = "URL is invalid"
        static let invalidData = "Malformed data received from fetchAllRooms service"
        static let decodingFailed = "Decoding failed"
    }
}
