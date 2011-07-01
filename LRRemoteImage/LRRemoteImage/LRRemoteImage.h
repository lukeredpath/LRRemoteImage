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

+ (id)imageWithURL:(NSURL *)aURL;
- (id)initWithURL:(NSURL *)aURL;
- (void)fetchWithQueue:(NSOperationQueue *)queue completionHandler:(LRRemoteImageCompletionHandler)handler;
@end

@interface UIImageView (LRRemoteImageLoading)
- (void)setRemoteImage:(LRRemoteImage *)remoteImage;
@end