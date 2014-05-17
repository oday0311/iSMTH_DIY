//
//  HttpPicUploader.h
//  meizhou_client
//
//  Created by Alex on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <zlib.h>
@interface HttpPicUploader : NSObject {
    NSURL *serverURL;
    NSString *filePath;
    id delegate;
    SEL doneSelector;
    SEL errorSelector;
    
    BOOL uploadDidSucceed;
}

-(id)initWithURL: (NSURL *)serverURL 
           filePath: (NSString *)filePath 
           delegate: (id)delegate 
       doneSelector: (SEL)doneSelector 
      errorSelector: (SEL)errorSelector;

- (NSString *)filePath;
- (void)upload:(NSData*)uploadData;
@end

/*
 [[Uploader alloc] initWithURL:[NSURL [[URLWithString]]:@"http://my-server.com/uploader.php"
 filePath:@"/Users/someone/foo.jpg"
 delegate:self
 doneSelector:@selector(onUploadDone:)
 errorSelector:@selector(onUploadError:)];
*/