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
- (void)loadHtml:(NSString*)middlecontenthtml {
    
       
    
    
//  
//	[html appendString:@"<html>"];
//	[html appendString:@"<head>"];
//	[html appendString:@"</head>"];
	
    
    [html appendString:middlecontenthtml];
    
    
//    [html appendString:@"</body></html>"];
    
    
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
