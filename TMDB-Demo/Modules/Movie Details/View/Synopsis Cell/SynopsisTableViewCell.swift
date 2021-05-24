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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let synopsis = item as? SynopsisItem, let data = synopsis.data {
            bottomImageView.setImage(urlString: data.imageUrl, placeholder: nil, placeholderUrlString: data.placeholderImageUrl)
            movieImageView.setImage(urlString: data.imageUrl, placeholder: nil, placeholderUrlString: data.placeholderImageUrl)
            
            languageLabel.text = "\u{2022} " + (data.originalLanguage?.completeLanguage ?? "")
            durationLabel.text = "\u{2022} " + (data.runtime?.durationInHour ?? "")
            releaseDateLabel.text = "\u{2022} " + (data.releaseDate?.formattedDate ?? "")
            genreLabel.text = GenreHandler.shared.genreText(for: data.genres)
            
            descriptionLabel.text = data.overview
        }
    }
}
