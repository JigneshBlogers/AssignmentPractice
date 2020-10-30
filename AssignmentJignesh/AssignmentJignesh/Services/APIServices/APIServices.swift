
import Foundation

enum APiError: Error {
    case inValidURL
    case invalidData
    case decodingFailed
}

extension APiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .inValidURL:
            return Constants.ErrorMessages.invalidURL
            
        case .invalidData:
            return Constants.ErrorMessages.invalidData
            
        case .decodingFailed:
            
            return Constants.ErrorMessages.decodingFailed
        }
    }
}

class APIServices {
    static let sharedAPIServices = APIServices()
    let configuration = URLSessionConfiguration.default
    var urlSession: URLSession!
   
    private init() {
        urlSession = URLSession(configuration: configuration)
    }
    
    func getData<T:Codable>(urlString: String,decodingType: T.Type, completion: @escaping (Result<T,APiError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(Result.failure(.inValidURL))
            }
            return
        }
    
        let dataTask = urlSession.dataTask(with: url) { (data, _, error) in
            
            guard let data = data, let dataFromString = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                DispatchQueue.main.async {
                    completion(Result.failure(.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(decodingType, from: dataFromString)
                DispatchQueue.main.async {
                    completion(Result.success(result))
                }
            } catch let error {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                   completion(Result.failure(.decodingFailed))
                }
            }
        }
        dataTask.resume()
    }
}
