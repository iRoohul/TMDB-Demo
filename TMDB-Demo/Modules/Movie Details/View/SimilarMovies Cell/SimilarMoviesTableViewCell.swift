//
//  SimilarMoviesTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class SimilarMoviesTableViewCell: MovieDetailRowCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let similar = item as? SimilarItem {
            
        }
    }

}
