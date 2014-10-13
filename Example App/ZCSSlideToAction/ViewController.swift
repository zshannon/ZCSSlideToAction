//
//  ViewController.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/10/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZCSSlideToActionViewDelegate {

	@IBOutlet var backgroundImageView:UIImageView? = nil
	@IBOutlet var slideToActionView:ZCSSlideToActionView? = nil
	var resetLabel:UILabel? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		if let v = self.slideToActionView {
			let singleTapGestureRecognizer = UITapGestureRecognizer(target: v, action: "reset")
			v.addGestureRecognizer(singleTapGestureRecognizer)
		}
	}
	
	func slideToActionCancelled() {
		self.backgroundImageView?.highlighted = false
	}
	
	func slideToActionActivated() {
		self.backgroundImageView?.highlighted = true
		if let v = self.slideToActionView {
			self.resetLabel = UILabel(frame: v.bounds)
			self.resetLabel?.text = "Tap to Reset"
			self.resetLabel?.textColor = UIColor.whiteColor()
			self.resetLabel?.textAlignment = NSTextAlignment.Center
			self.resetLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
			self.resetLabel?.alpha = 0.0
			v.addSubview(self.resetLabel!)
			UIView.animateWithDuration(1.0, animations: {
				self.resetLabel!.alpha = 1.0
			})
		}
		
	}
	
	func slideToActionReset() {
		self.backgroundImageView?.highlighted = false
		self.resetLabel?.removeFromSuperview()
	}

}

