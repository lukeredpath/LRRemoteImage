//
//  LRRemoteImageAppDelegate.h
//  LRRemoteImage
//
//  Created by Luke Redpath on 01/07/2011.
//  Copyright 2011 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRRemoteImageViewController;

@interface LRRemoteImageAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LRRemoteImageViewController *viewController;

@end
