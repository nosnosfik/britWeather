//
//  StationsTableViewController.m
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import "StationsTableViewController.h"
#import "StationTableViewCell.h"

static NSString *const stationsURL = @"https://data.gov.uk/dataset/historic-monthly-meteorological-station-data/datapackage.json";

@interface StationsTableViewController ()

@property(strong,nonatomic) NSDictionary *stations;
@property(strong,nonatomic) NSArray *stationsTitles;

@end

@implementation StationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"stationCell" bundle:nil] forCellReuseIdentifier:@"stationCell"];
    
    WebDataProcessing *client = [WebDataProcessing sharedManager];
   
    client.delegate = self;
    
    [client getWebData:stationsURL];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(!self.stationsTitles)
        return 0;
    
    return [self.stationsTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    StationTableViewCell *cell = (StationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"stationCell"];

    StationData *stationData = self.stationsTitles[indexPath.row];
    
    cell.stationName.text = stationData.stationDescription;

    return cell;
}

-(void)webDataProcessing:(WebDataProcessing *)client didUpdateWithStations:(id)stations{
    
    self.stations = [stations objectForKey:@"resources"];
    
    NSMutableArray *mta = [NSMutableArray new];
    for (id station in self.stations) {
        
        StationData *britStation =[StationData new];
        
        NSString *formatString = [NSString stringWithFormat:@"%@",[station objectForKey:@"path"]];
        NSString *txtString = [formatString substringFromIndex:5];
        
        britStation.stationDescription = [NSString stringWithFormat:@"%@",[station objectForKey:@"description"]];
        britStation.stationWebPath = txtString;
    
        [mta addObject:britStation];
    }

    [mta removeObjectsInRange:NSMakeRange(0, 2)];
 
    self.stationsTitles = mta;
    
    [self.tableView reloadData];
    
}

-(void)webDataProcessing:(WebDataProcessing *)client didFailWithError:(NSError *)error{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Stations Error" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
