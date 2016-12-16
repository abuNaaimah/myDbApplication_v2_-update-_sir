//
//  ViewController.m
//  myDbApplication
//
//  Created by tops on 9/1/16.
//  Copyright © 2016 tops. All rights reserved.
//

#import "ViewController.h"
#import "dbHandller.h"

#import "EditViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UITableView *_tblViewInfo;
    dbHandller * databaseObject;
    NSMutableArray * arrdata;
}
@property (weak, nonatomic) IBOutlet UITextField *txtId;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    [self displayData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    databaseObject = [[dbHandller alloc]init];
  //arrdata=  [databaseObject QueryRun:@"SELECT * from tblinfo"];
    [self displayData];
      // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnSaveAction:(id)sender {
    
    NSString *strQuery = [NSString stringWithFormat:@"INSERT INTO tblinfo (infoid, name, age) VALUES (%@,'%@',%@)",self.txtId.text,self.txtName.text,self.txtAge.text];
    
    if([databaseObject CommandRun:strQuery])
    {
        NSLog(@"Insert Completed! :)");
     //arrdata=   [databaseObject QueryRun:@"SELECT * from tblinfo"];
    }
    else{
        NSLog(@"Insert not Complated! :(");
    }
    [self displayData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual:@"gotodetails"])
    {
        int infoid = 0;
        NSIndexPath *indexPath= [_tblViewInfo  indexPathForSelectedRow];
        NSMutableDictionary *d =[arrdata objectAtIndex:indexPath.row];
        infoid = [[d objectForKey:@"InfoID"] intValue];
        NSLog(@"%d",infoid);
        
        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
    
        editViewController.infoid = infoid;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSMutableDictionary *d = [arrdata objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text=[d objectForKey:@"InfoID"];
    cell.textLabel.text=[d objectForKey:@"Name"];
    return cell;
}
-(void) displayData
{
    
    arrdata =   [databaseObject QueryRun:@"SELECT * from tblinfo"];
    
    [_tblViewInfo reloadData];
}

@end
