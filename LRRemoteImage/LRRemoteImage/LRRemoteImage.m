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
    image = [[[self class] cache] imageForURL:URL];
  }
  return self;
}

+ (void)initialize
{
  [self setCache:[LRRemoteImageInMemoryCache sharedInMemoryCache]];
}

static id<LRRemoteImageCache> __strong _cache = nil;

+ (id<LRRemoteImageCache>)cache
{
  return _cache;
}

+ (void)setCache:(id<LRRemoteImageCache>)cache
{
  _cache = cache;
}

- (void)fetchWithQueue:(NSOperationQueue *)queue completionHandler:(LRRemoteImageCompletionHandler)handler;
{
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];

  [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {    
    if (error) {
      handler(nil, error);
    } else {
      image = [UIImage imageWithData:data];
      [[[self class] cache] cacheImage:image forURL:URL];
      handler(image, nil);
    }
  }];
}

@end

#pragma mark - Default caching implementation

@implementation LRRemoteImageInMemoryCache

+ (id)sharedInMemoryCache
{
  DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
    return [[self alloc] init];
  });
}

- (id)init {
  self = [super init];
  if (self) {
    cache = [[NSCache alloc] init];
    cache.name = @"co.uk.lukeredpath.LRRemoteImageInMemoryCache";
  }
  return self;
}

- (void)cacheImage:(UIImage *)image forURL:(NSURL *)url
{
  [cache setObject:image forKey:url];
}

- (UIImage *)imageForURL:(NSURL *)url
{
  return [cache objectForKey:url];
}

@end

#pragma mark - UIImageView category

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
