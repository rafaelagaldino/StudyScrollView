//
//  ManagePageViewController.swift
//  StudyScrollView
//
//  Created by Rafaela Galdino on 17/12/19.
//  Copyright © 2019 Rafaela Galdino. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = viewPhotoCommentController(currentIndex)
        let viewControllers = [viewController]
            
        setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        
        dataSource = self
    }
    
    func viewPhotoCommentController(_ index: Int) -> PhotoCommentViewController {
        let page = storyboard?.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController
        page?.photoName = photos[index]
        page?.photoIndex = index
        return page!
    }
}

extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex, index > 0 {
            return viewPhotoCommentController(index - 1)
        }
        return nil
    }
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex, (index + 1) < photos.count {
            return viewPhotoCommentController(index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count // Especifica o número de páginas a serem exibidas
    }
      
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }

}

