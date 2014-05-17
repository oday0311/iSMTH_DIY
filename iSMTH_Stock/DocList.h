//
//  DocList.h
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "DataSingleton.h"
#import "topic.h"
#import "HttpClient.h"
#import "MBProgressHUD.h"

@interface DocList : UIViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource,
MBProgressHUDDelegate
,HttpClientDelegate>
{
    //EGORefreshTableHeaderView *_refreshHeaderView;
    UITableView *_tableref;
    NSMutableArray *arrayList;
    NSMutableArray *arrayList_link;
    
    
    BOOL _reloading;
    
    
    DataSingleton* dataRecorder;
    
    
    ///////////////////
    MBProgressHUD *HUD;
    HttpClient                      *httpClient;
}
@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
