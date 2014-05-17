//
//  accountViewController.m
//  iSMTH_DIY
//
//  Created by Alex on 10/31/12.
//
//

#import "accountViewController.h"

@interface accountViewController ()

@end

@implementation accountViewController
@synthesize httpClient;
-(void)httploginFuntion
{
    //login address: http://www.newsmth.net/nForum/user/ajax_login.json
    
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    
    NSString* accoutString = self.accoutField.text;
    NSString* passwordStrig = self.passWordField.text;
    if (accoutString.length > 0 && passwordStrig.length >0) {
        [httpClient loginToSmth:accoutString  withPassWordString:passwordStrig];

    }
}

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
    // Do any additional setup after loading the view from its nib.
    
    self.textView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [self setAccoutField:nil];
    [self setPassWordField:nil];
    [super viewDidUnload];
}
- (IBAction)loginAction:(id)sender {
    [self httploginFuntion];
}


///////////////////////////////////////////
-(void)setCookie:(NSString*)cookieString
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    [httpClient setCookie:cookieString];
}
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
@end
