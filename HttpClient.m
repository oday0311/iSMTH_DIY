
#import "HttpClient.h"
#import "DataSingleton.h"
//#import "MZ_privateMessage.h"
//#import "MBProgressHUD+http.h"

@implementation HttpClient

@synthesize delegate=_delegate;


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (id)initWithDelegate:(id) delegate
{
    self = [super init];
    if (self) {
        self.delegate=delegate;
    }
    return self;
}

- (Boolean) checkinput:(NSString*) userSearchInput
{
    if (userSearchInput.length > 1) {
        return TRUE;
    }
    return FALSE;
    
}
- (BOOL) testReachAblity
{
    BOOL result = YES;
    //result = [Reachability testReachAblity];
    
    return result;
}



-(void)getDetailContentList:(NSString*)url
{
    
    NSLog(@"get detail content list url is %@", url);
    NSMutableDictionary *params;
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (CFStringRef)[self getURL:url queryParameters:nil],
                                                                                   NULL,
                                                                                   NULL,
                                                                                   kCFStringEncodingUTF8);
    
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSLog(@"%@",encodedString);
    [request setURL:[NSURL URLWithString:encodedString]];
    [request setHTTPMethod:@"GET"];
    
    NSString *contentType = [NSString stringWithFormat:@"text/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[[NSError alloc] init] autorelease
    ];
    
    
    
    
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        
        
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        
        NSString * responseString  = [[NSString alloc] initWithData:responseData encoding:enc];
        
        
        
        if(responseString!=nil) {
            NSLog(@"response:%@",responseString);
            if (1) {
                if (_delegate) {
                    
                    [_delegate performSelector:@selector(doSuccess:) withObject:responseString];
                }
            }else{
                if (_delegate) {
                    [_delegate performSelector:@selector(doFail:) withObject:nil];
                }
            }
            
        }else{
            if (_delegate) {
                [_delegate performSelector:@selector(doNetWorkFail)];
            }
            
        }

    }
    
        

}

-(void)getBtsmthContentList:(NSString*)url
{
    
    NSLog(@"get detail content list url is %@", url);
    NSMutableDictionary *params;
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (CFStringRef)[self getURL:url queryParameters:nil],
                                                                                   NULL,
                                                                                   NULL,
                                                                                   kCFStringEncodingUTF8);
    
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSLog(@"%@",encodedString);
    [request setURL:[NSURL URLWithString:encodedString]];
    [request setHTTPMethod:@"GET"];
    
    NSString *contentType = [NSString stringWithFormat:@"text/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[[NSError alloc] init] autorelease
                      ];
    
    
    
    
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        
        
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        
        NSString * responseString  = [[NSString alloc] initWithData:responseData encoding:enc];
        
        
        
        if(responseString!=nil) {
            NSLog(@"response:%@",responseString);
            if (1) {
                if (_delegate) {
                    
                    [_delegate performSelector:@selector(doSuccess:) withObject:responseString];
                }
            }else{
                if (_delegate) {
                    [_delegate performSelector:@selector(doFail:) withObject:nil];
                }
            }
            
        }else{
            if (_delegate) {
                [_delegate performSelector:@selector(doNetWorkFail)];
            }
            
        }
        
    }
    
    
    
}



@end
