//
//  MovieDetailsViewController.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    
    var vm: MovieDetailsVM!
    
    private var dataObserver: AnyCancellable?
    private var stateObsrver: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindWithVM()
        vm.fetchDetails()
    }
    
    //MARK:- Binding with VM
    
    private func bindWithVM() {
        dataObserver = vm.$vmItem.sink(receiveValue: { (item) in
            print("Synopsis : \(item.synopsis?.originalTitle)")
            print("reviews : \(item.reviews?.id)")
            print("credits : \(item.credits?.cast.first?.character)")
            print("similar : \(item.similar?.page)")
        })
        
        stateObsrver = vm.$state.sink(receiveValue: { (state) in
            switch state.synopsisState {
            case .loading:
                break
            case .finishedLoading:
                break
            case .error(_):
                break
            }
        })
    }
}
