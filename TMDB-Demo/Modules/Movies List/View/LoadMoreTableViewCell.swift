//
//  LoadMoreTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 23/05/21.
//

import UIKit

class LoadMoreTableViewCell: BaseMovieTableViewCell {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityView.startAnimating()
    }
}
