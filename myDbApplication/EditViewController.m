//
//  EditViewController.m
//  myDbApplication
//
//  Created by tops on 9/1/16.
//  Copyright © 2016 tops. All rights reserved.
//

#import "EditViewController.h"

#import "dbHandller.h"


@interface EditViewController ()
{
    dbHandller * databaseObject;
    NSMutableArray * arrdata;

}
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtInfoId;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@end

@implementation EditViewController
@synthesize infoid;
- (IBAction)btndeleteaction:(UIButton *)sender {
    NSString *strQuery= [NSString stringWithFormat:@"DELETE from tblinfo where infoid = %@",self.txtInfoId.text];
    [databaseObject CommandRun:strQuery];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnEditAction:(id)sender {
    
    NSString *strQuery=[NSString stringWithFormat:@"UPDATE tblinfo set  name='%@', age=%@ where infoid = %@",self.txtName.text,self.txtAge.text,self.txtInfoId.text];
    [databaseObject CommandRun:strQuery];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //if([databaseObject CommandRun:strQuery])
    //{
    //    NSLog(@"Update Done!");
    //    [self dismissViewControllerAnimated:YES completion:nil];
    // }
    //else{
    //    NSLog(@"Update not done!");
    //}
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    databaseObject = [[dbHandller alloc]init];
    arrdata =   [databaseObject QueryRun:[NSString stringWithFormat:@"SELECT * from tblinfo where infoid=%d",self.infoid]];
    
    NSLog(@"data for edit is %@",arrdata);
    NSMutableDictionary *dict = [arrdata objectAtIndex:0];
    
    [self.txtInfoId setText:[dict objectForKey:@"InfoID"]];
    [self.txtName setText:[dict objectForKey:@"Name"]];
    [self.txtAge setText:[dict objectForKey:@"Age"]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btngoBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
