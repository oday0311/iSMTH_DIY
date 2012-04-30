//
//  MyHttp_remoteClient.h
//  trueNameSimpler
//
//  Created by Alex on 9/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface MyHttp_remoteClient : NSObject
{
    NSString* pageSource;


    
}


- (NSString*) Simple_translate:(NSString*)translateString;
- (NSString*) httpSendRequest:(NSString*)translateString;
- (BOOL) testReachAblity;
-(NSString*) digest:(NSString*)input;

-(NSString*) httpSendSearchRequest:(NSString*)searchkey;
@end
