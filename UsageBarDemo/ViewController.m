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
@property (weak) IBOutlet MultiColorUsageBar *multiClrUsageBar;

@end

@implementation ViewController
@synthesize multiClrUsageBar;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    [multiClrUsageBar addUsageValue:4.0 categoryName:@"Music" color:[NSColor cyanColor]];
    [multiClrUsageBar addUsageValue:2.0 categoryName:@"Apps" color:[NSColor greenColor]];
    [multiClrUsageBar addUsageValue:3.0 categoryName:@"Videos" color:[NSColor orangeColor]];
    [multiClrUsageBar addUsageValue:1.0 categoryName:@"Free" color:[NSColor grayColor]];
    
    [multiClrUsageBar drawUsageBar];
    //[multiClrUsageBar setNeedsDisplay:YES];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
