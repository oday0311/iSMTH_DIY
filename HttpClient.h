
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



-(void)httpBaiduShiTuImage:(NSString*)imageUrl;

-(void)setCookie:(NSString*)cookieString;
-(void)getCookie;

-(void)requestWithCookie;
- (id)initWithDelegate:(id<HttpClientDelegate>) delegate;

-(void)getDetailContentList:(NSString*)url;


-(void)getBtsmthContentList:(NSString*)url;

-(void)loginToSmth:(NSString*)accoutString withPassWordString:(NSString*)passString;

-(void)getAdConfigInformation;
@end


