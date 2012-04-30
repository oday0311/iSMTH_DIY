//
//  FirstViewController.h
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITextView *textView;
    UINavigationController* nav;
    UITableView *tableref;
    
    
    
    NSArray* boardnamelist;
}

@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)getSignature:(id)sender;
- (IBAction)getStockBoardlist:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
