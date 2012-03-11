//
//  FirstViewController.m
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "MyHttp_remoteClient.h"
#import "DataSingleton.h"
#import "constant.h"
#import "SecondViewController.h"
#import "DocList.h"

@implementation FirstViewController
@synthesize tableref;
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
      
}

- (void)viewDidUnload
{
    [self setTextView:nil];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
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
        
        
        textView.text = signature;
    }

}

- (IBAction)getStockBoardlist:(id)sender {
    
    MyHttp_remoteClient * httpclient = [[MyHttp_remoteClient alloc] init];
    NSString*signature = [httpclient httpSendRequest:GET_STOCKBOARD_LIST];
    int total_length = signature.length;
    if (total_length > 10) {
                
        [DataSingleton singleton].stockBoardlist = signature;
        textView.text = signature;
    }
    UIViewController*
    viewController2 = [[DocList alloc] initWithNibName:@"DocList" bundle:nil];
    [self.navigationController pushViewController:viewController2 animated:YES];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;//[arrayList count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    {
        cell.textLabel.textColor  =[UIColor orangeColor];
        cell.textLabel.text = @"STOCK";//[arrayList objectAtIndex:indexPath.row]; 
    }
    
    return cell;
    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self getStockBoardlist:self];
}

@end
