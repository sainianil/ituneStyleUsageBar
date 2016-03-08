//
//  ViewController.m
//  UsageBarDemo
//
//  Created by Anil Saini on 9/8/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "ViewController.h"
#import <UsageBar/UsageBar.h>

@interface ViewController()

//In IB set UIView class to MultiColorUsageBar and create a IBOutlet
@property (weak) IBOutlet MultiColorUsageBar *multiClrUsageBar;

@end

@implementation ViewController
@synthesize multiClrUsageBar;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    //add category to be displayed in the storage bar
    [multiClrUsageBar addUsageValue:4.0 categoryName:@"Music" color:[NSColor cyanColor]];
    [multiClrUsageBar addUsageValue:6.0 categoryName:@"Apps" color:[NSColor greenColor]];
    [multiClrUsageBar addUsageValue:3.0 categoryName:@"Videos" color:[NSColor orangeColor]];
    [multiClrUsageBar addUsageValue:2.0 categoryName:@"Free" color:[NSColor grayColor]];
    
    //Draw usage bar
    [multiClrUsageBar drawUsageBar];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
