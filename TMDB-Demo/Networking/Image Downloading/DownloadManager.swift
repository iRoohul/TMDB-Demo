//
//  DownloadManager.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

private let timeOut = 60

import UIKit

class DownloadManager {

    static let sharedInstance = DownloadManager()

    private let imageCache = NSCache<NSString, UIImage>()
    private let session = URLSession(configuration: .default)

    typealias DownloadResult = (_ image: UIImage?, _ url: String?, _ error: Error? ) -> Void

    private init() {}

    /**
     Downloads the image and returns in a completion handler. Maintains cache to not to download the image every time. Completion handler returns in a background thread.
     */
    func downloadImage(urlString: String, completion: @escaping DownloadResult) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage, urlString, nil)
        } else {
            downloadAndCacheImage(urlString: urlString, completion: completion)
        }
    }

    //MARK:- Private functions

    private func downloadAndCacheImage(urlString: String, completion: @escaping DownloadResult) {

        print("Started downloading url: \(urlString)")
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(timeOut))

        let dataTask = self.session.dataTask(with: urlRequest) { (data, response, error) in

            if let error = error {
                completion(nil, nil, error)
                print("Error downloading url: \(urlString) \n error:\(error.localizedDescription)")
            }
            else if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                completion(image, urlString, nil)
                print("Finished downloading url: \(urlString)")
            }
            else {
                completion(nil, nil, error)
                print("Error downloading url: \(urlString) \n error:\(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume()
    }
    
    /**
     Returns an UIImage if its there in the Cache otherwise returns nil
     */
    func cachedImage(for url: String) -> UIImage? {
        imageCache.object(forKey: url as NSString)
    }
}
