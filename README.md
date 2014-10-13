ZCSSlideToAction
========================================
`ZCSSlideToAction` is a `UIView` subclass with a pan gesture recognizer. It replicates the interaction popularized by "Slide to Unlock" on the iOS lock screens. You can use it for any part of your applications where an action might warrant a confirmation dialog, but where such a dialog would be repeatitive.

## Installation ##
*Waiting for CocoaPods to support Swift projects.*

## Usage ##

**You always instantiate a sub-class of `ZCSSlideToAction`.** `ShimmerLabel` is the first one. I hope to release some more, and receive some submissions on Github.

### Interface Builder ###
Create a new UIView with a clear background (set background opacity to 0). Set its class to a sub-class of `ZCSSlideToAction`, like `ShimmerLabel`. **Ensure that you set the containing View Controller as the `ZCSSlideToAction` view's `delegate`.** Setup all the auto-layout constraints you want for the slider.

### In Your View Controller ###

1. Add `ZCSSlideToActionViewDelegate` to your View Controller.
2. Add `func slideToActionActivated() { ... }` to your View Controller. `slideToActionActivated` will be called if the user slides the slider past the activation point (default: 66%).

There are a view properties you can tweak like so:
```Swift
self.slideToActionView.activationPoint = 0.66
self.slideToActionView = true
```

Other delegate methods are available:

```Swift
@objc protocol ZCSSlideToActionViewDelegate {
	func slideToActionActivated()
	optional func slideToActionStarted()
	optional func slideToActionCancelled()
	optional func slideToActionReset()
}
```

## Sub-Classes Documentation ##

### ShimmerLabelSlideToAction ###
Requires [Shimmer](https://github.com/facebook/Shimmer).

Has these configurable property defaults:

```Swift
var willActivateColor:UIColor = UIColor.greenColor()
var willNotActivateColor:UIColor = UIColor.purpleColor()
var labelText:String = "> Slide to Action"
var labelTextColor:UIColor = UIColor.whiteColor()
var labelTextAlignment:NSTextAlignment = NSTextAlignment.Center
var labelFontName:String = "HelveticaNeue-Thin"
var labelFontSize:CGFloat = 55.0
```

![Example App with ShimmerLabelSlideToAction](/../screenshots/ShimmerLabelSlideToAction-preview.gif?raw=true "Example App with ShimmerLabelSlideToAction")

## Contributing ##
Send me Pull Requests here, please. Especially interested in new slider styles.