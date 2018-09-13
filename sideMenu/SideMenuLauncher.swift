//
//  SideMenuLauncher.swift
//  sideMenu
//
//  Created by Sherif  Wagih on 9/13/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class SideMenuLauncher: NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var homeController:ViewController?
    
    let cellId = "sideMenuCellId"
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cView.backgroundColor = .white
       return cView
    }()
    let blackBGView : UIView = {
       let shadowView = UIView()
       shadowView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return shadowView
    }()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SideMenuCell
        cell.iconImageView.image = UIImage(named: iconsNames[indexPath.item])
        cell.titleLabel.text = iconsTitles[indexPath.item]
        return cell
    }
    
    override init()
    {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SideMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func handleMenu()
    {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(blackBGView)
        blackBGView.frame = (window?.frame)!
        blackBGView.alpha = 0
        blackBGView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        window?.addSubview(collectionView)
        let width = (window?.frame.width)! - 100
        collectionView.frame = CGRect(x: -width, y: 0, width: width, height: (window?.frame.height)!)
        UIView.animate(withDuration: 0.4) {
            self.collectionView.frame = CGRect(x: 0, y: 0, width: width, height: (window?.frame.height)!)
            self.blackBGView.alpha = 1
        }
    }
    @objc func handleDismiss()
    {
        UIView.animate(withDuration: 0.67, animations: {
            let window = UIApplication.shared.keyWindow

            let width = (window?.frame.width)! - 100

            self.collectionView.frame = CGRect(x: -width, y: 0, width: width, height: (window?.frame.height)!)

            self.blackBGView.alpha = 0
            
        }) { (completed) in
            self.blackBGView.removeFromSuperview()
            self.collectionView.removeFromSuperview()
        }
    }
    let iconsTitles = ["Setting","Terms & privacy policy","Send Feedback"]
    let iconsNames = ["settings","privacy","feedback"]
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30, 0, 0, 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
class SideMenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            iconImageView.widthAnchor.constraint(equalToConstant:40)
            ])
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
       // imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabel:UILabel = {
       let label = UILabel()
       // label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
}
