//
//  ViewController.swift
//  BF_Test
//
//  Created by mino on 2022/07/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var desc: UITextView?
    
    var dataSource: [String]? {
        willSet {
            guard let screen = newValue, screen.count > 0 else {
                return
            }
            
            collectionView.setContentOffset(CGPoint.zero, animated: true)
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        Home.loadHome {
            if let lists = $0, let first = lists.first {
                self.dataSource = first.screenshotUrls
                self.desc?.text = first.description
            }
        }
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homescreenshotcell", for: indexPath) as? HomeScreenShotCell, let datas = dataSource else {
            return UICollectionViewCell()
        }
        
        if let url = URL(string: datas[indexPath.item]) {
            cell.screen?.setImage(url: url)
        }
        
        return cell
    }
    
}

class HomeScreenShotCell: UICollectionViewCell {
    @IBOutlet var screen: UIImageView?
}

