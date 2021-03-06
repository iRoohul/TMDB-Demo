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

class BaseMovieTableViewCell: UITableViewCell {
    
    var delegate: MovieTableViewCellDelegate?

    @IBOutlet weak var movieImageView: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with movie: MovieDetails) {}

}


class MovieTableViewCell: BaseMovieTableViewCell {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var approvalLabel: UILabel!
    
    @IBOutlet weak var approvalProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clear()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- View setup
    
    override func configure(with movie: MovieDetails) {
        super.configure(with: movie)
        
        movieImageView.setImage(urlString: movie.cellImageUrl, placeholder: #imageLiteral(resourceName: "MoviePlaceholder"))
        nameLabel.text = movie.originalTitle
        
        releaseDateLabel.text = movie.releaseDate.formattedDate
        genreLabel.text = GenreHandler.shared.genreText(for: movie.genreIDS)
        
        //Approval
        let approvalPercent = movie.voteAverage * 10
        
        approvalProgressView.progress = Float(approvalPercent/100)
        approvalLabel.text = "Approval- " + String(Int(approvalPercent)) + "%"
        
        if approvalPercent > 75 {
            approvalProgressView.progressTintColor = .systemGreen
        }
        else if approvalPercent > 50 {
            approvalProgressView.progressTintColor = .systemOrange
        }
        else {
            approvalProgressView.progressTintColor = .red
        }
    }

    private func clear() {
        nameLabel.text = ""
        releaseDateLabel.text = ""
        genreLabel.text = ""
    }
    
    //MARK:- IBAction
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        delegate?.bookButtonTapped(cell: self)
    }
}
