//
//  MovieTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: MovieDetails) {
        clear()
        movieImageView.setImage(urlString: movie.cellImageUrl, placeholder: #imageLiteral(resourceName: "MoviePlaceholder"))
        
        nameLabel.text = movie.title
        releaseDateLabel.text = "Releasing on " + movie.releaseDate
        detailsLabel.text = movie.overview
    }

    private func clear() {
        nameLabel.text = ""
        releaseDateLabel.text = ""
        detailsLabel.text = ""
    }
}
