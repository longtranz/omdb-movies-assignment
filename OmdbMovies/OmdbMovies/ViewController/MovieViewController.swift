//
//  MovieViewController.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/20/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MovieViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    private weak var refreshControl: UIRefreshControl!

    private let MOVIE_CELL_IDENTIFIER = "MovieListCollectionViewCell"
    private let MOVIE_SEARCHBAR_HEADER_IDENTIFIER = "CollectionViewHeader"
    
    private let movieViewModel = MovieViewModel()

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter text for searching movie"
        sc.searchBar.text = "Marvel"
        return sc
    }()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupView()
        bindVM()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func setupNavigationBar() {
        navigationItem.searchController = searchController
    }

    private func setupView() {
        moviesCollectionView.refreshControl = refreshControl
    }

    private func bindVM() {
        movieViewModel.bindView()

        movieViewModel.movies
            .bind(to: moviesCollectionView.rx.items(cellIdentifier: MOVIE_CELL_IDENTIFIER,
                                                    cellType: MovieListCollectionViewCell.self)) { rowIndex, data, cell in
            cell.bindData(movie: data)
        }.disposed(by: disposeBag)

        // Movie selected
        Observable.zip(moviesCollectionView.rx.itemSelected, moviesCollectionView.rx.modelSelected(MovieListModel.self))
            .bind { [unowned self] indexPath, movie in
                moviesCollectionView.deselectItem(at: indexPath, animated: true)
                if let movieId = movie.imdbID {
                    self.showMovieDetail(movieId)
                }
        }.disposed(by: disposeBag)

        searchController.searchBar
            .rx
            .text
            .orEmpty
            .bind(to: movieViewModel.currentQuery)
            .disposed(by: disposeBag)
    }

    private func showMovieDetail(_ movieId: String) {
        guard let movieDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("Cannot init MovieDetailViewController")
        }

        navigationController?.show(movieDetailViewController, sender: self)
        movieDetailViewController.loadMovie(for: movieId)
    }
}

extension MovieViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
