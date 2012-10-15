
#import "HttpClinetUingASIhttp_summaryReport.h"

#import "ASIHTTPRequest.h"
#import "constant.h"
#import "DataSingleton.h"
#import "NSString+PDRegex.h"


@implementation HttpClinetUingASIhttp_summaryReport


-(void)httpGetWeather
{
     
       
        NSString*finalstring = @"http://www.newsmth.net/nForum/s/board?ajax&b=suanfa";
        NSURL *url = [NSURL URLWithString:finalstring];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request startAsynchronous];
        
    
}

-(void) requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    //NSLog(@"---------------responseString   %@", responseString);
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    NSString * displayString = [[NSString alloc] initWithData:responseData encoding:NSWindowsCP1251StringEncoding];
    
  
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"nslog request fail %@", request.url);
    
}  


-(NSString*)getMainWeather:(NSString*)inputString
{
    return @"";
}

@end
