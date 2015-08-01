//
//  BlurSlideToAction.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/15/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import Foundation

@objc(BlurSlideToAction) class BlurSlideToAction: ZCSSlideToActionView {
	
	var willActivateColor:UIColor = UIColor.greenColor()
	var willNotActivateColor:UIColor = UIColor.purpleColor()
	var labelText:String = "> Slide"
	var labelTextColor:UIColor = UIColor.whiteColor()
	var labelTextAlignment:NSTextAlignment = NSTextAlignment.Center
	var labelFontName:String = "HelveticaNeue-Thin"
	var labelFontSize:CGFloat = 55.0
	var maxBlurRadius:CGFloat = 10.0
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.blurredView = FXBlurView(frame: self.bounds)
		if let bv = self.blurredView {
			bv.dynamic = false
			bv.blurRadius = self.maxBlurRadius
			bv.contentMode = UIViewContentMode.Bottom
			bv.tintColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
			bv.underlyingView = self.superview!.superview!.subviews[0] as! UIImageView
			self.addSubview(bv)
		}
		println("self.superview: \((self.superview!.superview!.subviews[0] as! UIImageView).image!)")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if let bv = self.blurredView {
			bv.frame = self.bounds
			bv.underlyingView = self.superview!.superview!.subviews[0] as! UIImageView
			bv.updateAsynchronously(true, completion: { () -> Void in
				// code
			})
		}
	}
	
	override func renderPosition(percentagePosition: Double, animated:Bool) {
		if percentagePosition < 0 && self.preventSlideBack {
			return
		}
		let updateBlock = { (animated:Bool) -> () in
			if let bv = self.blurredView {
				bv.blurRadius = self.maxBlurRadius * CGFloat(0.7 - percentagePosition)
				self.hidden = self.willActivate
				bv.updateAsynchronously(true, completion: { () -> Void in
					println("blur now: \(bv.blurRadius)")
				})
			}
		}
		updateBlock(animated)
		if self.willActivate {
			// self.backgroundView?.backgroundColor = self.willActivateColor
		}
		else {
			// self.backgroundView!.backgroundColor = self.willNotActivateColor
		}
	}
	
	private
	
	var blurredView:FXBlurView? = nil
	
}
