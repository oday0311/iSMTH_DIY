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
#import "DocList.h"

@implementation SecondViewController
@synthesize tableref;
@synthesize webview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"板块搜索", @"板块搜索");
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

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
}

-(void)addMBProgressHud
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD showWhileExecuting:@selector(getDynamic_Fresh) onTarget:self withObject:nil animated:YES];
    
    
    
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
-(void)randSearch:(NSString*)inputstring
{
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString* searchReturns = [httpclient httpSendSearchRequest:inputstring];
    [self getSearchResult:searchReturns];
}

-(void)startThreadWork_getRandSearchResults:(NSString*)inputstring
{
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"加载中";
        [HUD show:YES];
    }
    dispatch_queue_t downloadQueue = dispatch_queue_create("get private message queue", NULL);
    
    dispatch_async(downloadQueue, ^{
        [self randSearch:inputstring];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update the UI in main queue;
            //[HUD removeFromSuperViewOnHide];
            [HUD setHidden:YES];
            }); });
    dispatch_release(downloadQueue); //won’t actually go away until queue is empty
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchResult = [[NSMutableArray alloc] init];
  
    tableref.backgroundColor = [UIColor clearColor];
    tableref.superview.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
    
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

-(void)httpStartBoardsearchAtRandom
{
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    srand((unsigned)time(0));
    int randint = rand()%26;
    char c = 'a'+ randint;
    NSString* randstring = [@"" stringByAppendingFormat:@"%c",c];
    
    NSString* searchBoardResult = [httpclient httpSendSearchRequest:randstring];
    [self getSearchResult:searchBoardResult];
    
}

-(void)searchwithMBprogressBarAtRandom
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD showWhileExecuting:@selector(httpStartBoardsearchAtRandom) onTarget:self withObject:nil animated:YES];
    
    
}


static int randomSearch = 1;
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.topItem.title = @"板块搜索";

    if (randomSearch == 1) {
        randomSearch = 0;
        
        [self searchwithMBprogressBarAtRandom];
        
        //[self startThreadWork_getRandSearchResults:randstring];
        
        
        

    }
   [self.navigationController.navigationBar addSubview:mysearchBar];


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


-(void)httpStartBoardsearch
{
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    
    
    NSString* searchBoardResult = [httpclient httpSendSearchRequest:mysearchBar.text];
    [self getSearchResult:searchBoardResult];
    
}

-(void)seachwithMBprogressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD showWhileExecuting:@selector(httpStartBoardsearch) onTarget:self withObject:nil animated:YES];
    

}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search Button Clicked");
    [self seachwithMBprogressBar];
    [mysearchBar resignFirstResponder];

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







//
//<tr><td class="title_1"><a href="/nForum/board/Programming">编程技术</a><br />Programming</td><td class="title_2">
-(void)getSearchResult:(NSString*)inputstring
{
    [tableref setContentOffset:CGPointMake(0, 0)];
    [[DataSingleton singleton].searchBoardResults removeAllObjects];
    [searchResult removeAllObjects];
    inputstring = [inputstring stringByReplacingRegexPattern:@"<td class=\"title_3\"><" withString:@"\n"];
    
    NSArray *matches = [inputstring stringsByExtractingGroupsUsingRegexPattern:@"<tr><td class=\"title_1\">(.*)<td class=\"title_2\">"
                                                               caseInsensitive:NO treatAsOneLine:NO];
    
    DataSingleton* dataRecorder = [DataSingleton singleton];
    
    for (int i = 0 ; i<[matches count]; i++) {
        
               NSString* temp = [matches objectAtIndex:i];
        
        NSArray* boardname = [temp stringsByExtractingGroupsUsingRegexPattern:@"<a href=\"/nForum/board/(.*)\">"];
        if (boardname.count==0) {
            continue;
        }
        NSString* boardshortUrl =[boardname objectAtIndex:0];
        NSString* boardlongurl = [@"" stringByAppendingFormat:@"nForum/board/%@", boardshortUrl];
        NSLog(@"board url link is %@",boardlongurl);
      
        
        
        //remove additional tags
        temp = [temp stringByReplacingRegexPattern:@"<.*\">" withString:@""];
        temp = [temp stringByReplacingRegexPattern:@"<[a-z /]{1,6}>" withString:@" "];
        
        if (matches.count > 40) {
            ///if the search result list is too long, random to disgard.
            srand((unsigned)time(0));
            int randint = rand()%10;
            if (randint > 3) {
                [dataRecorder.searchBoardResults addObject:temp];
                [searchResult addObject:boardlongurl];
            }
        }
        else{
            [dataRecorder.searchBoardResults addObject:temp ];
            [searchResult addObject:boardlongurl];
        }
    
    }
    NSLog(@"THE search board results length is %d", dataRecorder.searchBoardResults.count);
    [tableref reloadData];
    return ;
    
}

- (void)getStockBoardlist:(id)sender withInput:(NSString*)BASE_URL {
    
 
    UIViewController*
    viewController2 = [[DocList alloc] initWithNibName:@"DocList" bundle:nil];
    [DataSingleton singleton].DocListFirstload = 1;
    [self.navigationController pushViewController:viewController2 animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /////insert the search result to datarecord/////
    //name and url
    DataSingleton* dataRecord= [DataSingleton singleton];
    
    
    
    NSString* favoriteListnameString = [[DataSingleton singleton].searchBoardResults objectAtIndex:indexPath.row];
    [dataRecord.UserFavoriteListName addObject: favoriteListnameString];
    
    
    ///add url ;
    [searchResult objectAtIndex:indexPath.row];
    [dataRecord.UserFavoriteListUrl addObject:    [searchResult objectAtIndex:indexPath.row]];
    
    
    
    NSString* longUrl = [searchResult objectAtIndex:indexPath.row];
    NSString* fullUrl = [SMTH_BASE_URL stringByAppendingFormat:@"%@",longUrl];
    
    [DataSingleton singleton].Selected_complete_url = fullUrl;
    [DataSingleton singleton].selected_topic_title = favoriteListnameString;
    [self getStockBoardlist:self withInput:fullUrl];
    

    [constant addDataToPlist:favoriteListnameString content:longUrl];
    
    
}




@end
