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
    
    private var list: [MovieDetailVMitem] = [] {
        didSet {
            registerCells()
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindWithVM()
        vm.fetchDetails()
    }
    
    private func registerCells() {
        list.forEach {
            tableView.register(UINib(nibName: $0.cellIdentifier, bundle: nil), forCellReuseIdentifier: $0.cellIdentifier)
        }
    }
    
    //MARK:- Binding with VM
    
    private func bindWithVM() {
        dataObserver = vm.$vmItem.sink(receiveValue: { (item) in
            self.list = item
        })
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = list[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier) as? MovieDetailRowCell else {
            fatalError("UNEXPECTED: Cell with identifier \(item.cellIdentifier) is not registered OR it is not a subclass of " + String(describing: MovieDetailRowCell.self))
        }
        
        cell.configure(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(list[indexPath.row].rowHeight)
    }
    
}
