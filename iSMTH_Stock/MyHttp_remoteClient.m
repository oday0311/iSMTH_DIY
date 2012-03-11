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



/*
 NSError* error = nil;
 NSString* fileString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"file:///TestXml.xml"] encoding:NSUTF8StringEncoding error:&error];
 NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[fileString dataUsingEncoding:NSUTF8StringEncoding]];
 - (NSMutableArray*) GetArrayByPaserXML { 
 //获取xml文件 
 NSString* path = path = [[NSBundle mainBundle] pathForResource:@"Question" ofType:@"xml"]; 
 NSFileHandle* file = [NSFileHandle fileHandleForReadingAtPath:path]; 
 NSData* data = [file readDataToEndOfFile]; 
 [file closeFile]; 
 
 m_parser = [[NSXMLParser alloc] initWithData:data]; 
 
 //设置该类本身为代理类 
 [m_parser setDelegate:self]; 
 
 BOOL flag = [m_parser parse]; 
 if (flag) { 
 NSLog(@"获取指定路径的xml文件成功"); 
 } else { 
 NSLog(@"获取指定路径的xml文件失败"); 
 } 
 [m_parser release]; 
 return m_arrXMLNode; 
 } 
 
 
 <place>
 <laddr>中国北京市朝阳区建国门外大街1号 (Beijing World Trade Corporation)</laddr>
 <name>Beijing World Trade Corporation</name>
 <address>中国,北京市朝阳区建国门外大街1号</address>
 <numbers>
 <number>010-65052288</number>
 <number>010-12345678</number>
 </numbers>
 <photo>http://mw2.google.com/mw-panoramio/photos/thumbnail/27548988.jpg</photo>
 </place>
 */
// Constants for the XML element names that will be considered during the parse. 
// Declaring these as static constants reduces the number of objects created during the run
// and is less prone to programmer error.
static NSString *kName_type = @"type";
static NSString *kName_errorCode = @"errorCode";
static NSString *kName_elapsedTime = @"elapsedTime";
static NSString *kName_translateResult = @"translateResult";
static NSString *kName_src = @"src";
static NSString *kName_tgt = @"tgt";

static NSMutableString* elementValue = (NSMutableString*)@"";

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"[%@] start -->", elementName);
    elementValue = (NSMutableString*)@"";
    if ([elementName isEqualToString:kName_type]) {

    }
    
   
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *trimmed =[string stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![trimmed isEqualToString:@""]) {
        elementValue =(NSMutableString*)[elementValue stringByAppendingString:trimmed];
        //NSLog(@"find text : %@", trimmed);
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"[%@] end <--", elementName);
    
       
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
    NSLog(@"NSXMLParser paser error ");
}


@end
