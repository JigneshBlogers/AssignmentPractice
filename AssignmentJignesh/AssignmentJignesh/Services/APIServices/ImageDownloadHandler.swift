
import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error:Error?) -> Void

final class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.demo.imageDownloader"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    let imageCache = NSCache<NSString,UIImage>()
    static let shread = ImageDownloadManager()
    
    private init() {}
    
    func downloadImage(url:URL?, indexPath: IndexPath?, size: String = "M", handler: @escaping ImageDownloadHandler) {
        self.completionHandler = handler
        
        guard let imageURL = url else {return}
        
        if let cacheImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            self.completionHandler?(cacheImage,imageURL, indexPath,nil)
        } else {
            if let operations = (imageDownloadQueue.operations as? [ImageOperation])?.filter({$0.imageURL.absoluteString == imageURL.absoluteString && $0.isFinished == false && $0.isExecuting == true}) , let operation = operations.first {
                operation.queuePriority = .veryHigh
            } else {
                let operation = ImageOperation(imageURL: imageURL, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .veryHigh
                }
                
                operation.downloadHandler = { (image , url, indexPath,error) in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image,imageURL, indexPath,nil)
                }
                imageDownloadQueue.addOperation(operation)
                
            }
        }
    }
}

class ImageOperation: Operation {
    var downloadHandler: ImageDownloadHandler?
    var imageURL: URL!
    private var indexPath: IndexPath?
    
    override var isAsynchronous: Bool {
            return true
    }
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    func execute(_ execute: Bool) {
        _executing = execute
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    required init(imageURL: URL, indexPath: IndexPath?) {
        self.imageURL = imageURL
        self.indexPath = indexPath
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        execute(true)
        downloadImageFromUrl()
    }
    
    func downloadImageFromUrl() {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: imageURL) { (location, _, error) in
            if let loactionURL = location,let data = try? Data(contentsOf: loactionURL) {
                let image = UIImage(data: data)
                self.downloadHandler?(image,self.imageURL,self.indexPath,error)
            }
            self.finish(true)
            self.execute(false)
        }
        downloadTask.resume()
    }
}
