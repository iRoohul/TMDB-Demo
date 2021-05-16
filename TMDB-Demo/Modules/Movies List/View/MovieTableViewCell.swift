//
//  MovieTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

protocol MovieTableViewCellDelegate {
    func bookButtonTapped(cell: MovieTableViewCell)
}

class MovieTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var movieImageView: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var delegate: MovieTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clear()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- View setup
    
    func configure(with movie: MovieDetails) {
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
    
    //MARK:- IBAction
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        delegate?.bookButtonTapped(cell: self)
    }
}
