//
//  LRRemoteImageViewController.m
//  LRRemoteImage
//
//  Created by Luke Redpath on 01/07/2011.
//  Copyright 2011 LJR Software Limited. All rights reserved.
//

#import "LRRemoteImageViewController.h"
#import "LRRemoteImage.h"

#define kDEMO_IMAGE_URL @"http://paulstallard.files.wordpress.com/2008/11/tardis_2.jpg"

@implementation LRRemoteImageViewController

@synthesize imageView;

- (void)viewDidLoad
{
  LRRemoteImage *remoteImage = [LRRemoteImage imageWithURL:[NSURL URLWithString:kDEMO_IMAGE_URL]];
  [self.imageView setRemoteImage:remoteImage];
}

@end
