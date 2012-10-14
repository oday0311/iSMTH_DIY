//
//  DocList.m
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DocList.h"
#import "constant.h"

#import  "topicDetailShow.h"
@implementation DocList
@synthesize tableref = _tableref;

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
        
        int finallength = range2.location - range1.location;
        NSRange range3 = NSMakeRange(range1.location, finallength);
        NSString* finalstring = [inputString substringWithRange:range3];
        return finalstring;
    }
    @catch (NSException *exception) {
        return @"get substring error";
    }
    
    return @"";
}
-(NSString*) getSubString2_beginstringnotinclude:(NSString*)inputString BeginString:(NSString*)string1 EndString:(NSString*)string2
{
    
    @try {
        NSRange range1= NSMakeRange(0, 0);
        range1 =  [inputString rangeOfString:string1];
        NSLog(@" %d, %d", range1.location, range1.length);
        
        int total_length = inputString.length;
        
        NSRange range2 = NSMakeRange(range1.location , total_length - range1.location);
        range2 =[inputString rangeOfString:string2 options:NSCaseInsensitiveSearch range:range2];
        
        int finallength = range2.location - range1.location-range1.length;
        NSRange range3 = NSMakeRange(range1.location+range1.length, finallength);
        NSString* finalstring = [inputString substringWithRange:range3];
        return finalstring;
    }
    @catch (NSException *exception) {
        return @"get substring error";
    }
    
    return @"";
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     arrayList  = [[NSMutableArray alloc]  init];
    arrayList_link = [[NSMutableArray alloc]  init];
    
    
    
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableref.bounds.size.height, self.view.frame.size.width, self.tableref.bounds.size.height)];
		view.delegate = self;
		[self.tableref addSubview:view];
		_refreshHeaderView = view;
		//[view release];
		
	}
	//[self businessCardFresh];
	//  update the last update date
	//[_refreshHeaderView refreshLastUpdatedDate];
    self.tableref.dataSource = self;
    self.tableref.delegate = self;
    
    
    
    dataRecorder = [DataSingleton singleton];
    
    NSString* postlist = dataRecorder.stockBoardlist;
    
    NSRange containTopic = NSMakeRange(0, 0);
    containTopic = [postlist rangeOfString: @"<a target=\"_blank\" href=\"/nForum/article/"];
    
    int i = 0;
    while( containTopic.length > 0 ) {
        if (i++ == 8) {
            NSLog(@"this is a testing code for debug");
        }
        NSString* substring_topic = [self getSubString:postlist BeginString:@"<a target=\"_blank\" href=\"/nForum/article/" EndString:@"</td></tr><tr ><td class=\"title_8\">"];
    
        NSRange range1_isTop = NSMakeRange(0, 0);
        range1_isTop = [postlist rangeOfString:@"<tr class=\"top\""];
        NSRange range1_isTopOdd=NSMakeRange(0, 0);
        range1_isTopOdd = [postlist rangeOfString:@"<tr class=\"top bg-odd\">"];
        if (range1_isTop.length==0 && range1_isTopOdd.length == 0) {
            ///this topic is not a top topic.
            
        }
        
        NSString* substring_topic_writer = [self getSubString2_beginstringnotinclude:substring_topic BeginString:@"<td class=\"title_9\"><a href=" EndString:@"</a>"];
       
        NSRange range2= NSMakeRange(0, 0);
        range2 =[substring_topic_writer rangeOfString:@"\">"];
        if (range2.length == 0) {
            break;
        }
        NSString* substring_topic_title  = [substring_topic_writer substringFromIndex:range2.location+range2.length];
        
        
        NSString* substring_topic_link= [self getSubString:substring_topic BeginString:@"href=\"" EndString:@"title"];
        
        
        
        topic* newtopic = [[topic alloc] init];
        
        newtopic.link = substring_topic_link;
        newtopic.topicTitle = substring_topic_title;
        if (range1_isTop.length==0 && range1_isTopOdd.length ==0) {
            NSLog(@" this topic is not a top topic.");
            newtopic.IsTopTopic = FALSE;
        }else
        {
            newtopic.IsTopTopic =TRUE;
        }
        
        
        
        [arrayList addObject:newtopic];
        
        
        
        NSString* fowllowingList= [postlist substringFromIndex:containTopic.location + containTopic.length];

        postlist = fowllowingList;
                
        
        
        containTopic = [fowllowingList rangeOfString: @"<a target=\"_blank\" href=\"/nForum/article/"];
    }
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [_refreshHeaderView  setState:EGOOPullRefreshLoading];
      
    [super viewDidAppear:animated];
}
- (void)viewDidUnload
{
    [self setTableref:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return the height
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayList count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSLog(@"%d",[arrayList count]);
    if ([indexPath row] <= [arrayList count] - 1) {
        topic* currentTopic = [arrayList objectAtIndex:indexPath.row];
        
        
        
        
        if (currentTopic.IsTopTopic) {
             cell.textLabel.textColor  =[UIColor orangeColor];
            
            int randNum = 10;
            NSString* imageSouce = [@"" stringByAppendingFormat: @"title_%d",randNum];
            cell.imageView.image =[UIImage imageNamed: imageSouce];
        }
        else
        {
            
            int randNum = rand()%16+1;
            NSString* imageSouce = [@"" stringByAppendingFormat: @"title_%d",randNum];
            cell.imageView.image =[UIImage imageNamed: imageSouce];
             cell.textLabel.textColor  =[UIColor blackColor];
        }
       
        
        cell.textLabel.text = currentTopic.topicTitle;
        NSLog(@"   THE LABLE contain is %@ ", [arrayList objectAtIndex:indexPath.row]);
    }else{
        cell.textLabel.textColor  =[UIColor blueColor];
        cell.textLabel.text = @"点击加载更多";       
    }
    
   
    return cell;
    

    
        
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    topic* temp = [arrayList objectAtIndex:indexPath.row];
    
    
    NSString* link = temp.link;
    link=[link substringFromIndex:7]; //   href="/
    link = [link substringToIndex:link.length-2];  /// (" )
    NSString* topic_detaillink = [@"" stringByAppendingFormat:@"%@%@",SMTH_BASE_URL,link];
    NSLog(@"Tableview  %@ " ,topic_detaillink);
    
    
    dataRecorder.topic_detail_link = topic_detaillink;
    topicDetailShow*
    viewController2 = [[topicDetailShow alloc] initWithNibName:@"topicDetailShow" bundle:nil];
    [self.navigationController pushViewController:viewController2 animated:YES];
    
       

}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%d",indexPath.row);
    
    
}
-(void) businessCardFresh
{
    
   // NSLog(@"=======%d",dataRecorder.count);
   
    [arrayList insertObject:@"huangzf" atIndex:0];
    [self.tableref reloadData];
}

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    [self businessCardFresh];
	_reloading = YES;
	
}
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableref];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



@end
