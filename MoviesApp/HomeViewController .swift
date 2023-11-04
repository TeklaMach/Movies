//
//  ViewController.swift
//  MoviesApp
//
//  Created by Tekla Matcharashvili on 04.11.23.
//

import UIKit

struct Movie {
    let title: String
    let image: UIImage
    var isFavorited: Bool = false
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var movies: [Movie] = [
        Movie(title: "Movie 1", image: UIImage(named: "movie1")!),
        Movie(title: "Movie 2", image: UIImage(named: "movie2")!),
        Movie(title: "Movie 3", image: UIImage(named: "movie3")!),
        Movie(title: "Movie 4", image: UIImage(named: "movie4")!),
        Movie(title: "Movie 5", image: UIImage(named: "movie5")!),
        Movie(title: "Movie 6", image: UIImage(named: "movie6")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(with: movies[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: MovieCellDelegate {
    func didTapFavoriteButton(cell: MovieCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            movies[indexPath.item].isFavorited.toggle()
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let movie: Movie
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        
        imageView.image = movie.image
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
    }
}
