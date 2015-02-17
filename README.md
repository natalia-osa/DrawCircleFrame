
[![Version](https://cocoapod-badges.herokuapp.com/v/DrawCircleFrame/badge.png)](http://cocoadocs.org/docsets/DrawCircleFrame) 
[![Platform](https://cocoapod-badges.herokuapp.com/p/DrawCircleFrame/badge.png)](http://cocoadocs.org/docsets/DrawCircleFrame) 

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
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking).
```ruby
pod "DrawCircleFrame", "~> 1.0"
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
This is strongly disadvised as you won't be able to see code updates. Clone or download the source, copy all files from DrawCircleFrame/DrawCircleFrame folder.

## Implementation:
Clone and see the demo for more examples about implementation. You can add the view via Storyboard or using code:
```objective-c
// in your view.h download the library
#import <DrawCircleFrame/DCFButton.h>
#import <DrawCircleFrame/NSString+Size.h>
// then add a property
@property (nonatomic, strong) DCFButton *button;

// alloc & init the view or setup this via storyboard
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[DCFButton alloc] init];
        [self addSubview:_button];
    }
    return self;
}

// update the frame (or via storyboard)
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize buttonSize = [_button.titleLabel.text ios67sizeWithFont:_button.titleLabel.font constrainedToSize:CGSizeMake(300.f, 200.f)];
    CGRect buttonRect = CGRectMake(floorf((CGRectGetWidth(rect) - buttonSize.width) / 2.f), 
                                  floorf((CGRectGetHeight(rect) - buttonSize.height) / 2.f), 
                                  buttonSize.width, buttonSize.height);
	[_button setFrame:buttonRect];
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

Natalia Osiecka, natalia.osa@appunite.com
AppUnite.com

## License

Available under the Apache 2.0 license. See the LICENSE file for more info.

## Requirements

Requires Xcode 5, targeting either iOS 5.0 or higher
