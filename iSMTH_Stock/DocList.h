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
@interface DocList : UIViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>
{
    //EGORefreshTableHeaderView *_refreshHeaderView;
    UITableView *_tableref;
     NSMutableArray *arrayList;
    
    NSMutableArray *arrayList_link;
    
    
    BOOL _reloading;
    
    
    DataSingleton* dataRecorder;
}
@property (strong, nonatomic) IBOutlet UITableView *tableref;

@end
