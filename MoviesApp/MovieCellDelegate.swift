//
//  Movies.swift
//  MoviesApp
//
//  Created by Tekla Matcharashvili on 04.11.23.
//
import UIKit

protocol MovieCellDelegate: AnyObject {
    func didTapFavoriteButton(cell: MovieCell)
}

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    weak var delegate: MovieCellDelegate?
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
        contentView.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = contentView.bounds
        favoriteButton.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
    }
    
    @objc private func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(cell: self)
    }
    
    func configure(with movie: Movie) {
        movieImageView.image = movie.image
        favoriteButton.isSelected = movie.isFavorited
    }
}

