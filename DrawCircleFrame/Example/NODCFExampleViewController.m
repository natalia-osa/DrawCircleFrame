//
//  NODCFExampleViewController.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NODCFExampleViewController.h"
#import "NODCFExampleView.h"
#import <NOCategories/NSString+NOCSize.h>
#import <NOCategories/UIViewController+NOCViewInitializer.h>
#import "NODCFButton.h"

@interface NODCFExampleViewController ()

@property (nonatomic, weak, readonly) NODCFExampleView *aView;
@property (nonatomic, readonly) NODCFButton *button;
@property (nonatomic) NSTimer *timer;

@end

@implementation NODCFExampleViewController

#pragma mark - View lifecycle

- (void)loadView {
    _aView = [self noc_loadViewOfClass:[NODCFExampleView class]];
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
    _button = [[NODCFButton alloc] init];
    [self.button.dcfView setLineColor:[UIColor greenColor]];
    
    __weak __typeof(self.button)weakButton = self.button;
    [self.button.dcfView setCompletionBlock:^{
        [weakButton.dcfView setHidden:YES];
    }];
    
    [self.button setTitle:NSLocalizedString(@"Highlight me!", nil) forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    CGSize buttonSize = [_button.titleLabel.text noc_backwardCompatibleSizeWithFont:self.button.titleLabel.font constrainedToSize:CGSizeMake(200.f, 70.f)];
    self.button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    [self.navigationItem setLeftBarButtonItem:item];
}

@end
