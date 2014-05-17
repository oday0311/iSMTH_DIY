
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
-(void)requestWithCookie
{
    if ([DataSingleton singleton].IsCookieSetted)
    {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    
        
        NSArray *myKeys = [[DataSingleton singleton].cookieDictionary allKeys];
        for (int i = 0;i<myKeys.count; i++) {
            NSString* keystring = [myKeys objectAtIndex:i];
            NSString* valueString = [[DataSingleton singleton].cookieDictionary valueForKey:keystring];
            [cookieProperties setObject:valueString forKey:keystring];
        }
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    }
    
    NSString*url = @"http://www.newsmth.net/nForum/#!board/NewExpress";
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
-(void)loginToSmth:(NSString*)accoutString withPassWordString:(NSString*)passString
{
    //NSString* relativeUrl = @"http://www.newsmth.net/nForum/user/ajax_login.json";
    NSString* relativeUrl = @"http://www.newsmth.net/bbslogin.php";
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    if (1) {
       
        [params setObject:@"theindex" forKey:@"id"];
        [params setObject:@"123456" forKey:@"password"];
        [params setObject:@"123456" forKey:@"passwd"];
        
        [params setObject:accoutString forKey:@"id"];
        [params setObject:passString forKey:@"password"];
        [params setObject:passString forKey:@"passwd"];
        
        
        
        [params setObject:@"0" forKey:@"mode"];
        [params setObject:@"0" forKey:@"CookieDate"];
    }
//    {
//        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//        
//        [cookieProperties setObject:@"1351232302695,1351235535924" forKey:@"Hm_lvt_9c7f4d9b7c00cb5aba2c637c64a41567"];
//        [cookieProperties setObject:@"1351235535924" forKey:@"Hm_lpvt_9c7f4d9b7c00cb5aba2c637c64a41567"];
//        [cookieProperties setObject:@"guest" forKey:@"main[UTMPUSERID]"];
//        [cookieProperties setObject:@"18485232" forKey:@"main[UTMPKEY]"];
//        [cookieProperties setObject:@"1958" forKey:@"main[UTMPNUM]"];
//        
//        [cookieProperties setObject:@"oday0311" forKey:NSHTTPCookieName];
//        [cookieProperties setObject:@"oday" forKey:NSHTTPCookieValue];
//        [cookieProperties setObject:@"newsmth.com" forKey:NSHTTPCookieDomain];
//        [cookieProperties setObject:@"newsmth.com" forKey:NSHTTPCookieOriginURL];
//        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//        
//        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    }
    NSURL *url=[NSURL URLWithString:relativeUrl];
    NSString *postString=[self paramsFromDictionary:params];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [postString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData* data =  [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response error:&error];
    NSLog(@"response status code is :%d",[response statusCode]);


    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [DataSingleton singleton].IsCookieSetted = 1;
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        
        NSString* nameString =cookie.name;
        NSString* valueString =cookie.value;
        
        [[DataSingleton singleton].cookieDictionary setValue:valueString forKey:nameString];
        
        NSLog(@"%@", cookie);
    }
    
    NSString* jsonString = [[DataSingleton singleton].cookieDictionary JSONString];
    [DataSingleton singleton].cookieJsonString = (NSMutableString*)jsonString;
   
    if([response statusCode] >= 200 && [response statusCode] <300){
        
        
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        
        NSString * responseString  = [[NSString alloc] initWithData:data encoding:enc];

        NSMutableDictionary* resultDict = [[NSMutableDictionary alloc] init];
        [resultDict setValue:responseString forKey:@"data"];
        [resultDict setValue:@"login" forKey:@"action"];
        
        if(responseString!=nil) {
            NSLog(@"response:%@",responseString);
            if (1) {
                if (_delegate) {
                    
                    [_delegate performSelector:@selector(doSuccess:) withObject:resultDict];
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


-(void)getAdConfigInformation
{
    
    
    NSString* tempString = [@"" stringByAppendingFormat:@"http://easynote.sinaapp.com/ismth/ad_config.php"];
    
    
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (CFStringRef)tempString,
                                                                                   NULL,
                                                                                   NULL,
                                                                                   kCFStringEncodingUTF8);
    
    
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSLog(@"%@",encodedString);
    
    
    
    
    
    
    [request setURL:[NSURL URLWithString:encodedString]];
    [request setHTTPMethod:@"GET"];
    
    [encodedString release];
    NSString *contentType = [NSString stringWithFormat:@"text/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init] ;
    
    
    
    
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    NSString * responseString;
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        responseString = [[NSString alloc] initWithData:responseData encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        NSDictionary *resultsDictionary = (NSDictionary *)[responseString objectFromJSONString];
        if([@"1" isEqualToString:(NSString *)[resultsDictionary valueForKey:@"ad_open"] ])
        {
            [DataSingleton singleton].ad_config_open = 1;
            [DataSingleton singleton].adImageUrl = [resultsDictionary valueForKey:@"ad_imageurl"];
            [DataSingleton singleton].linkUrl = [resultsDictionary valueForKey:@"ad_linkAddress"];
            NSLog(@"the result is :%@........%@",[DataSingleton singleton].adImageUrl, [DataSingleton singleton].linkUrl);
            
        }
        else
        {
            
        }
        
        [_delegate performSelector:@selector(doSuccess:) withObject:resultsDictionary];
        
    }else
    {
        responseString = @"response error";
        [_delegate performSelector:@selector(doFail:) withObject:responseString];
    }
    
    
    if(responseString!=nil){
        //NSLog(@"response:%@",responseString);
    }
}


-(void)httpBaiduShiTuImage:(NSString*)imageUrl
{
    ////http://shitu.baidu.com/i?objurl=http%3A%2F%2Feasynote-easynotedomain.stor.sinaapp.com%2F2013-03-22-22-42-13.jpg&filename=&rt=0&rn=10&ftn=searchstu&ct=1&stt=0&tn=baiduimage
    
    NSString* url = @"http://shitu.baidu.com/i?objurl=";
    
    NSString* otherParams = @"&rt=0&rn=10&ftn=searchstu&ct=1&stt=0&tn=baiduimage";
    
    url = [url stringByAppendingString:imageUrl];
    url = [url stringByAppendingString:otherParams];
    
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

-(void)setCookie:(NSString*)cookieString
{
    NSString* url = @"http://easynote.sinaapp.com/ismth/setCookie.php?cookie=";
    
    url = [url stringByAppendingString:cookieString];
    
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
-(void)getCookie
{
    NSString* url = @"http://easynote.sinaapp.com/ismth/getCookie.php";
    
 
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
