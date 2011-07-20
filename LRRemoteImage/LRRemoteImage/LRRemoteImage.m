//
//  LRRemoteImage.m
//  LRRemoteImage
//
//  Created by Luke Redpath on 01/07/2011.
//  Copyright 2011 LJR Software Limited. All rights reserved.
//

#import "LRRemoteImage.h"
#import "LRMacros.h"

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
    image = [[[self class] cache] objectForKey:URL];
  }
  return self;
}

+ (NSCache *)cache
{
  DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
    NSCache *cache = [[NSCache alloc] init];
    cache.name = @"co.uk.lukeredpath.LRRemoteImage";
    return cache;
  });
}

- (void)fetchWithQueue:(NSOperationQueue *)queue completionHandler:(LRRemoteImageCompletionHandler)handler;
{
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];

  [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {    
    if (error) {
      handler(nil, error);
    } else {
      image = [UIImage imageWithData:data];
      [[[self class] cache] setObject:image forKey:URL];
      handler(image, nil);
    }
  }];
}

@end

#pragma mark -

@implementation UIImageView (LRRemoteImageLoading)

- (void)setRemoteImage:(LRRemoteImage *)remoteImage errorHandler:(void (^)(NSError *))errorHandler
{
  if (remoteImage.image) {
    self.image = remoteImage.image;
  } else {
    [remoteImage fetchWithQueue:[NSOperationQueue mainQueue]
              completionHandler:^(UIImage *image, NSError *error) {
                self.image = image;
                
                if (error && errorHandler) {
                  errorHandler(error);
                }
              }];
  }
}
                                                                  
- (void)setRemoteImage:(LRRemoteImage *)remoteImage
{
  [self setRemoteImage:remoteImage errorHandler:nil];
}

@end
