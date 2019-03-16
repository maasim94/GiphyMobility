//
//  GifyFullViewController.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//

import UIKit
import FLAnimatedImage

class GiphyFullViewController: UIViewController {
    //MARK:- properties
    @IBOutlet weak var imageView: FLAnimatedImageView!
    var viewModel:GiphyFullViewModel?
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = "fullScreenGif"
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setImage(with: viewModel?.gifURL(forWidth: self.view.frame.width))
        self.title = viewModel?.title
    }
}
