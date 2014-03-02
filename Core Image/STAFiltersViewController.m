//
//  STAFiltersViewController.m
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STAFiltersViewController.h"
#import "STAFilterManager.h"
#import "STACoreImageFilter.h"

@interface STAFiltersViewController ()

@property (nonatomic, strong) NSArray *filters;

@end

@implementation STAFiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.filters = [[STAFilterManager sharedInstance] availableCoreImageFilters];

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.filters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"STAFiltersCellIndentifier";

    STACoreImageFilter *aFilter = [self.filters objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = aFilter.name;

    cell.accessoryType = UITableViewCellAccessoryNone;

    if (aFilter.isActive)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellAccessoryType cellType = [tableView cellForRowAtIndexPath:indexPath].accessoryType;

    [self toggleFilterAtIndexPath:indexPath];

    [tableView cellForRowAtIndexPath:indexPath].accessoryType = cellType ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
}

- (void)toggleFilterAtIndexPath:(NSIndexPath *)indexPath
{
    STACoreImageFilter *anFilter = [self.filters objectAtIndex:indexPath.row];

    [anFilter toggleActive];
}

@end
