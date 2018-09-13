//
//  ViewController.swift
//  sideMenu
//
//  Created by Sherif  Wagih on 9/13/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let itemImage:UIImageView = {
        let menuImage = UIImageView()
        menuImage.image = UIImage(named: "nav_more_icon")
        menuImage.isUserInteractionEnabled = true
        menuImage.translatesAutoresizingMaskIntoConstraints = false
        return menuImage
    }()
    
    lazy var sideMenuLauncher:SideMenuLauncher = {
       let sideMenu = SideMenuLauncher()
        sideMenu.homeController = self
        return sideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    @objc func handleMenu()
    {
        sideMenuLauncher.handleMenu()
    }
    func setupViews(){
        view.backgroundColor = .red
        view.addSubview(itemImage)
        NSLayoutConstraint.activate([
                itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                itemImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
                itemImage.widthAnchor.constraint(equalToConstant: 40),
                itemImage.heightAnchor.constraint(equalToConstant: 40)
            ])
        itemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMenu)))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

