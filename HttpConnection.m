
#import "HttpConnection.h"


@implementation HttpConnection

- (NSString *) getMethodUrl:(NSString *)relativeUrl
                     params:(NSMutableDictionary *)params{
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (CFStringRef)[self getURL:relativeUrl queryParameters:params],
                                                                                   NULL,
                                                                                   NULL,
                                                                                   kCFStringEncodingUTF8);
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSLog(@"%@",encodedString);
    [request setURL:[NSURL URLWithString:encodedString]];
    [request setHTTPMethod:@"GET"];
    
    [encodedString release];
    NSString *contentType = [NSString stringWithFormat:@"text/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    
    
    
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error] ;
    
    
    
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        NSString * responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
        return responseString;
    }else
    {
        return nil;
    }
    
    
}

- (NSString *) postMethodUrl:(NSString *)relativeUrl  params:(NSMutableDictionary *)params{
    relativeUrl=[NSString stringWithFormat:@"%@%@",BASE_URL,relativeUrl];
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
    
    
    NSLog(@"%d", [response statusCode]);
    
    if([response statusCode] >= 200 && [response statusCode] <300){
        NSString * responseString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        return responseString;
    }else
    {
        return nil;
    }
    
    
    
}

-(NSString *) getURL:(NSString *)url queryParameters:(NSDictionary *)params{
    
    NSString* fullPath =[NSString stringWithFormat:@"%@%@",BASE_URL,url];
	if (params) {
        // Append base if specified.
        NSMutableString *str = [NSMutableString stringWithCapacity:0];
        if (fullPath) {
            [str appendString:fullPath];
        }
        
        // Append each name-value pair.
        if (params) {
            int i;
            NSArray *names = [params allKeys];
            for (i = 0; i < [names count]; i++) {
                if (i == 0) {
                    [str appendString:@"?"];
                } else if (i > 0) {
                    [str appendString:@"&"];
                }
                NSString *name = [names objectAtIndex:i];
                [str appendString:[NSString stringWithFormat:@"%@=%@",
                                   name, [params objectForKey:name]]];
            }
        }
        
        return str;
        
        
    }
    
	return fullPath;
    
}

-(NSString *)paramsFromDictionary:(NSMutableDictionary *)params
{
    if (params) {
        // Append base if specified.
        NSMutableString *str = [NSMutableString stringWithCapacity:0];
        // Append each name-value pair.
        if (params) {
            int i;
            NSArray *names = [params allKeys];
            for (i = 0; i < [names count]; i++) {
                if (i > 0) {
                    [str appendString:@"&"];
                }
                NSString *name = [names objectAtIndex:i];
                [str appendString:[NSString stringWithFormat:@"%@=%@",
                                   name, [params objectForKey:name]]];
            }
        }
        
        return str;
    }
    return nil;
    
    
}


@end
