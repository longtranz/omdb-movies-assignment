//
//  MovieListCollectionViewCell.swift
//  OmdbMovies
//
//  Created by DucNT65.FIN on 11/24/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var movieThumbnail: UIImageView!
    @IBOutlet private var movieTitle: UILabel!

    func bindData(movie: MovieListModel) {
        if let thumbnailUrl = URL(string: movie.poster) {
            movieThumbnail.kf.setImage(with: thumbnailUrl)
        }
        movieTitle.text = movie.title
    }
}
