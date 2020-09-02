//
//  ViewController.swift
//  NewsApp1
//
//  Created by 藤田優作 on 2020/09/02.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import SegementSlide

class ViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                defaultSelectedIndex = 0
                reloadData()//SegementSlideDefaultViewControllerのメソッドでoverrideと書かれている全てが呼ばれる
    }
    
  
    
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFit
        headerView.image = UIImage(named: "header")
//        let headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        return headerView
    }

    override var titlesInSwitcher: [String] {
        return ["TOP", "TOPIC", "Science", "Entertainment","Sports","Local",]
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {

        switch index {
            case 0:
                return Page1ViewController()
            case 1:
                return Page2ViewController()
            case 2:
                return Page3ViewController()
            case 3:
                return Page4ViewController()
            case 4:
                return Page5ViewController()
            case 5:
                return Page6ViewController()
        default:
            return Page1ViewController()
        }

    }

}

