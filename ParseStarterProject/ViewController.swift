/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController!
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        println("current b index is \(index)")
        if index == 0 || index == NSNotFound {
            println("alalano \(index)")
            return nil
        }
        
        index--
        
        println("index beforeeeeeeeeeee is \(index)")
        return self.viewControllerAtIndex(index)
    
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        println("current a index is \(index)")
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == 3{
            return nil
        }
        println("the index after is \(index)" )
        
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func viewControllerAtIndex(index: Int) -> ContentViewController{
        
        if index >= 3 {
            println("lalalano")
            return ContentViewController()
        }
        
        var tourScreen : ContentViewController = ContentViewController()
        switch index{
            case 0:
               tourScreen = self.storyboard?.instantiateViewControllerWithIdentifier("TourScreenOne") as! ContentViewController
            
        
            case 1:
                tourScreen = self.storyboard?.instantiateViewControllerWithIdentifier("TourScreenTwo") as! ContentViewController
            
        
            case 2:
                tourScreen = self.storyboard?.instantiateViewControllerWithIdentifier("TourScreenThree") as! ContentViewController
            
            default:
                break
        
        }
        println("lalalayes")
        tourScreen.pageIndex = index
        return tourScreen
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as ContentViewController
        
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [ContentViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0,0,self.view.frame.width, self.view.frame.size.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
