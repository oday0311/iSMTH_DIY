//
//  accountViewController.h
//  iSMTH_DIY
//
//  Created by Alex on 10/31/12.
//
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
@interface accountViewController : UIViewController<HttpClientDelegate>
{
     HttpClient                      *httpClient;
}
@property(nonatomic, retain)HttpClient* httpClient;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *accoutField;

@property (weak, nonatomic) IBOutlet UITextField *passWordField;

- (IBAction)loginAction:(id)sender;

@end
