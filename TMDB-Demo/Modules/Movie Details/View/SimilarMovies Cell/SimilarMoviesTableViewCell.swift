//
//  SimilarMoviesTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class SimilarMoviesTableViewCell: MovieDetailRowCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var similar: SimilarItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let similar = item as? SimilarItem {
            self.similar = similar
            collectionView.reloadData()
        }
    }
}

extension SimilarMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similar?.data?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let similar = similar else {return UICollectionViewCell()}
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as? MovieCollectionViewCell else {
            fatalError("UNEXPECTED: Cell with identifier \(String(describing: MovieCollectionViewCell.self)) is not registered OR it is not a subclass of " + String(describing: MovieCollectionViewCell.self))
        }
        if let movie = similar?.data?.results[indexPath.item] {
            cell.configure(movie: movie)
        }
        return cell
    }
}

extension SimilarMoviesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 150, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
