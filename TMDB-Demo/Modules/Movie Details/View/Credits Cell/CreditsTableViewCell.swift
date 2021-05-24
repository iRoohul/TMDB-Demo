//
//  CreditsTableViewCell.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import UIKit

class CreditsTableViewCell: MovieDetailRowCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var casts: [Cast] = []
    var crew: [Crew] = []
    
    var type: MovieDetailType = .cast
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: String(describing: CreditsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CreditsCollectionViewCell.self))
    }
    
    override func configure(item: MovieDetailVMitem) {
        
        super.configure(item: item)
        
        if let cast = item as? CastItem {
            casts = cast.data
            titleLabel.text = "Cast"
            type = .cast
        }
        else if let crew = item as? CrewItem {
            self.crew = crew.data
            titleLabel.text = "Crew"
            type = .crew
        }
        collectionView.reloadData()
    }
}

extension CreditsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .cast:
            return casts.count
        case .crew:
            return crew.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CreditsCollectionViewCell.self), for: indexPath) as? CreditsCollectionViewCell else {
            fatalError("UNEXPECTED: Cell with identifier \(String(describing: CreditsCollectionViewCell.self)) is not registered OR it is not a subclass of " + String(describing: CreditsCollectionViewCell.self))
        }
        switch type {
        case .cast:
            cell.configure(cast: casts[indexPath.item])
        case .crew:
            cell.configure(crew: crew[indexPath.item])
        default:
            break
        }
        return cell
    }
}

extension CreditsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

