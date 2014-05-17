//
//  AppAboutViewController.h
//  iSMTH_DIY
//
//  Created by Apple on 12-10-20.
//
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface AppAboutViewController : UIViewController<HttpClientDelegate>
{
     HttpClient                      *httpClient;
}

- (IBAction)Test:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableref;


@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)login:(id)sender;

@end
