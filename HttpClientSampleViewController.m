

#import "HttpClientSampleViewController.h"

@interface HttpClientSampleViewController ()

@end

@implementation HttpClientSampleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - Flipside View Controller




- (IBAction)showInfo:(id)sender
{
    
}

- (IBAction)testHttp:(id)sender {
}



-(void)doSuccess:(NSDictionary *)dict
{
    NSLog(@"this is do success");
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
