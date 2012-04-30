//
//  MyHttp_remoteClient.m
//  trueNameSimpler
//
//  Created by Alex on 9/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyHttp_remoteClient.h"
#import <CommonCrypto/CommonDigest.h> 

@implementation MyHttp_remoteClient


// SHA1 generator....
-(NSString*) digest:(NSString*)input  
{  
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];  
    NSData *data = [NSData dataWithBytes:cstr length:input.length];  
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];  
    CC_SHA1(data.bytes, data.length, digest);  
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];  
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)  
        [output appendFormat:@"%02x", digest[i]];  
    return output;  
} 


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
 
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


- (NSString*) httpSendRequest:(NSString*)inputURLstring
{
    NSMutableString * urlString1 = (NSMutableString*)@"";
  
    urlString1 = (NSMutableString*)[urlString1 stringByAppendingFormat:inputURLstring];
    
    //初始化http请求,并自动内存释放
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:[NSURL URLWithString:urlString1]];
    [request setHTTPMethod:@"GET"];
    
    
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;//[[NSError alloc] init] ;
    
    
    
    NSLog(@" The request is %@", request);
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
   
    pageSource = [[NSString alloc] initWithData:responseData encoding:enc];
    
    

    
    NSLog(@"response code:%d",[urlResponse statusCode]);
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
       
        
      
    }
    else
    {
        return @"error";
    }
    

    return pageSource;
 
}
- (NSString*) Simple_translate:(NSString*)translateString
{
    
    return @"";
    //return tgt_strings;
}

-(NSString*) httpSendSearchRequest:(NSString*)searchkey
{
    NSString * urlString1 = (NSMutableString*)@"";
    
    urlString1 = (NSString*)[urlString1 stringByAppendingFormat:@"http://www.newsmth.net/nForum/s/board?ajax&b=%@",searchkey];
    
    NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (__bridge_retained CFStringRef)urlString1,
                                                                                   NULL,
                                                                                   NULL,
                                                                                   kCFStringEncodingUTF8);
    //初始化http请求,并自动内存释放
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:[NSURL URLWithString:encodedString]];
    [request setHTTPMethod:@"GET"];
    
    
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;//[[NSError alloc] init] ;
    
    
    
    NSLog(@" The request is %@", request);
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    
    pageSource = [[NSString alloc] initWithData:responseData encoding:enc];
    
    
    
    
    NSLog(@"response code:%d",[urlResponse statusCode]);
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        
        
        NSLog(@" The search result is %@", pageSource);
    }
    else
    {
        return @"error";
    }
    
    
    return pageSource;
}



@end
