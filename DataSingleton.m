//
//  DataSingleton.m
//  tableview
//
//  Created by Alex on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton
@synthesize finalstring;
@synthesize stockBoardlist;
@synthesize topic_detail_link;



static DataSingleton * MyCommon_Singleton = nil;

+ (DataSingleton *)singleton

{
    
    @synchronized(self)
    {
        if  (MyCommon_Singleton  ==  nil)
        {
            MyCommon_Singleton=[[DataSingleton alloc] init] ;
            MyCommon_Singleton.finalstring = @"init";
        }
    }
    
    return  MyCommon_Singleton;
    
}
+  (id)allocWithZone:(NSZone  * )zone
{
    @synchronized(self)
    {
        if (MyCommon_Singleton  ==  nil)
        {
            MyCommon_Singleton  =  [super allocWithZone:zone];
            return  MyCommon_Singleton;
        }
    }
    
    return  nil;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}







-(void)dealloc
{
  
    //[super dealloc];
}

@end
