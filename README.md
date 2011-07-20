# LRRemoteImage - really simple remote image handling

This class provides a very simple means of working with remote images.

Example usage:

    UIImageView *imageView = [self createImageView];
    
    LRRemoteImage *remoteImage = [LRRemoteImage imageWithURL:[NSURL URLWithString:@"http://www.example.com/someimage.jpg"]];
    
    imageView.image = remoteImage.image;

    if (imageView.image == nil) {
      [remoteImage fetchWithQueue:[NSOperationQueue mainQueue] completionHandler:^(UIImage *image, NSError *error) {
        imageView.image = image;
        
        if (error) {
          // handle error
        }
      }];
    }
    
All loaded images will be cached, using the URL as the cache key, using NSCache. This means that subsequent requests for the image after a fetchWithQueue:completionHandler: call will return the image, as will calls to a completely different LRRemoteImage instance for the same URL (the cache is shared across all LRRemoteImage instances).

Because NSCache is used, it will automatically be flushed in response to memory warnings.

## UIImageView category

The basic pattern above is encapsulated in a simple category on UIImageView. That means you can simply do the following:

    UIImageView *imageView = [self createImageView];
    
    LRRemoteImage *remoteImage = [LRRemoteImage imageWithURL:[NSURL URLWithString:@"http://www.example.com/someimage.jpg"]];
    
    [imageView setRemoteImage:remoteImage errorHandler:^(NSError *error) {
      // handle error
    }];
    
Or, if you aren't worried about errors:

    ...
    [imageView setRemoteImage:remoteImage];

## License

This code is licensed under the MIT license.

Copyright (c) 2011 Luke Redpath

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
