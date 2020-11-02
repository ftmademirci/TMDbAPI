//
//  MainViewController.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class MainViewController: BaseViewController {
    
    var viewModel = MainViewModel(dependencies: MainViewModel.Dependencies(api: API()))
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var popularFilmsLabel: UILabel!
    
    var mediaType = "movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoHeader()
        self.setSegmentedControl()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        searchBar.showsCancelButton = false
        self.definesPresentationContext = true
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.getMoviesData()
    }
    
    func logoHeader() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 33))
        let titleImageView = UIImageView(image: UIImage(named: "TMDb_logo"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleView.addSubview(titleImageView)
        self.navigationItem.titleView = titleView
    }
    
    func setSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
    }
    
    func getMoviesData() {
        self.viewModel.getMovieData (success: {
            if self.viewModel.numberOfMovies() != 0 {
                self.popularFilmsLabel.isHidden = false
                self.collectionView.reloadData()
                self.collectionView.restore()
            } else {
                self.collectionView.setEmptyMessage("Not found :/")
            }
            
        }) { (error) in
            
        }
    }
    
    @objc func search() {
        viewModel.search(mediaType: mediaType, query: self.searchBar.text!, success: {
            self.popularFilmsLabel.isHidden = true
            if self.viewModel.numberOfMovies() == 0 {
                self.collectionView.setEmptyMessage("Not found :/")
                self.collectionView.reloadData()
            } else {
                self.segmentedControl.isHidden = false
                self.popularFilmsLabel.isHidden = true
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.collectionView.isHidden = true
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0: self.mediaType = "movie"
            self.search()
            break
        case 1: self.mediaType = "person"
            self.search()
            break
        default:
            break
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            self.searchBar.setShowsCancelButton(true, animated: true)
            return
        }
        
        guard !(textToSearch.count < 3) else {
            if (viewModel.movies_data?.results != nil) {
                self.viewModel.movies_data?.results?.removeAll()
                self.collectionView.reloadData()
            }
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.definesPresentationContext = true
        self.viewModel.movies_data?.results?.removeAll()
        self.segmentedControl.selectedSegmentIndex = 0
        self.collectionView.reloadData()
        self.segmentedControl.isHidden = true
        self.getMoviesData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0: // movie
            let item = self.viewModel.movies_data?.results?[indexPath.item]
            self.gotoMovieDetail(movieId: item?.id ?? 0)
            break
        case 1:
            let item = self.viewModel.movies_data?.results?[indexPath.item]
            self.gotoPersonDetail(personId: item?.id ?? 0)
        default:
            break
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            
            let item = self.viewModel.movies_data?.results?[indexPath.item]
            
            cell.movieImageView.image = UIImage(named: "placeholder.png")
            
            switch self.segmentedControl.selectedSegmentIndex {
            case 0: // movie
                if let poster_path = item?.poster_path {
                    cell.movieImageView.sd_setImage(with: URL(string: Constants.imageUrl + poster_path), placeholderImage: UIImage(named: "placeholder.png"))
                }
                break
            case 1: // person
                if let profile_path = item?.profile_path {
                    cell.movieImageView.sd_setImage(with: URL(string: Constants.imageUrl + profile_path!), placeholderImage: UIImage(named: "placeholder.png"))
                }
            default:
                break
            }
            return cell
        }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let items_count = 2
        let space = 30
        let spaces_total = space*items_count
        
        let width = (Int(self.collectionView.frame.size.width)-spaces_total)/items_count
        let height = Int(Double(width)/0.6)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.textColor = .white
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

