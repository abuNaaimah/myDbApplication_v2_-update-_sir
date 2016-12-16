//
//  dbHandller.m
//  myDbApplication
//
//  Created by tops on 9/1/16.
//  Copyright © 2016 tops. All rights reserved.
//

#import "dbHandller.h"
@implementation dbHandller

//main initilization action of this class
-(id) init{
    
    if(self==[super init])
    {
        //create appdelegate object instance for get db path from it
        delObj = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        //copy db path
        self.strdbPath = delObj.strDbSource;
        NSLog(@"Path from db:%@",self.strdbPath);
    }
    return self;
}


//this method is use for insert, update and delete in table
-(BOOL)CommandRun:(NSString *)strQuery{
    
    //by default status is false when any task is performed well than it become true else return false
    BOOL status = false;
    
    //this method is open database file for read and write from path and assign its instance to db object
    if(sqlite3_open([self.strdbPath UTF8String],&db) == SQLITE_OK)
    {
        //create sql statement for execute your query or command on database
        sqlite3_stmt *statment;
        
        //this will check is your query is executable or not
        if(sqlite3_prepare_v2(db, [strQuery UTF8String], -1, &statment, nil)==SQLITE_OK)
        {
            //now your query is executed
            sqlite3_step(statment);
            
            status = true;
        }
        
        //now reliz statment
        sqlite3_finalize(statment);
    }
    sqlite3_close(db);
    
    return status;
}
-(NSMutableArray *)QueryRun:(NSString *)strQuery{
    
    NSMutableArray *arrData = [[NSMutableArray alloc]init];
    //this method is open database file for read and write from path and assign its instance to db object
    if(sqlite3_open([self.strdbPath UTF8String],&db) == SQLITE_OK)
    {
        //create sql statement for execute your query or command on database
        sqlite3_stmt *statment;
        
        //this will check is your query is executable or not
        if(sqlite3_prepare_v2(db, [strQuery UTF8String], -1, &statment, nil)==SQLITE_OK)
        {
            //now your query is executed
            while(sqlite3_step(statment)==SQLITE_ROW)
            {
                NSString *strNo =[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statment, 0)];
                 NSString *strName =[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statment, 1)];
                 NSString *strAge =[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statment, 2)];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setObject:strNo forKey:@"InfoID"];
                [dict setObject:strName forKey:@"Name"];
                [dict setObject:strAge forKey:@"Age"];
                
                [arrData addObject:dict];
                            }
            
            
        }
        
        //now reliz statment
        sqlite3_finalize(statment);
    }
    sqlite3_close(db);
    NSLog(@"\n\n\tData is :\t%@",arrData);

    return arrData;
}
@end
