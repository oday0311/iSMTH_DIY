//
//  FirstViewController.h
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,HttpClientDelegate> {
    //UITextView *textView;
    UINavigationController* nav;
    UITableView *tableref;
    
    
    
    NSArray* boardnamelist;
}

- (IBAction)getSignature:(id)sender;
- (IBAction)getStockBoardlist:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
