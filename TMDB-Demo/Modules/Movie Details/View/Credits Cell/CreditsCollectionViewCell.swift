//
//  CreditsCollectionViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 24/05/21.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clear()
        
        layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    }
    
    func configure(cast: Cast) {
        
        setValues(name: cast.name,
                  caption: "as " + cast.character,
                  imageUrl: cast.imageUrl,
                  gender: Gender(rawValue: cast.gender) ?? .unknown)
    }
    
    func configure(crew: Crew) {
        
        setValues(name: crew.name,
                  caption: crew.department,
                  imageUrl: crew.imageUrl,
                  gender: Gender(rawValue: crew.gender) ?? .unknown)
    }
    
    private func setValues(name: String?, caption: String?, imageUrl: String?, gender: Gender) {
        profileImageView.setImage(urlString: imageUrl, placeholder: gender.placeHolderImage)
        nameLabel.text = name
        captionLabel.text = caption
    }
    
    private func clear() {
        nameLabel.text = ""
        captionLabel.text = ""
    }
}
