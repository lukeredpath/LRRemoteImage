//
//  LRRemoteImage.m
//  LRRemoteImage
//
//  Created by Luke Redpath on 01/07/2011.
//  Copyright 2011 LJR Software Limited. All rights reserved.
//

#import "LRRemoteImage.h"

@implementation LRRemoteImage

@synthesize image;

+ (id)imageWithURL:(NSURL *)aURL
{
  return [[self alloc] initWithURL:aURL];
}

- (id)initWithURL:(NSURL *)aURL
{
  if ((self = [super init])) {
    URL = aURL;
  }
  return self;
}

- (void)fetchWithQueue:(NSOperationQueue *)queue completionHandler:(LRRemoteImageCompletionHandler)handler;
{
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];

  [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {    
    if (error) {
      handler(nil, error);
    } else {
      image = [UIImage imageWithData:data];
      handler(image, nil);
    }
  }];
}

@end

#pragma mark -

@implementation UIImageView (LRRemoteImageLoading)

- (void)setRemoteImage:(LRRemoteImage *)remoteImage
{
  if (remoteImage.image) {
    self.image = remoteImage.image;
  } else {
    [remoteImage fetchWithQueue:[NSOperationQueue mainQueue]
              completionHandler:^(UIImage *image, NSError *error) {
                self.image = image;
              }];
  }
}

@end