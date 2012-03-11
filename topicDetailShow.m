//
//  topicDetailShow.m
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "topicDetailShow.h"
#import "DataSingleton.h"
@implementation topicDetailShow
@synthesize webivew;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(NSString*) getSubString:(NSString*)inputString BeginString:(NSString*)string1 EndString:(NSString*)string2
{
    
    @try {
        NSRange range1= NSMakeRange(0, 0);
        range1 =  [inputString rangeOfString:string1];
        NSLog(@" %d, %d", range1.location, range1.length);
        
        int total_length = inputString.length;
        
        NSRange range2 = NSMakeRange(range1.location, total_length - range1.location);
        range2 =[inputString rangeOfString:string2 options:NSCaseInsensitiveSearch range:range2];
        
        int finallength = range2.location - range1.location+range2.length;
        NSRange range3 = NSMakeRange(range1.location, finallength);
        NSString* finalstring = [inputString substringWithRange:range3];
        return finalstring;
    }
    @catch (NSException *exception) {
        return @"get substring error";
    }
    
    return @"";
}

#define POST_STARTER @"<td class=\"a-content a-no-bottom a-no-top\">"

-(NSString*) getPostInformation:(NSString*)inputstring
{
    ///<td class="a-content a-no-bottom a-no-top">
    NSRange postExitTester = NSMakeRange(0, 0);
    
    postExitTester = [inputstring rangeOfString:POST_STARTER];
   
    
    NSString* postString;
    NSMutableString* allpostString = [[NSMutableString alloc] init];
    while (postExitTester.length > 0 ) {
        
        
        
        postString = [self getSubString:inputstring BeginString:POST_STARTER EndString:@"</td>"];
        
        inputstring = [inputstring substringFromIndex:postExitTester.location+postExitTester.length];
        
        postExitTester = [inputstring rangeOfString:POST_STARTER];
        [allpostString appendString:postString];
        
        
    }
    
    
    
   // NSString*
    
    return allpostString;
    
}
- (void)loadHtml:(NSString*)middlecontenthtml {
    
       
    
    
  
	[html appendString:@"<html>"];
	[html appendString:@"<head>"];
	[html appendString:@"</head><body>"];
	
    NSString*temp = [self getPostInformation:middlecontenthtml];
    [html appendString:temp];
    
    
    [html appendString:@"</body></html>"];
    
    
    [webivew loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* targetlink = [DataSingleton singleton].topic_detail_link;
    NSString* topic_detailinform = [httpclient httpSendRequest:targetlink];
    
    //NSLog(@" the response is show as %@", topic_detailinform);
    //topic_detaillink
    html = [[NSMutableString alloc] init];
    
    [self loadHtml:topic_detailinform];

}

- (void)viewDidUnload
{
    [self setWebivew:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
