//
//  ViewController.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/10/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet var scrollView:UIScrollView? = nil
	@IBOutlet var pageControl:UIPageControl? = nil
	let contentList = [
//		["Label": "Stripes", "Class": "StripesSlideToAction", "Background": "bg", "Background-Action": "bg-highlighted"],
//		["Label": "Blur", "Class": "BlurSlideToAction", "Background": "stripes", "Background-Action": "bg-highlighted"],
		["Label": "Shimmer Label", "Class": "ShimmerLabelSlideToAction", "Background": "bg", "Background-Action": "bg-highlighted"]
	]
	var viewControllers:[SubClassViewController]? = nil

	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewControllers = []
		let numberOfPages = self.contentList.count
		
		// a page is the width of the scroll view
		if let sv = self.scrollView {
			sv.pagingEnabled = true
			sv.contentSize = CGSizeMake(CGRectGetWidth(sv.frame) * CGFloat(numberOfPages), CGRectGetHeight(sv.frame))
			sv.showsHorizontalScrollIndicator = false
			sv.showsVerticalScrollIndicator = false
			sv.scrollsToTop = false
			sv.delegate = self
		}
		if let pc = self.pageControl {
			pc.numberOfPages = numberOfPages
			pc.currentPage = 0
		}
		
		self.loadScrollViewWithPage(0)
		self.loadScrollViewWithPage(1)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		if let sv = self.scrollView {
			let numberOfPages = self.contentList.count
			sv.contentSize = CGSizeMake(CGRectGetWidth(view.frame) * CGFloat(numberOfPages), CGRectGetHeight(view.frame))
		}
		var i = 0
		for vc in self.viewControllers! {
			vc.view.frame = CGRectMake(CGFloat(CGFloat(i) * view.frame.width), 0, self.scrollView!.frame.width, self.scrollView!.frame.height)
			vc.view.layoutSubviews()
			i++
		}
	}
	
	func loadScrollViewWithPage(page:Int) {
		if page >= self.contentList.count || page < 0 {
			return
		}
		
		var controller:SubClassViewController? = nil
		if self.viewControllers!.count - 1 >= page {
			if let c = self.viewControllers![page] as SubClassViewController? {
				controller = c
			}
		}
		if controller == nil {
			controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SubClassViewController") as? SubClassViewController
			self.viewControllers!.insert(controller!, atIndex: page)
		}
		
		// add the controller's view to the scroll view
		if controller!.view.superview == nil {
			var frame = self.scrollView!.frame
			frame.origin.x = CGRectGetWidth(frame) * CGFloat(page)
			frame.origin.y = 0
			controller!.view.frame = frame
			self.addChildViewController(controller!)
			self.scrollView?.addSubview(controller!.view)
			controller!.didMoveToParentViewController(self)
			controller!.subClassObject = self.contentList[page] as [String: String]
		}
	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		// switch the indicator when more than 50% of the previous/next page is visible
		let pageWidth = CGRectGetWidth(self.view.frame)
		let page = Int(floor((self.scrollView!.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
		self.pageControl!.currentPage = page
		self.loadScrollViewWithPage(page - 1)
		self.loadScrollViewWithPage(page)
		self.loadScrollViewWithPage(page + 1)
	}
	
	func gotoPage(animated: Bool) {
		let page = self.pageControl!.currentPage
		self.loadScrollViewWithPage(page - 1)
		self.loadScrollViewWithPage(page)
		self.loadScrollViewWithPage(page + 1)
		var bounds = self.scrollView!.bounds
		bounds.origin.x = CGRectGetWidth(bounds) * CGFloat(page)
		bounds.origin.y = 0
		self.scrollView!.scrollRectToVisible(bounds, animated: animated)
	}
	
	@IBAction func pageChanged(sender:UIPageControl) {
		self.gotoPage(true)
	}

}

