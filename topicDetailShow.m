//
//  topicDetailShow.m
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "topicDetailShow.h"
#import "DataSingleton.h"
#import "NSString+PDRegex.h"
#import "UIGlossyButton.h"
@implementation topicDetailShow
@synthesize webivew;
#define CAP_WIDTH 15.0
-(void)createNavigationRightButton
{
    UIButton* mapButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52 , 31)] ;
    
    UIImage*buttonImage = [[UIImage imageNamed:@"navigationButtonSider.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0 ];
    [mapButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    UIImage*buttonImage2 = [[UIImage imageNamed:@"navigationButtonSider.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0 ];
    [mapButton setBackgroundImage:buttonImage2 forState:UIControlStateHighlighted];
    
    
    
    mapButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    mapButton.titleLabel.textColor = [UIColor whiteColor];
    mapButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
    mapButton.titleLabel.shadowColor = [UIColor darkGrayColor];
    mapButton.backgroundColor = [UIColor blackColor];
    [mapButton
     setTitle:@"  " forState:UIControlStateNormal];
    mapButton.layer.cornerRadius = 5.0;
    [mapButton addTarget:self.navigationController action:@selector(startMore) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapButton ] ;
}
-(void)startMore
{
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pageIndex = 1;
        maxPage = 1;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)btnPressLast
{
    
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* targetlink = [DataSingleton singleton].topic_detail_link;
    
    pageIndex = pageIndex - 1;
    if (pageIndex < 1) {
        pageIndex = 1;
    }

    targetlink = [targetlink stringByAppendingFormat:@"?p=%d", pageIndex];
    PagelabelView.text = [@"" stringByAppendingFormat:@"第%d页/共%d页", pageIndex, maxPage];
    NSLog(@" the targetlink is %@", targetlink);
    
    NSString* topic_detailinform = [httpclient httpSendRequest:targetlink];
    
    NSLog(@" the response is show as %@", topic_detailinform);
    //topic_detaillink
    html = [[NSMutableString alloc] init];
    
    [self loadHtml:topic_detailinform];

}

-(void)btnPressNext
{
    NSLog(@"btnPressNext begin ");
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* targetlink = [DataSingleton singleton].topic_detail_link;
    
    
    
    pageIndex = pageIndex + 1;
    if (pageIndex > maxPage) {
        pageIndex = maxPage;
    }
    
    targetlink = [targetlink stringByAppendingFormat:@"?p=%d", pageIndex];
    PagelabelView.text = [@"" stringByAppendingFormat:@"第%d页/共%d页", pageIndex, maxPage];
    
    
    NSLog(@" the targetlink is %@", targetlink);
    
    NSString* topic_detailinform = [httpclient httpSendRequest:targetlink];
    
    NSLog(@" the response is show as %@", topic_detailinform);
    //topic_detaillink
    html = [[NSMutableString alloc] init];
    
    [self loadHtml:topic_detailinform];

    
}
-(void)createPageView
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 40)];
    customView.backgroundColor= [UIColor colorWithRed:189/255.0 green:197/255.0 blue:198/255.0 alpha:0.8];
    {
        
        UIGNavigationButton *b;
        
        b = [[UIGNavigationButton alloc] initWithFrame:CGRectMake(20, 5, 80, 30)] ;
        b.leftArrow = YES;
        [b setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
        
        UILabel* textlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 30)];
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.textColor = [UIColor whiteColor];
        textlabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
        textlabel.text =  @"上一页";
        
        [b addTarget:self action:@selector(btnPressLast) forControlEvents:UIControlEventTouchUpInside];
        [b addSubview:textlabel];
        [customView addSubview: b];
        
    }
    
    {
        PagelabelView = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 100, 30)];
        PagelabelView.backgroundColor = [UIColor clearColor];
        PagelabelView.text = [@"" stringByAppendingFormat:@"第%d页/共%d页", pageIndex, maxPage];
        
        [customView addSubview:PagelabelView];
    }
    
    {
        UIGNavigationButton *b;
        
        b = [[UIGNavigationButton alloc] initWithFrame:CGRectMake(220, 5, 80, 30)];
        b.leftArrow = NO;
        [b setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
        
        UILabel* textlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)] ;
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.textColor = [UIColor whiteColor];
        textlabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
        textlabel.text =  @"下一页";
        
        [b addTarget:self action:@selector(btnPressNext) forControlEvents:UIControlEventTouchUpInside];
        [b addSubview:textlabel];
        [customView addSubview: b];
    }
    
    
    [self.view addSubview:customView];

}
- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
}
-(NSString*)getPagesNumber:(NSString*)inputstring
{
    //贴数:<i>1510</i>
    inputstring = [inputstring stringByReplacingRegexPattern:@"分页" withString:@"\n"];
    NSArray *matches = [inputstring stringsByExtractingGroupsUsingRegexPattern:@"贴数:<i>(.*)</i>"
                                                               caseInsensitive:NO treatAsOneLine:NO];
    
    NSString * returnstring = @"";
    for (int i = 0 ; i<[matches count]; i++) {
        NSString* tempstring = [matches objectAtIndex:i];
        NSLog(@"the page string is %@", tempstring);
        return tempstring;
    }
    NSLog(@"the resurn string is %@", returnstring);
    
    return returnstring;
    
}
- (void)loadHtml:(NSString*)middlecontenthtml {
    
       
    
    
  
	[html appendString:@"<html>"];
	[html appendString:@"<head>"];
	[html appendString:@"</head><body>"];
	
    //NSString*temp = [self getPostInformation:middlecontenthtml];
    NSString*temp = [self getPostInformationNew:middlecontenthtml];
    NSString* totalpagestring = [self getPagesNumber:middlecontenthtml];
    maxPage = totalpagestring.integerValue/10 +1;
    NSLog(@"The max page is %d", maxPage);
    PagelabelView.text = [@"" stringByAppendingFormat:@"第%d页/共%d页", pageIndex, maxPage];
    
    [html appendString:temp];
    
    
    [html appendString:@"</body></html>"];
    
    
    [webivew loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createPageView];
    [self addAdmob];
    
    
    // Do any additional setup after loading the view from its nib.
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* targetlink = [DataSingleton singleton].topic_detail_link;
    
    NSLog(@" the targetlink is %@", targetlink);
    
    NSString* topic_detailinform = [httpclient httpSendRequest:targetlink];
    
    NSLog(@" the response is show as %@", topic_detailinform);
    //topic_detaillink
    html = [[NSMutableString alloc] init];
    
    [self loadHtml:topic_detailinform];
    
    
    [HUD setHidden:YES];

    [self createNavigationRightButton];
}

