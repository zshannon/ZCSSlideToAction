//
//  SubClassViewController.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/13/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import Foundation

class SubClassViewController: UIViewController, ZCSSlideToActionViewDelegate {
	
	var subClassObject:[String: String]? = nil
	@IBOutlet var backgroundImageView:UIImageView? = nil
	@IBOutlet var slideToActionView:ZCSSlideToActionView? = nil
	@IBOutlet var sildeToActionViewLabel:UILabel? = nil
	
	var resetLabel:UILabel? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let v = self.slideToActionView {
			let singleTapGestureRecognizer = UITapGestureRecognizer(target: v, action: "reset")
			v.addGestureRecognizer(singleTapGestureRecognizer)
		}
	}
	
	func setSubClassObject(object:[String: String]?) {
		self.subClassObject = object
		if let o = object {
			self.sildeToActionViewLabel?.text = o["Label"]
		}
		self.slideToActionView!.delegate = self
	}
	
	func slideToActionCancelled(sender:ZCSSlideToActionView) {
		self.backgroundImageView?.highlighted = false
	}
	
	func slideToActionActivated(sender:ZCSSlideToActionView) {
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
	
	func slideToActionReset(sender:ZCSSlideToActionView) {
		self.backgroundImageView?.highlighted = false
		self.resetLabel?.removeFromSuperview()
	}
}