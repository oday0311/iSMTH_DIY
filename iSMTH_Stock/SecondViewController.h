//
//  SecondViewController.h
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    UIWebView *webview;
    UITableView *tableref;
    
    
    
    UISearchBar* mysearchBar;
    
    NSMutableArray* searchResult;
    
}
-(void)getSearchResult:(NSString*)inputstring;


@property (strong, nonatomic) IBOutlet UIWebView *webview;

@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
