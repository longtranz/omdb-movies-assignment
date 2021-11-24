//
//  MovieViewController.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/20/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieViewController: UIViewController {
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    @IBOutlet private weak var movieSearchBar: UISearchBar!
    
    private let movieViewModel = MovieViewModel()
    private var movies: [MovieListModel] = []

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
    }

    private func bind() {
        movieViewModel.movies.bind(to: moviesCollectionView.rx.items(cellIdentifier: "MovieListCollectionViewCell", cellType: MovieListCollectionViewCell.self)) { rowIndex, data, cell in
            cell.bindData(movie: data)
        }.disposed(by: disposeBag)

        movieViewModel.currentQuery.bind(to: movieSearchBar.rx.text).disposed(by: disposeBag)
    }
}

