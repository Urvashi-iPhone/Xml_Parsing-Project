//
//  ViewController.m
//  XML_parser
//
//  Created by Tecksky Techonologies on 12/20/16.
//  Copyright © 2016 Tecksky Technologies. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"
#import "DataTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc] init];
    
    NSURL *URL = [[NSURL alloc] initWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.lvfIZxH3.dpuf"];
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"string: %@", xmlString);
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
    
    dataArray = [[xmlDoc valueForKey:@"channel"] valueForKey:@"item"];
    
    NSLog(@"dictionary: %@", xmlDoc);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *table = @"cell";
    
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    //ipad tablview clear color
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
        
        
    }
    NSDictionary *item = [dataArray objectAtIndex:indexPath.row];
    cell.title.text = [item valueForKey:@"title"];
    cell.link.text = [item valueForKey:@"link"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
