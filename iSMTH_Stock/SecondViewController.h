//
//  SecondViewController.h
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UIWebView *webview;
    UITableView *tableref;
}
-(void)getSearchResult:(NSString*)inputstring;

@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)testAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
