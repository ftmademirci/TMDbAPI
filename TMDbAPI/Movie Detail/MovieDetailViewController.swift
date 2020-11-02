//
//  MovieDetailViewController.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    var viewModel = MovieDetailViewModel(dependencies: MovieDetailViewModel.Dependencies(api: API()))
    var movieId = 0
    
    @IBOutlet var backgroundBlurImage: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    @IBOutlet var castView: UIView!
    @IBOutlet var castCollectionView: UICollectionView!
    
    @IBOutlet var videosView: UIView!
    @IBOutlet var videosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MovieCastCollectionViewCell
        let nibMovie = UINib(nibName: "MovieCastCollectionViewCell", bundle: nil)
        self.castCollectionView.register(nibMovie, forCellWithReuseIdentifier: "MovieCastCollectionViewCell")
        
        //VideosCollectionViewCell
        let nibVideo = UINib(nibName: "VideosCollectionViewCell", bundle: nil)
        self.videosCollectionView.register(nibVideo, forCellWithReuseIdentifier: "VideosCollectionViewCell")
        
        self.getMovieDetailData()
        self.getCastData()
        self.getVideosData()
    }
    
    func getMovieDetailData() {
        self.viewModel.getMovieDetailData (movieId: movieId, success: {
            let item = self.viewModel.movie_detail_data
            if let poster_path = item?.poster_path {
                self.movieImageView.sd_setImage(with: URL(string: Constants.imageUrl + poster_path), placeholderImage: UIImage(named: "placeholder.png"))
                self.backgroundBlurImage.sd_setImage(with: URL(string: Constants.imageUrl + poster_path))
                self.backgroundBlurImage.addBlurEffect()
            }
            self.movieTitleLabel.text = item?.original_title
            self.title = item?.original_title
            self.movieReleaseDateLabel.text = String(item?.release_date?.prefix(4) ?? "")
            self.movieDurationLabel.text = String(item?.runtime ?? 0) + " dk"
            self.movieRatingLabel.text = String(item?.vote_average ?? 0) + "/10"
            self.movieSummaryLabel.text = item?.overview
            
        }) { (error) in
            
        }
    }
    
    func getCastData() {
        self.viewModel.getCastData(movieId: movieId, success: {
            self.castCollectionView.reloadData()
        }) { (error) in
            
        }
    }
    
    func getVideosData() {
        self.viewModel.getVideosData(movieId: movieId, success: {
            if self.viewModel.numberOfVideos() == 0 {
                self.videosView.isHidden = true
            } else {
                self.videosCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    @objc func goURL(sender: UIButton) {
        let buttonTag = sender.tag
        let item =  self.viewModel.video_data?.results?[buttonTag]
       
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(item?.key ?? "")")
        UIApplication.shared.canOpenURL(youtubeURL!)
        
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castCollectionView {
            let item = self.viewModel.movie_cast?.cast?[indexPath.row]
            self.gotoPersonDetail(personId: item?.id ?? 0)
        } else if collectionView == videosCollectionView {
            let item = self.viewModel.video_data?.results?[indexPath.row]
            let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(item?.key ?? "")")
            UIApplication.shared.canOpenURL(youtubeURL!)

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(youtubeURL!)
            } else {
                UIApplication.shared.openURL(youtubeURL!)
            }
        }
    }
}
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return self.viewModel.numberOfCast()
        } else {
            return self.viewModel.numberOfVideos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath) as! MovieCastCollectionViewCell
            
            let item = self.viewModel.movie_cast?.cast?[indexPath.item]
            
            if item?.profile_path != nil {
                cell.movieCastImageView.sd_setImage(with: URL(string: Constants.imageUrl + item!.profile_path!), placeholderImage: UIImage(named: "placeholder.png"))
            }
            cell.movieCastTitleLabel.text = item?.name
            cell.movieCastCreditLabel.text = item?.character

            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as! VideosCollectionViewCell
            
            let item = self.viewModel.video_data?.results?[indexPath.item]
                        
            let youtubeThumbnailURL = "https://img.youtube.com/vi/\(item?.key ?? "")/0.jpg"
            
            cell.videoThumbnailImageView.sd_setImage(with: URL(string: youtubeThumbnailURL), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == castCollectionView {
            return CGSize(width: 140, height: 170)
        } else {
            return CGSize(width: 170, height: collectionView.bounds.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 5, bottom: 0, right: 5)
    }

}




