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

-(void)addSearchBar
{
    mysearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(70, 3, 250, 40)];
    mysearchBar.delegate = self;
    
    // change the searchBar's color
    {
        mysearchBar.tintColor = [UIColor grayColor];
        UIView*segment = [mysearchBar.subviews objectAtIndex:0];
        [segment removeFromSuperview];
        mysearchBar.backgroundColor = [UIColor clearColor];
    }
    {
        //when seach bar is selected, the keyboard type
        UITextField* seachField = [[mysearchBar subviews] lastObject];
        [seachField setReturnKeyType:UIReturnKeyDone];
        
        mysearchBar.barStyle = UIBarStyleBlackTranslucent;
        mysearchBar.keyboardType = UIKeyboardTypeDefault;
        mysearchBar.placeholder = @"请输入搜索关键字";
        
        mysearchBar.showsSearchResultsButton = YES;
    }
    
    [self.navigationController.navigationBar addSubview:mysearchBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchResult = [[NSMutableArray alloc] init];
  
    //[self loadHtml];
     

}
- (void)viewDidUnload
{
    [self setTableref:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mysearchBar removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSearchBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


#pragma UISeachBarDelegate
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	// only show the status bar's cancel button while in edit mode
	searchBar.showsCancelButton = YES;
	// flush and save the current list content in case the user cancels the search later
    
}	

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Text did change %@", searchText);
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
     [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search Button Clicked");
    
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* searchResult = [httpclient httpSendSearchRequest:searchBar.text];
    [self getSearchResult:searchResult];
    [searchBar resignFirstResponder];
    
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
    
    
    /////insert the search result to datarecord/////
    //name and url
    DataSingleton* dataRecord= [DataSingleton singleton];    
     [dataRecord.UserFavoriteListName addObject: [[DataSingleton singleton].searchBoardResults objectAtIndex:indexPath.row]];
    
    
    ///add url ;
    [searchResult objectAtIndex:indexPath.row];
    [dataRecord.UserFavoriteListUrl addObject:    [searchResult objectAtIndex:indexPath.row]];
    
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



//
//<tr><td class="title_1"><a href="/nForum/board/Programming">编程技术</a><br />Programming</td><td class="title_2">
-(void)getSearchResult:(NSString*)inputstring
{
    [searchResult removeAllObjects];
    inputstring = [inputstring stringByReplacingRegexPattern:@"<td class=\"title_3\"><" withString:@"\n"];
    
    NSArray *matches = [inputstring stringsByExtractingGroupsUsingRegexPattern:@"<tr><td class=\"title_1\">(.*)<td class=\"title_2\">"
                                                               caseInsensitive:NO treatAsOneLine:NO];
    
    DataSingleton* dataRecorder = [DataSingleton singleton];
    for (int i = 0 ; i<[matches count]; i++) {
        
        NSString* temp = [matches objectAtIndex:i];
        NSArray* boardname = [temp stringsByExtractingGroupsUsingRegexPattern:@"<a href=\"/nForum/board/(.*)\">"];
        
        NSString* boardshortUrl =[boardname objectAtIndex:0];
        NSString* boardlongurl = [@"" stringByAppendingFormat:@"nForum/board/%@", boardshortUrl];
        NSLog(@"board url link is %@",boardlongurl);
      
        [searchResult addObject:boardlongurl];
        
        //remove additional tags
        temp = [temp stringByReplacingRegexPattern:@"<.*\">" withString:@""];
        temp = [temp stringByReplacingRegexPattern:@"<[a-z /]{1,6}>" withString:@" "];
        
        
        [dataRecorder.searchBoardResults insertObject:temp atIndex:i];
        
    }
    
    [tableref reloadData];
    return ;
    
}

@end
