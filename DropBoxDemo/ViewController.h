//
//  ViewController.h
//  DropBoxDemo
//
//  Created by Anil Saini on 9/15/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <DropboxOSX/DropboxOSX.h>
#import <WebKit/WebKit.h>

@interface ViewController : NSViewController
{
    DBRestClient *restClient;
}

@end

