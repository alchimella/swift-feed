//
//  FeedViewController.swift
//  swift-feed
//
//  Created by Abi  Radzhabova on 20/10/21.
//

import UIKit
import VKSdkFramework

class FeedViewController: UIViewController {
    
    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { item in
                print("READY FOR WORK", item.date)
            }
        }
    }


}

