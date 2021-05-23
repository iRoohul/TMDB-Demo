//
//  SearchTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 23/05/21.
//

import UIKit

class SearchTableViewCell: BaseMovieTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clear()
    }
    
    override func configure(with movie: MovieDetails) {
        super.configure(with: movie)
        
        movieImageView.setImage(urlString: movie.searchCellImageUrl, placeholder: #imageLiteral(resourceName: "MoviePlaceholder"))
        nameLabel.text = movie.originalTitle
    }
    
    private func clear() {
        nameLabel.text = ""
    }
}
