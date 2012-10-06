//
//  OPPatientSearchView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPPatientSearchView.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPPatient.h"

@implementation OPPatientSearchView

@synthesize searchResults, cellFirstName, cellLastName, cellTel, cellAddress, colFirstName, colLastName, colTel1, colTel2, colLastVisit, resultsTable;

- (void)awakeFromNib{
    
    [resultsTable setDoubleAction:@selector(selectPatient:)];
    
    searchResults = [[NSMutableArray alloc] init];
    [colFirstName setIdentifier:@"firstName"];
    [colLastName setIdentifier:@"lastName"];
    [colTel1 setIdentifier:@"tel1"];
    [colTel2 setIdentifier:@"tel2"];
    [colLastVisit setIdentifier:@"lastVisit"];
}

-(IBAction)searchPatients:(id)sender{
    [searchResults removeAllObjects];
    
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Patient" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSString* predicateFormat = [[NSString alloc] init];
    
    if([[cellFirstName stringValue] length] > 0){
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(firstName LIKE[c] '%@')", cellFirstName.stringValue];
    }
    
    if([[cellLastName stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(lastName LIKE[c] '%@')", cellLastName.stringValue];
    }
    
    if([[cellTel stringValue] length] > 0){
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(tel1 LIKE[c] '%@' OR tel2 LIKE[c] '%@')", cellTel.stringValue, cellTel.stringValue];
    }
    
    if([[cellAddress stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(address LIKE[c] '%@')", cellAddress.stringValue];
    }
    
    if([predicateFormat length] > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
        [request setPredicate:predicate];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if (array == nil)
    {
        // TODO deal with error...
    }
    else{
        [searchResults addObjectsFromArray:array];
    }
    
    [resultsTable reloadData];
}

-(IBAction)selectPatient:(id)sender{
    OPPatient* patient = [searchResults objectAtIndex:resultsTable.clickedRow];
    [parent showPatientViewFor:patient];
}


#pragma mark - Result table content management

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    
    if (searchResults){
        count = [searchResults count];
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    OPPatient* patient = [searchResults objectAtIndex:row];
    
    NSString* value = nil;
    
    if(![tableColumn.identifier isEqualToString:@"lastVisit"]){
        value = [patient valueForKey:tableColumn.identifier];
    }
    else{
        value = @"TODO";
    }
    
    return value;
}

@end
