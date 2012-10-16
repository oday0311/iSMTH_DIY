//
//  TempViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 12-10-16.
//
//

#import "TempViewController.h"
#import "AppDelegate.h"
@interface TempViewController ()

@end

@implementation TempViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate*appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate] ;
    [appdelegate.navigationController popViewControllerAnimated:YES];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
