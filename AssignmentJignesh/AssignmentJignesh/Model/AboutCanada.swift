
import Foundation

struct AboutCanada: Codable {
    var title: String?
    var rows: [Rows] = []
}

struct Rows: Codable {
    let title: String?
    let description: String?
    let imageURL: String?
    
    enum CodingKeys : String, CodingKey {
        case title
        case description
        case imageURL = "imageHref"
    }
}
