//
//  AppAboutViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 12-10-20.
//
//

#import "AppAboutViewController.h"

@interface AppAboutViewController ()

@end

@implementation AppAboutViewController

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
    
    // Do any additional setup after loading the view from its nib.
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

@end
