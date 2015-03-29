[![Version](https://cocoapod-badges.herokuapp.com/v/DrawCircleFrame/badge.png)](http://cocoadocs.org/docsets/DrawCircleFrame) 
[![Platform](https://cocoapod-badges.herokuapp.com/p/DrawCircleFrame/badge.png)](http://cocoadocs.org/docsets/DrawCircleFrame) 
![License](https://img.shields.io/badge/license-Apache_2-green.svg?style=flat)

<p align="center" ><img src="https://raw.github.com/natalia-osa/DrawCircleFrame/master/ReadmeImages/Demo.gif" alt="DrawCircleFrame" title="DrawCircleFrame" height="240"></p>

Small project allowing to highlight given option via drawing a circle around it. 

## Customizable:
You can setup:
- line color
```objective-c
[_button.dcfView setLineColor:[UIColor blueColor]];
```
- animation duration
```objective-c
[_button.dcfView setAnimationDuration:4.f];
```
- drawing animated or not animated
```objective-c
[_button.dcfView drawBezierAnimated:YES];
```
- callback after drawing is finished
```objective-c
__weak __typeof(_button)weakButton = _button;
[_button.dcfView setCompletionBlock:^{
    [weakButton.dcfView setHidden:YES];
}];
```
- line width
```objective-c
[_button.dcfView setLineWidth:5.f];
```
- start position (supports all corners)
```objective-c
[_button.dcfView setStartPosition:DCFStartPositionBottomLeft];
```
- bezier approximation
I'm using UIBezierPath, which requires startPoint, endPoint and 2 middle points. After some calculation, it seems that the value supported by me (2.25f) is working great in most cases, and makes the drawing exactly around the text. However if you want the drawing to be bigger or smaller have fun with this value. You may also want to change margins then.
```objective-c
[_button.dcfView setBezierApproximation:2.5f];
```
- margin (extra space required to draw around your description)
```objective-c
[_button.dcfView setMarginValue:40.f];
```
- background color, hidden, alpha and everything connected with view parameters
```objective-c
[_button.dcfView setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.3f]];
```
<p align="center" ><img src="https://raw.github.com/natalia-osa/DrawCircleFrame/master/ReadmeImages/Fullscreen.png" alt="DrawCircleFrame img1" title="Main photo" height="284"></p>

## Installation:
#### Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries.
```ruby
pod "DrawCircleFrame"
```
#### Submodule
In your projects git folder type:
```bash
git submodule init
git submodule add --copy link to the repo--
git submodule update
```
Copy all files from DrawCircleFrame/DrawCircleFrame folder.
#### Just download & attach
This is strongly misadvised as you won't be able to see code updates. Clone or download the source, copy all files from DrawCircleFrame/DrawCircleFrame folder.

## Implementation:
Clone and see the demo for more examples about implementation. You can add the view via Storyboard or using code:
```objective-c
// in your view.h download the library
#import <DrawCircleFrame/NODCFButton.h>
#import <NOCategories/NSString+NOCSize.h>
// then add a property
@property (nonatomic) NODCFButton *button;

// alloc & init the view or setup this via storyboard
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[NODCFButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        [self addSubview:_button];
    }
    return self;
}

// in your controller you can change outlook of the control
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
	// setup all properties eg
    [_dcfExampleView.button.dcfView setLineColor:[UIColor greenColor]];
	// drawing happens after calling this method
    [_dcfExampleView.button.dcfView drawBezierAnimated:YES];
}
```
## Author

Natalia Osiecka, osiecka.n@gmail.com
- [Natalia Osiecka](https://github.com/natalia-osa/) ([@vivelee](https://twitter.com/vivelee))

## License

Available under the Apache 2.0 license. See the LICENSE file for more info.

## Requirements

Requires Xcode 5, targeting either iOS 5.1.1 or higher
