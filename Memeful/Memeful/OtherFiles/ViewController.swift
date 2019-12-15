//
//  ViewController.swift
//  Memeful
//
//  Created by LKB-L-105 on 12/12/19.
//

import UIKit

class ViewController: UIPageViewController {

    override func viewDidLoad() {
       self.dataSource = self
       let controller = createViewController()
       self.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
    
    func createViewController() -> UIViewController {
        var randomColor: UIColor {
            return UIColor(hue: CGFloat(arc4random_uniform(360))/360, saturation: 0.5, brightness: 0.8, alpha: 1)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = ProfileVC.init(nibName: "ProfileVC", bundle: nil)
        controller.view.backgroundColor = randomColor
        return controller
    }

}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let controller = createViewController()
        return controller
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let controller = createViewController()
        return controller
    }

}
