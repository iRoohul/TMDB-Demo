//
//  MovieDetailsViewController.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var vm: MovieDetailsVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.fetchDetails()
    }
}
