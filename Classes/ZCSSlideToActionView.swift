//
//  ZCSSlideToActionView.swift
//  ZCSSlideToAction
//
//  Created by Zane Shannon on 10/10/14.
//  Copyright (c) 2014 Zane Shannon. All rights reserved.
//

import Foundation

@objc protocol ZCSSlideToActionViewDelegate {
	func slideToActionActivated(sender:ZCSSlideToActionView)
	optional func slideToActionStarted(sender:ZCSSlideToActionView)
	optional func slideToActionCancelled(sender:ZCSSlideToActionView)
	optional func slideToActionReset(sender:ZCSSlideToActionView)
}

@objc protocol SliderProtocol {
	func renderPosition(percentagePosition:Double, animated:Bool)
}

class ZCSSlideToActionView: UIView, SliderProtocol {
	
	@IBOutlet weak var delegate:ZCSSlideToActionViewDelegate? = nil
	var activationPoint:Double = 0.66
	var preventSlideBack:Bool = true
	
	override func awakeFromNib() {
		self.clipsToBounds = true
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
		self.addGestureRecognizer(panGestureRecognizer)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		// self.bounds = self.superview!.bounds
	}
	
	func reset() {
		self.willActivate = false
		self.renderPosition(0.0, animated: true)
		if let d = self.delegate {
			if let f = d.slideToActionReset {
				f(self)
			}
		}
	}
	
	func renderPosition(percentagePosition:Double, animated:Bool) {
		println("Subclass must override renderPosition!")
		abort()
	}
	
	internal
	var willActivate:Bool = false
	
	func handlePanGesture(recognizer: UIGestureRecognizer) {
		if (recognizer.state == UIGestureRecognizerState.Began) {
			let percentagePosition = Double((recognizer as UIPanGestureRecognizer).translationInView(self).x) / Double(self.frame.width)
			self.willActivate = percentagePosition >= self.activationPoint
			self.renderPosition(percentagePosition, animated: false)
			if let d = self.delegate {
				if let f = d.slideToActionStarted {
					f(self)
				}
			}
		}
		else if (recognizer.state == UIGestureRecognizerState.Ended ||
			recognizer.state == UIGestureRecognizerState.Cancelled ||
			recognizer.state == UIGestureRecognizerState.Failed) {
			let percentagePosition = Double((recognizer as UIPanGestureRecognizer).translationInView(self).x) / Double(self.frame.width)
			self.willActivate = percentagePosition >= self.activationPoint
			if self.willActivate {
				self.renderPosition(1.0, animated: true)
			}
			else {
				self.renderPosition(0.0, animated: true)
			}
			if let d = self.delegate {
				if self.willActivate {
					d.slideToActionActivated(self)
				}
				else {
					if let f = d.slideToActionCancelled {
						f(self)
					}
				}
			}
		}
		else if (recognizer.state == UIGestureRecognizerState.Changed) {
			let percentagePosition = Double((recognizer as UIPanGestureRecognizer).translationInView(self).x) / Double(self.frame.width)
			self.willActivate = percentagePosition >= self.activationPoint
			self.renderPosition(percentagePosition, animated: false)
		}
	}
	
}