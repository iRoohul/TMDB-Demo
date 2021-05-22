//
//  SynopsisTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class SynopsisTableViewCell: MovieDetailRowCell {
    
    @IBOutlet weak var movieImageView: RemoteImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let synopsis = item as? SynopsisItem {
            movieImageView.setImage(urlString: synopsis.data?.imageUrl, placeholder: nil)
        }
    }
}
