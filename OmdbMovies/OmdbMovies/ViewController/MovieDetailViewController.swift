//
//  MovieDetailViewController.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/24/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    private let movieDetailViewModel = MovieDetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindVM()
    }

    func loadMovie(for movieId: String) {
        movieDetailViewModel.fetchMovie(movieId)
    }

    private func bindVM() {
        movieDetailViewModel.movie.subscribe(onNext: { [weak self] movie in
            guard let strongSelf = self else {
                return
            }

            strongSelf.setupView(with: movie)
        }).disposed(by: disposeBag)
    }

    private func setupView(with movie: MovieModel) {
        if let poster = movie.poster, let thumbnailUrl = URL(string: poster) {
            self.thumbnailImageView.kf.setImage(with: thumbnailUrl)
        }

        titleLabel.text = movie.title
        yearLabel.text = movie.year
    }
}
