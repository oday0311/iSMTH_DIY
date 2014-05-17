//
//  AppAboutViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 12-10-20.
//
//

#import "AppAboutViewController.h"
#import "imageCacheManager.h"
#import "introductionViewController.h"
#import "UMFeedback.h"
#import "constant.h"
#import "accountViewController.h"
#import "BaiduShiTuViewController.h"

@interface AppAboutViewController ()
@end

@implementation AppAboutViewController
@synthesize tableref;

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"关于", @"关于");
        self.tabBarItem.image = [UIImage imageNamed:@"about"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
    
    self.tableref.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
    
    
    
    UIImage* temp = [UIImage imageNamed:@"smthLogo.png"];
    self.imageView.image = temp;
    

  
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.topItem.title = @"关于";

    [super viewDidAppear:animated];
        
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setTableref:nil];
    [self setTestLabel:nil];
    [super viewDidUnload];
}

-(void)httploginFuntion
{
    //login address: http://www.newsmth.net/nForum/user/ajax_login.json
    
    //httpClient=[[HttpClient alloc] initWithDelegate:self];
    //[httpClient loginToSmth];
}

-(void)httpCookieFuntion
{
    
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    [httpClient requestWithCookie];
}
- (IBAction)login:(id)sender {
    
    [self httploginFuntion];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;//[self.dataSourceArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
    
    static NSString *kDisplayCell_ID = @"DisplayCellID";
    cell = [tableref dequeueReusableCellWithIdentifier:kDisplayCell_ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
  
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
    
    
    if (indexPath.row==0) {

        cell.textLabel.text = @"关于水木社区 www.newsmth.net";

    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text  = @"当前版本   1.1.0";
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"意见反馈";
    }
    else if(indexPath.row == 3)
    {
        cell.textLabel.text  = @"帐号登陆";
    }
   
    else if(indexPath.row == 4)
    {
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"百度网图识别工具";
    }
    else if(indexPath.row ==5)
    {
        cell.textLabel.text =@"管理登陆";
    }
    else if(indexPath.row == 6)
    {
        cell.textLabel.text = @"test http function with cookie";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIViewController*
        viewController2 = [[introductionViewController alloc] initWithNibName:@"introductionViewController" bundle:nil];
        [self.navigationController pushViewController:viewController2 animated:YES];
    }
        else if(indexPath.row == 1)
    {
    
    }
    else if (indexPath.row == 2)
    {
        [UMFeedback showFeedback:self withAppkey:UMENG_ID];
        
    }
    else if(indexPath.row ==3)
    {
        //
        UIViewController*
        viewController2 = [[accountViewController alloc] initWithNibName:@"accountViewController" bundle:nil];
        [self.navigationController pushViewController:viewController2 animated:YES];
    }
   
    else if (indexPath.row == 4)
    {
        [self startBaiduShiTuView];
    }
    else if(indexPath.row == 5)
    {
        
        [self httploginFuntion];
    }
    else if(indexPath.row ==6)
    {
        [self httpCookieFuntion];
    }
}
-(void)startBaiduShiTuView
{
    BaiduShiTuViewController* controller =
     [[BaiduShiTuViewController alloc] initWithNibName:@"BaiduShiTuViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)setCookie:(NSString*)cookieString
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    [httpClient setCookie:cookieString];
}
///////////////////////////////////////////
-(void)doSuccess:(NSObject *)dict
{
    if ([dict isKindOfClass:[NSString class]]) {
        NSLog(@"The return string is %@", dict);
    }
    else if([dict isKindOfClass:[NSMutableDictionary class]])
    {
        NSString* dataString = [dict valueForKey:@"data"];
        NSString* cookieString = [DataSingleton singleton].cookieJsonString;
        [self setCookie:cookieString];
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

- (IBAction)Test:(id)sender {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    
    
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"data count from plist is %d ",[dataDictionary count]);
    self.testLabel.text  = [@"" stringByAppendingFormat:@" the count is %d" , [dataDictionary count]];
    
    NSArray* keys = [dataDictionary allKeys];
    for (int i = 0;i<[keys count];i++) {
        NSString* tempkey = [keys objectAtIndex:i];
        NSString* tempstring = [dataDictionary objectForKey:tempkey];
        NSLog(@"data %d is string %@", i, tempstring);
    }
    
    
    [dataDictionary setObject:@"content" forKey:@"item4"];
    
    
   
   
    {
         NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [dataDictionary writeToFile:path atomically:YES];
        
        NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSLog(@"%@", data1);

    }
}
@end
