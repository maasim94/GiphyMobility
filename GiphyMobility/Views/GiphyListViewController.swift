//
//  GiphyListViewController.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//

import UIKit
import AVFoundation
class GiphyListViewController: UIViewController {
    // MARK: - properties
    fileprivate let segueIdentifier = "toFullScreenGIF"
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = GiphyListViewModel(dataFetcher: GiphyDataFetcher(url: Constant.giphyURL, network: Network()))
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerControllerWithCollectionView()
        self.title = viewModel.title
        viewModel.refreshCollectionData = {
            self.collectionView.reloadData()
        }
        viewModel.viewDidLoad((collectionView.collectionViewLayout as! GiphyGridLayout).columnWidth)
    }
    //MARK:- oriantion
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()

    }
    // MARK: - collecitonView init
    func registerControllerWithCollectionView() {
        collectionView.register(GiphyCollectionViewCell.self, forCellWithReuseIdentifier: GiphyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if let collectionViewLayout = collectionView.collectionViewLayout as? GiphyGridLayout {
            collectionViewLayout.delegate = self
        }
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier ==  segueIdentifier else { return  }
        // from previous sender and destination are sure, so force unwarping is safe
        let destination = segue.destination as! GiphyFullViewController
        let fullscreenViewModel = GiphyFullViewModel(imageSet: sender as! GiphyItem)
        destination.viewModel = fullscreenViewModel
    }

}
// MARK: - collectionview
extension GiphyListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCollectionViewCell.identifier, for: indexPath) as! GiphyCollectionViewCell
        let width = (collectionView.collectionViewLayout as! GiphyGridLayout).columnWidth
        if let imageSet = viewModel.getCurrentGifySet(for: indexPath.row, ofWidth: width) {
            cell.configureFor(imageSet: imageSet)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // only process if we have data
        self.performSegue(withIdentifier: segueIdentifier, sender: viewModel.getCurrentGiphyItem(for: indexPath.row))
    }
}
// MARK: - GiphyGridLayoutDelegate
extension GiphyListViewController: GiphyGridLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        guard let imageSet = viewModel.getCurrentGifySet(for: indexPath.row, ofWidth: withWidth) else {
            return 0
        }
        return AVMakeRect(aspectRatio: CGSize(width: imageSet.width, height: imageSet.height), insideRect: CGRect(x: 0.0, y: 0.0, width: withWidth, height: CGFloat.greatestFiniteMagnitude)).height

    }

}
// MARK: - UIScrollViewDelegate
extension GiphyListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.bounds.height + 100 >= scrollView.contentSize.height {
            viewModel.askForNextPage(withWidth: (collectionView.collectionViewLayout as! GiphyGridLayout).columnWidth)
        }
    }
}
