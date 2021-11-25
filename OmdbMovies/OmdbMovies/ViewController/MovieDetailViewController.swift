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
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UIButton!
    @IBOutlet private weak var synopsisLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var reviewsLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var writerLabel: UILabel!
    @IBOutlet private weak var actorsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!

    private let movieDetailViewModel = MovieDetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        setupView()
        bindVM()
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: contentView.frame.height)
    }

    func loadMovie(for movieId: String) {
        movieDetailViewModel.fetchMovie(movieId)
    }

    private func bindVM() {
        movieDetailViewModel.movie.subscribe(onNext: { [weak self] movie in
            guard let strongSelf = self else {
                return
            }

            strongSelf.setupData(with: movie)
        }).disposed(by: disposeBag)
    }

    private func setupView() {
        let backIcon = UIImage(named: "Back")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backIcon, for: .normal)
        backButton.setTitle("", for: .normal)
    }

    private func setupData(with movie: MovieModel) {
        if let poster = movie.poster, let thumbnailUrl = URL(string: poster) {
            self.thumbnailImageView.kf.setImage(with: thumbnailUrl)
        }

        titleLabel.text = movie.title
        yearLabel.text = movie.year
        categoryLabel.text = movie.genre
        durationLabel.text = movie.runtime
        ratingLabel.setTitle(movie.imdbRating, for: .normal)
        synopsisLabel.text = movie.plot
        scoreLabel.text = movie.ratings?.first?.value
        reviewsLabel.text = movie.imdbVotes
        popularityLabel.text = movie.metascore
        directorLabel.text = movie.director
        writerLabel.text = movie.writer
        actorsLabel.text = movie.actors
    }

    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
