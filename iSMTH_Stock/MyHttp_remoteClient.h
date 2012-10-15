

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
