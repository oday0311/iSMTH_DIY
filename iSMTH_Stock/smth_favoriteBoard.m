//
//  FirstViewController.m
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "smth_favoriteBoard.h"
#import "MyHttp_remoteClient.h"
#import "DataSingleton.h"
#import "constant.h"
#import "smth_boardSearch.h"
#import "DocList.h"
#import "TempViewController.h"
@implementation smth_favoriteBoard
@synthesize tableref;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"精彩板块", @"精彩板块");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


#define SEARCH_STRING1 @" <h5 class=\"u-title\">个人说明档</h5>"
#define SEARCH_STRING2 @"<span class=\"n-left\">"

-(void)fixpack_for_ios6
{
    TempViewController*temp =[[TempViewController alloc] initWithNibName:@"TempViewController" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableref.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
    tableref.superview.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];

    HttpClient* httpClientAD=[[HttpClient alloc] initWithDelegate:self];
    [httpClientAD getAdConfigInformation];
    
    HttpClient* httpClientCookie=[[HttpClient alloc] initWithDelegate:self];
    [httpClientCookie getCookie];

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
    [tableref reloadData];
}
static int firstTimeAppear = 1;
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = @"精彩板块";
    [super viewDidAppear:animated];
    if (firstTimeAppear==1) {
        firstTimeAppear = 0;
        [self fixpack_for_ios6];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



- (IBAction)getSignature:(id)sender {
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString*signature = [httpclient httpSendRequest:NIUMAO_SIGNATURE];
    int total_length = signature.length;
    if (total_length > 10) {
        NSRange range1= NSMakeRange(0, 0);
        range1 =  [signature rangeOfString:SEARCH_STRING2];
        NSLog(@" %d, %d", range1.location, range1.length);
        
        
        NSRange range2 = NSMakeRange(range1.location, total_length - range1.location);
        range2 =[signature rangeOfString:@"<h5 class=\"search_user\">" options:NSCaseInsensitiveSearch range:range2];
        
        int finallength = range2.location - range1.location;
        NSRange range3 = NSMakeRange(range1.location, finallength);
        NSString* finalstring = [signature substringWithRange:range3];
        
        
        NSLog(@"THE final string is %@ ",finalstring);
        
        
        [DataSingleton singleton].finalstring= finalstring;
        
        
        //textView.text = signature;
    }

}

- (void)getStockBoardlist:(id)sender withInput:(NSString*)BASE_URL {
    
    UIViewController*
    viewController2 = [[DocList alloc] initWithNibName:@"DocList" bundle:nil];
    [DataSingleton singleton].DocListFirstload = 1;
    [self.navigationController pushViewController:viewController2 animated:YES];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return [[[DataSingleton singleton] UserFavoriteListUrl ]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    {
        if (indexPath.row >= 8) {
            cell.textLabel.textColor  =[UIColor blackColor];
        }else
        {
            cell.textLabel.textColor  =[UIColor orangeColor];
        }
        
        NSString* namestring = [[[DataSingleton singleton] UserFavoriteListName] objectAtIndex:indexPath.row];
        cell.textLabel.text = namestring;//[arrayList objectAtIndex:indexPath.row]; 
    }
    
    return cell;
    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString* longUrl = [[[DataSingleton singleton] UserFavoriteListUrl] objectAtIndex:indexPath.row];
    NSString* fullUrl = [SMTH_BASE_URL stringByAppendingFormat:@"%@",longUrl];
    
    [DataSingleton singleton].Selected_complete_url = fullUrl;
    [DataSingleton singleton].selected_topic_title = [[[DataSingleton singleton] UserFavoriteListName] objectAtIndex:indexPath.row];

    [self getStockBoardlist:self withInput:fullUrl];

    

    

}
-(void)doSuccess:(NSObject *)dict
{
    if([dict isKindOfClass:[NSDictionary class]])
    { 
        return;
    }
    NSLog(@"the return string is %@",dict);
    NSString* dictString = (NSString*)dict;
    NSRange findCookie = [dictString rangeOfString:@"};"];
  
    if (findCookie.length>0) {
        NSRange start = [dictString rangeOfString:@"{"];
       
        
        NSString* substring =[dictString substringFromIndex:start.location];
         NSRange end = [substring rangeOfString:@"};"];
        NSString*substring2 =[substring substringToIndex:end.location+1];
        
        NSMutableDictionary* cookieDict = [substring2 objectFromJSONString];
        
        
        NSArray*keys = [cookieDict allKeys];
        for (int i = 0;i<[keys count];i++) {
            NSString* keystring = [keys objectAtIndex:i];
            NSString* valuestring = [cookieDict objectForKey:keystring];
            
            [[DataSingleton singleton].cookieDictionary setValue:valuestring forKey:keystring];
            
        }
        [DataSingleton singleton].IsCookieSetted = 1;
        NSString* jsonString = [[DataSingleton singleton].cookieDictionary JSONString];
        [DataSingleton singleton].cookieJsonString = (NSMutableString*)jsonString;
        
        [self setcookie];
    }
}


-(void)setcookie
{
    if ([DataSingleton singleton].IsCookieSetted)
    {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        
        
        NSArray *myKeys = [[DataSingleton singleton].cookieDictionary allKeys];
        for (int i = 0;i<myKeys.count; i++) {
            NSString* keystring = [myKeys objectAtIndex:i];
            NSString* valueString = [[DataSingleton singleton].cookieDictionary valueForKey:keystring];
            [cookieProperties setObject:valueString forKey:keystring];
            NSLog(@"The cookie value is %@",valueString);
        }
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        
    }
    
}
-(void)doFail:(NSString *)msg
{
    NSLog(@"this is do fail");
}
-(void)doNetWorkFail
{
    NSLog(@"This is NetWork fail");
}

@end
