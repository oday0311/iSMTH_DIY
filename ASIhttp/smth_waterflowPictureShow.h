//
//  ViewController.h
//  WaterFlowDisplay
//
//  Created by B.H. Liu on 12-3-29.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterflowView.h"
#import "HttpClient.h"

@interface smth_waterflowPictureShow : UIViewController<WaterflowViewDelegate,WaterflowViewDatasource,UIScrollViewDelegate,HttpClientDelegate>
{
    int count;
    WaterflowView *flowView;
     UILabel* PagelabelView;
    
    ///////////////////////////////////
    NSMutableDictionary*  matchDictionary;
    HttpClient                      *httpClient;
    
    
    UIButton* categoryButton;
    
    
    //////////////
    NSMutableArray* picPostDetailUrlArray;
}

@property(nonatomic, retain)UIButton*categoryButton;
@property(nonatomic,retain) NSMutableArray* picPostDetailUrlArray;
@property(nonatomic,retain) NSMutableDictionary*  matchDictionary;
- (CGFloat)flowView:(WaterflowView *)flowView heightForCellAtIndex:(NSInteger)index;
@end
