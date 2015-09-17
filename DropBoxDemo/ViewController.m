//
//  ViewController.m
//  DropBoxDemo
//
//  Created by Anil Saini on 9/15/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "ViewController.h"

#import <UsageBar/UsageBar.h>

@interface ViewController()  <DBRestClientDelegate>


- (void)updateLinkButton;
- (DBRestClient *)restClient;
@property (weak) IBOutlet NSTextField *userID;
@property (weak) IBOutlet NSTextField *displayName;
@property (weak) IBOutlet NSTextField *emailID;
@property (weak) IBOutlet MultiColorUsageBar *storageBar;
@property (assign) IBOutlet NSButton *linkButton;
@property (nonatomic, retain) NSString *requestToken;
@end

@implementation ViewController
@synthesize linkButton = _linkButton;
@synthesize requestToken;
@synthesize userID;
@synthesize displayName;
@synthesize emailID;
@synthesize storageBar;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    NSString *appKey = @"APP_KEY";
    NSString *appSecret = @"APP_SECRET";
    NSString *root = kDBRootAppFolder;
    DBSession *session = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
    [DBSession setSharedSession:session];
    
    NSDictionary *plist = [[NSBundle mainBundle] infoDictionary];
    NSString *actualScheme = [[[[plist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
    NSString *desiredScheme = [NSString stringWithFormat:@"db-%@", appKey];
    NSString *alertText = nil;
    if ([appKey isEqual:@"APP_KEY"] || [appSecret isEqual:@"APP_SECRET"] || root == nil) {
        alertText = @"Please assign appKey, appSecret, and root in AppDelegate.m to use this app";
    } else if (![actualScheme isEqual:desiredScheme]) {
        alertText = [NSString stringWithFormat:@"Set the url scheme in the app plist to %@ for the OAuth authorize page to work correctly", desiredScheme];
    }
    
    if (alertText) {
        
        NSAlert *alert = [NSAlert alertWithError:[NSError errorWithDomain:@"No Key" code:0 userInfo:nil]];
        [alert setInformativeText:alertText];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            NSLog(alertText);
        }];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authHelperStateChangedNotification:) name:DBAuthHelperOSXStateChangedNotification object:[DBAuthHelperOSX sharedHelper]];
    [self updateLinkButton];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)didPressLinkDropbox:(id)sender {
    if ([[DBSession sharedSession] isLinked]) {
        // The link button turns into an unlink button when you're linked
        [[DBSession sharedSession] unlinkAll];
        restClient = nil;
        [self updateLinkButton];
    } else {
        [[DBAuthHelperOSX sharedHelper] authenticate];
    }
}

#pragma mark DBRestClientDelegate

- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info
{
    self.userID.stringValue = info.userId;
    self.emailID.stringValue = info.email;
    self.displayName.stringValue = info.displayName;
    float convertBytesToGB = 1024.0*1024.0*1024.0;
    double total = info.quota.totalBytes/convertBytesToGB;
    float consumed = (info.quota.normalConsumedBytes/convertBytesToGB);
    float shared = (info.quota.sharedConsumedBytes/convertBytesToGB);
    float free = (total - (consumed + shared));
    [storageBar addUsageValue:consumed categoryName:@"Used space" color:[NSColor orangeColor]];
    [storageBar addUsageValue:shared categoryName:@"Shared space" color:[NSColor greenColor]];
    [storageBar addUsageValue:free categoryName:@"Free" color:[NSColor lightGrayColor]];
    [storageBar drawUsageBar];
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", error);
}

#pragma mark private methods

- (void)authHelperStateChangedNotification:(NSNotification *)notification {
    [self updateLinkButton];
    if ([[DBSession sharedSession] isLinked])
    {
        
    }
}

- (void)updateLinkButton {
    if ([[DBSession sharedSession] isLinked]) {
        self.linkButton.title = @"Unlink Dropbox";
        [self.restClient loadAccountInfo];
    } else {
        self.linkButton.title = @"Link Dropbox";
        [self resetData];
        self.linkButton.state = [[DBAuthHelperOSX sharedHelper] isLoading] ? NSOffState : NSOnState;
    }
}

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

- (void)resetData
{
    self.userID.stringValue = @"-";
    self.emailID.stringValue = @"-";
    self.displayName.stringValue = @"-";
    [storageBar addUsageValue:0.0 categoryName:@"Empty" color:[NSColor lightGrayColor]];
    [storageBar drawUsageBar];
}

@end
