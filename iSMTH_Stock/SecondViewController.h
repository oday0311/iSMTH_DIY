//
//  SecondViewController.h
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController {
    UIWebView *webview;
}

@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)testAction:(id)sender;

@end
