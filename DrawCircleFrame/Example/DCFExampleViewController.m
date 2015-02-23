//
//  DCFExampleViewController.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "DCFExampleViewController.h"
#import "DCFExampleView.h"
#import "NSString+Size.h"
#import "DCFButton.h"

@interface DCFExampleViewController ()

@property (nonatomic, weak, readonly) DCFExampleView *aView;
@property (nonatomic, readonly) DCFButton *button;
@property (nonatomic) NSTimer *timer;

@end

@implementation DCFExampleViewController

#pragma mark - View lifecycle

- (void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    DCFExampleView *view = [[DCFExampleView alloc] initWithFrame:rect];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    // local for easier access
    _aView = view;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(redrawFrame:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.timer && [self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - Custom methods

- (void)redrawFrame:(NSTimer *)timer {
    [self.button.dcfView setHidden:NO];
    [self.button.dcfView drawBezierAnimated:YES];
    [self.aView.button.dcfView drawBezierAnimated:YES];
}

- (void)setupNavigationItems {
    _button = [[DCFButton alloc] init];
    [self.button.dcfView setLineColor:[UIColor greenColor]];
    
    __weak __typeof(_button)weakButton = _button;
    [_button.dcfView setCompletionBlock:^{
        [weakButton.dcfView setHidden:YES];
    }];
    
    [self.button setTitle:NSLocalizedString(@"Highlight me!", nil) forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    CGSize buttonSize = [_button.titleLabel.text ios67sizeWithFont:_button.titleLabel.font constrainedToSize:CGSizeMake(200.f, 70.f)];
    self.button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    [self.navigationItem setLeftBarButtonItem:item];
}

@end
