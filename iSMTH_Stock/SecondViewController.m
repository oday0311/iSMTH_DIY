//
//  SecondViewController.m
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "DataSingleton.h"
#import "NSString+PDRegex.h"

@implementation SecondViewController
@synthesize tableref;
@synthesize webview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




- (void)checkResourceFile:(NSString *)_filename {
//	NSString *htmlCachePath = [PathHelper cacheDirectoryPathWithName:@"html"];
//	NSString *filePath = [htmlCachePath stringByAppendingPathComponent:_filename];
//	NSFileManager* fm = [NSFileManager defaultManager];
//	if (![fm fileExistsAtPath:filePath]) {
//		NSString *path = [[[NSBundle mainBundle] resourcePath] 
//						  stringByAppendingPathComponent:_filename];
//		NSData *filedata = [NSData dataWithContentsOfFile: path];
//		if (filedata) {
//			[fm createFileAtPath:filePath contents:filedata attributes:nil];
//		}
//	}
}
- (void)checkResourceFiles {
//	[self checkResourceFile:@"jquery.js"];
//	[self checkResourceFile:@"tweet_details.js"];
//	[self checkResourceFile:@"tweet_details.css"];	
//	[self checkResourceFile:@"miniretweet@2x.png"];
//	[self checkResourceFile:@"mini-reply@2x.png"];
//	[self checkResourceFile:@"verified@2x.png"];
    

}
- (void)loadHtml {
    
    NSLog(@"try to load signatur");
	//webView.hidden = YES;
//	NSString *html = [self generateTweetHtml];
//	//NSString *path = [[NSBundle mainBundle] bundlePath];
//	[self checkResourceFiles];
//	NSString *htmlCachePath = [PathHelper cacheDirectoryPathWithName:@"html"];
//	NSURL *baseURL = [NSURL fileURLWithPath:htmlCachePath];
//	[webView loadHTMLString:html baseURL:baseURL];
    
    
    
    
    NSMutableString *html = [NSMutableString string];
	[html appendString:@"<html>"];
	[html appendString:@"<head>"];
	[html appendString:@"</head>"];
	
    
    [html appendString:[DataSingleton singleton].finalstring];
    
    
    [html appendString:@"</body></html>"];
    
    
    [webview loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    
  

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadHtml];
     // Do any additional setup after loading the view, typically from a nib.

}
- (void)viewDidUnload
{
    [self setTableref:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[DataSingleton singleton].searchBoardResults count];//[arrayList count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [[DataSingleton singleton].searchBoardResults objectAtIndex:indexPath.row];
    return cell;
    
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (IBAction)testAction:(id)sender {
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* searchResult = [httpclient httpSendSearchRequest:@"算法"];
    [self getSearchResult:searchResult];
}

//
//<tr><td class="title_1"><a href="/nForum/board/Programming">编程技术</a><br />Programming</td><td class="title_2">
-(void)getSearchResult:(NSString*)inputstring
{
    inputstring = [inputstring stringByReplacingRegexPattern:@"<td class=\"title_3\"><" withString:@"\n"];
    
    NSArray *matches = [inputstring stringsByExtractingGroupsUsingRegexPattern:@"<tr><td class=\"title_1\">(.*)<td class=\"title_2\">"
                                                               caseInsensitive:NO treatAsOneLine:NO];
    
    DataSingleton* dataRecorder = [DataSingleton singleton];
    for (int i = 0 ; i<[matches count]; i++) {
        
        NSString* temp = [matches objectAtIndex:i];
        NSArray* boardname = [temp stringsByExtractingGroupsUsingRegexPattern:@"<a href=\"/nForum/board/(.*)\">"];
      
        
        //remove additional tags
        temp = [temp stringByReplacingRegexPattern:@"<.*\">" withString:@""];
        temp = [temp stringByReplacingRegexPattern:@"<[a-z /]{1,6}>" withString:@" "];
        
        
        [dataRecorder.searchBoardResults insertObject:temp atIndex:i];
        
    }
    
    [tableref reloadData];
    return ;
    
}

@end
