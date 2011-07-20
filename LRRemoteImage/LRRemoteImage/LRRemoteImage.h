//
//  LRRemoteImage.h
//  LRRemoteImage
//
//  Created by Luke Redpath on 01/07/2011.
//  Copyright 2011 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LRRemoteImageCompletionHandler)(UIImage *, NSError *);

@interface LRRemoteImage : NSObject {
  NSURL *URL;
  UIImage *image;
}
@property (nonatomic, readonly) UIImage *image;

#pragma mark -
#pragma mark Factory methods

+ (id)imageWithURL:(NSURL *)aURL;

#pragma mark -
#pragma mark Caching

+ (NSCache *)cache;

#pragma mark -
#pragma mark Initialization

- (id)initWithURL:(NSURL *)aURL;

#pragma mark -
#pragma mark Fetching Images

- (void)fetchWithQueue:(NSOperationQueue *)queue completionHandler:(LRRemoteImageCompletionHandler)handler;
@end

@interface UIImageView (LRRemoteImageLoading)
- (void)setRemoteImage:(LRRemoteImage *)remoteImage;
- (void)setRemoteImage:(LRRemoteImage *)remoteImage errorHandler:(void (^)(NSError *))errorHandler;
@end