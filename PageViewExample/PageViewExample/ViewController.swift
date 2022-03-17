//
//  ViewController.swift
//  PageViewExample
//
//  Created by Hyeon on 2022/03/11.
//

import UIKit

class ViewController: UIViewController {
    
    // 버튼 및 버튼들로 모아놓은 Array 생성
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    
    private var pageButtons = ["A", "B", "C", "D"]
    
    // 페이지 뷰 담을 UIView 생성
    @IBOutlet weak var containerView: UIView!
    
    var pageViews = [UIViewController]()
    private var currentPage: Int? = 0
    private var pendingIndex: Int? = 0
    
    // 페이지 생성
    private var page1: PageAViewController!
    private var page2: PageBViewController!
    private var page3: PageCViewController!
    private var page4: PageDViewController!

    // 페이지 정보 및 프로토콜 생성
    private var startOffset = CGFloat(0)
    private var pageViewController: UIPageViewController? {
        didSet{
            pageViewController?.dataSource = self
            pageViewController?.delegate = self
        }
    }
    
    private lazy var scrollView: UIScrollView? = {
        for subview in pageViewController?.view?.subviews ?? [] {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        organizePageViews()
        organizePageButtons()
    }
    
    @IBAction func btnATapped(_ sender: UIButton) {
        
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        pageButtons.firstIndex(of: sender.titleLabel?.text!)
        containerView.addSubview(<#T##view: UIView##UIView#>)
        
        
        
    }
    
    private func organizePageViews() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        page1 = (storyboard.instantiateViewController(withIdentifier: "PageA") as! PageAViewController)
        page2 = (storyboard.instantiateViewController(withIdentifier: "PageB") as! PageBViewController)
        page3 = (storyboard.instantiateViewController(withIdentifier: "PageC") as! PageCViewController)
        page4 = (storyboard.instantiateViewController(withIdentifier: "PageD") as! PageDViewController)
        
        pageViews.append(page1)
        pageViews.append(page2)
        pageViews.append(page3)
        pageViews.append(page4)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController!.setViewControllers([page1], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        containerView.addSubview(pageViewController!.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func organizePageButtons() {
        pageButtons.append(btnA)
        pageButtons.append(btnB)
        pageButtons.append(btnC)
        pageButtons.append(btnD)
    }

}


extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViews.firstIndex(of: viewController) else { return nil }
        var previousIndex = viewControllerIndex - 1
        
        if previousIndex == -1 {
            previousIndex += 1
            print("before - if: \(pageViews[previousIndex].title)")
            return nil
        } else {
            print("before - else: \(pageViews[previousIndex].title)")
            return pageViews[previousIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViews.firstIndex(of: viewController) else { return nil }
        var nextIndex = viewControllerIndex + 1
        
        if nextIndex == pageViews.count {
            nextIndex -= 1
            print("next - if: \(pageViews[nextIndex].title)")
            return nil
        } else {
            print("next - else: \(pageViews[nextIndex].title)")
            return pageViews[nextIndex]
        }
    }
}