- (void)viewDidUnload
{
    [self setWebivew:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
-(NSString*)getPostInformationNew:(NSString*) inputstring
{
    
    NSArray *matches = [inputstring stringsByExtractingGroupsUsingRegexPattern:@"<div class=\"a-wrap corner\"><table class=\"article\">(.*)</a></td></tr></table></div>"
                                                               caseInsensitive:NO treatAsOneLine:NO];
    
    NSString * returnstring = @"";
    for (int i = 0 ; i<[matches count]; i++) {
        returnstring = [returnstring stringByAppendingFormat:@"<div class=\"a-wrap corner\"><table class=\"article\">%@</a></td></tr></table></div>",                        [matches objectAtIndex:i] ];
        
    }
    NSLog(@"the resurn string is %@", returnstring);
    
    return returnstring;
    
}


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

-(void)addAdmob
{
    
    // Do any additional setup after loading the view from its nib.
    {
        if ([DataSingleton singleton].ad_config_open == 0) {
            
            self.adView = [[GADBannerView alloc]
                            initWithFrame:CGRectMake(0.0,
                                                     360,
                                                     GAD_SIZE_320x50.width,
                                                     GAD_SIZE_320x50.height)] ;
            
            // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
            self.adView.adUnitID = ADMOB_PUBLISH_ID;
            
            // Let the runtime know which UIViewController to restore after taking
            // the user wherever the ad goes and add it to the view hierarchy.
            self.adView.rootViewController = self;
            self.adView.delegate = self;
            
            
            [self.view addSubview:self.adView];
            
            
            [self.adView loadRequest:[GADRequest request]];
            //[self.adView setHidden:YES];
        }
        else{
            adSelfDefineButton = [[UIButton alloc] initWithFrame: CGRectMake(0.0,
                                                                              self.view.frame.size.height -                                                                             GAD_SIZE_320x50.height+20,                                                                             GAD_SIZE_320x50.width,                                                                             GAD_SIZE_320x50.height)] ;
            NSURL *imageUrl = [NSURL URLWithString:[DataSingleton singleton].adImageUrl];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            [adSelfDefineButton setBackgroundImage:image forState:UIControlStateNormal];
            [adSelfDefineButton addTarget:self action:@selector(adJumpToLinkWeb) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:adSelfDefineButton];
            //[adSelfDefineButton setHidden:YES];
        }
        
    }

}
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@" did receive admob ");
}

// Sent when an ad request failed.  Normally this is because no network
// connection was available or no ads were available (i.e. no fill).  If the
// error was received as a part of the server-side auto refreshing, you can
// examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"fail to receive admob ");
}
@end
