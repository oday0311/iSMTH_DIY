
#import <Foundation/Foundation.h>
#import "DataSingleton.h"
#import "JSONKit.h"
#import "constant.h"
#import "HttpConnection.h"
#import "HttpClientDelegate.h"


@interface HttpClient : HttpConnection <HttpClientDelegate>
{
    NSString* pageSource;

    
    id<HttpClientDelegate>  _delegate;

}

@property (nonatomic,retain) id<HttpClientDelegate> delegate;

- (id)initWithDelegate:(id<HttpClientDelegate>) delegate;

-(void)getDetailContentList:(NSString*)url;




@end


