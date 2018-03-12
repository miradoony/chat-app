//
//  AvatarPickerVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 08/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var avatarType = AvatarType.dark
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate  = self
        collectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType )
            return cell
        }
        return AvatarCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        }else
        {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numCols : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numCols = 4
        }
        let spcBtwnCell : CGFloat = 10
        let padding  : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width-padding)-(numCols-1)*spcBtwnCell)/numCols
        return CGSize (width: cellDimension, height: cellDimension)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")}else{UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")}
        self.dismiss(animated: true, completion: nil)
    }
    
    
}