//
//  SynopsisTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class SynopsisTableViewCell: MovieDetailRowCell {
    
    /**
     The main poster image view
     */
    @IBOutlet weak var movieImageView: RemoteImageView!
    
    /**
     This is the image view that's shown behind synopsis texts with a blur view.
     */
    @IBOutlet weak var bottomImageView: RemoteImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let synopsis = item as? SynopsisItem {
            bottomImageView.setImage(urlString: synopsis.data?.imageUrl, placeholder: nil, placeholderUrlString: synopsis.data?.placeholderImageUrl)
            movieImageView.setImage(urlString: synopsis.data?.imageUrl, placeholder: nil, placeholderUrlString: synopsis.data?.placeholderImageUrl)
        }
    }
}
