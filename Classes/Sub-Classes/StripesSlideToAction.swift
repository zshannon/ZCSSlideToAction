//
//  StripesSlideToAction.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/13/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import Foundation

@objc(StripesSlideToAction) class StripesSlideToAction: ZCSSlideToActionView {
	
	var willActivateColor:UIColor = UIColor.greenColor()
	var willNotActivateColor:UIColor = UIColor.purpleColor()
	var labelText:String = "> Slide"
	var labelTextColor:UIColor = UIColor.whiteColor()
	var labelTextAlignment:NSTextAlignment = NSTextAlignment.Center
	var labelFontName:String = "HelveticaNeue-Thin"
	var labelFontSize:CGFloat = 55.0
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.shimmeringContentView = FBShimmeringView(frame: self.bounds)
		if let v = self.shimmeringContentView {
			self.addSubview(v)
			let label = UILabel(frame: CGRectZero)
			label.setTranslatesAutoresizingMaskIntoConstraints(false)
			label.textAlignment = self.labelTextAlignment
			label.text = self.labelText
			label.textColor = self.labelTextColor
			label.adjustsFontSizeToFitWidth = true
			label.font = UIFont(name: self.labelFontName, size: self.labelFontSize)
			v.contentView = label
			v.shimmering = true
		}
		self.backgroundView = UIView(frame: self.bounds)
		if let v = self.backgroundView {
			v.backgroundColor = self.willNotActivateColor
			v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, 0.0, v.frame.height)
			self.insertSubview(v, atIndex: 0)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if let v = self.shimmeringContentView {
			v.shimmering = false
			v.shimmering = true
			v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, self.bounds.width, self.bounds.height)
			v.layoutSubviews()
		}
		if let v = self.backgroundView {
			v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, v.frame.width, self.bounds.height)
		}
	}
	
	override func renderPosition(percentagePosition: Double, animated:Bool) {
		if percentagePosition < 0 && self.preventSlideBack {
			return
		}
		let updateBlock = { (x:CGFloat) -> () in
			if let v = self.shimmeringContentView {
				v.frame = CGRectMake(x, v.frame.origin.y, v.frame.width, v.frame.height)
			}
			if let v = self.backgroundView {
				v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, x, v.frame.height)
			}
		}
		if animated {
			let duration:NSTimeInterval = 1.0
			let delay:NSTimeInterval = 0.0
			let options = UIViewAnimationOptions.CurveEaseIn
			let damping:CGFloat = 0.5
			let velocity:CGFloat = 1.0
			UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
				let x = self.frame.width * CGFloat(percentagePosition)
				updateBlock(x)
				}, completion: nil)
		}
		else {
			let x = self.frame.width * CGFloat(percentagePosition)
			updateBlock(x)
		}
		if self.willActivate {
			self.backgroundView?.backgroundColor = self.willActivateColor
		}
		else {
			self.backgroundView!.backgroundColor = self.willNotActivateColor
		}
	}
	
	private
	
	var shimmeringContentView:FBShimmeringView? = nil
	var backgroundView:UIView? = nil
	
}
