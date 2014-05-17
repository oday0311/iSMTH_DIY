//
//  webResultViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 13-3-23.
//
//

#import "webResultViewController.h"
#import "NSString+PDRegex.h"
@interface webResultViewController ()

@end

@implementation webResultViewController
@synthesize htmlString;
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
    mapButton.backgroundColor = [UIColor clearColor];
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
    }
     [self createNavigationRightButton];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self loadHtml:htmlString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebview:nil];
    [super viewDidUnload];
}


- (void)loadHtml:(NSString*)htmlStringInput {
    
    
    NSString* localString = @"";
    
    
	localString = [localString stringByAppendingString:@"<html>"];
	localString = [localString stringByAppendingString:@"<head>"];
	localString = [localString stringByAppendingString:@"</head><body>"];
    
    NSRange bodyStart = [htmlStringInput rangeOfString:@"<body>"];
    [htmlStringInput rangeOfString:@"</body>"];
    
    NSString* jsResutlString = [self getSearchResultFromJs:htmlStringInput];
    localString = [localString stringByAppendingString:jsResutlString];
    NSString* bodyString = [htmlStringInput substringFromIndex:bodyStart.location];
    localString = [localString stringByAppendingString:bodyString];
    
    //localString = [localString stringByAppendingString:@"</body></html>"];
    
    [self.webview loadHTMLString:localString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    
    
    
}
-(NSString*)getSearchResultFromJs:(NSString*)inputString
{
    NSArray* resultsString_imageUrl = [inputString stringsByExtractingGroupsUsingRegexPattern:@"objURLEnc:\"(.*)\",fromURLEnc:"];
    
    
    NSArray* resultsString_fromPageTitle = [inputString stringsByExtractingGroupsUsingRegexPattern:@"fromPageTitle:(.*),fromPageTitleEnc"];
    
    NSLog(@"The number of resultsSting is %d", resultsString_imageUrl.count);
    
    
    
    NSString* returnString =@"";
    for (int i=0; i<resultsString_imageUrl.count; i++) {
        NSString*tempString = [resultsString_imageUrl objectAtIndex:i];
        returnString =[returnString stringByAppendingFormat: @"<img  src=\"%@\">",tempString];
        NSString* tempString2 = [resultsString_fromPageTitle objectAtIndex:i];
        returnString = [returnString stringByAppendingFormat:@"<p>%@</p>",tempString2];
        
        
    }
    return returnString;
}
@end
