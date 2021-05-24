//
//  MovieCollectionViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clear()
    }
    
    func configure(movie: MovieDetails) {
        bannerImageView.setImage(urlString: movie.cellImageUrl, placeholder: #imageLiteral(resourceName: "MoviePlaceholder"))
        nameLabel.text = movie.originalTitle
        captionLabel.text = movie.originalLanguage.completeLanguage
    }
    
    private func clear() {
        nameLabel.text = ""
        captionLabel.text = ""
    }
}
