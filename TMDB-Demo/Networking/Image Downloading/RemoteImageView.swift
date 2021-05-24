//
//  RemoteImageView.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

class RemoteImageView: UIImageView {
    
    var urlString: String = ""
    /**
     Downloads the image from the remote url and sets it to the image view. Make sure that the urlString is valid to avoid unnecessary API call.
     */
    func setImage(urlString: String?, placeholder: UIImage?, placeholderUrlString: String? = nil) {
        
        if let cached = DownloadManager.sharedInstance.cachedImage(for: placeholderUrlString ?? "") {
            self.image = cached
        }
        else {
            self.image = placeholder
        }
        
        guard let urlString = urlString else {return}
        self.urlString = urlString
        
        DownloadManager.sharedInstance.downloadImage(urlString: urlString) { (image, url, error) in
            if let url = url, url == self.urlString {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}


