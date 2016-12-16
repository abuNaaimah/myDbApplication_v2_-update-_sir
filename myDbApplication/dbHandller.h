//
//  dbHandller.h
//  myDbApplication
//
//  Created by tops on 9/1/16.
//  Copyright © 2016 tops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <sqlite3.h>

@interface dbHandller : NSObject
{
    sqlite3 *db;
    AppDelegate *delObj;
}

@property(strong,nonatomic) NSString * strdbPath;

//insert update delete
-(BOOL) CommandRun:(NSString *) strQuery;

//select
-(NSMutableArray *) QueryRun:(NSString *) strQuery;
@end
