//
//  AppAboutViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 12-10-20.
//
//

#import "AppAboutViewController.h"
#import "imageCacheManager.h"

@interface AppAboutViewController ()

@end

@implementation AppAboutViewController
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
    
    
    
    UIImage* temp = [self getImageFromURL:@"http://att.newsmth.net/nForum/att/Picture/77274/551/large"];
    self.imageView.image = temp;
    
    //[imageCacheManager setImageView:self.imageView withUrlString:@"http://www.btsmth.com/attachments/1349.77274.551.jpg"];
  
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"hi";
    self.navigationController.navigationItem.title=@"hello";
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
