
#import <Foundation/Foundation.h>



static NSString *BASE_URL=@"";

@interface HttpConnection : NSObject {
}


- (NSString *) getMethodUrl:(NSString *)relativeUrl
                     params:(NSMutableDictionary *)params;

- (NSString *) postMethodUrl:(NSString *)url
                      params:(NSMutableDictionary *)params;

-(NSString *) getURL:(NSString *)url queryParameters:(NSMutableDictionary *)params;
-(NSString *)paramsFromDictionary:(NSMutableDictionary *)params;
@end
