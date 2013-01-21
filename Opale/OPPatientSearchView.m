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

@synthesize searchResults, cellFirstName, cellLastName, cellTel, cellAddress, cellTown, cellPostalCode, cellCountry, colFirstName, colLastName, colTel1, colTel2,  colAddress, colTown, colPostalCode, colCountry, resultsTable;

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [resultsTable setDoubleAction:@selector(selectPatient:)];
    searchResults = [[NSMutableArray alloc] init];
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
    
    if([[cellTown stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(town LIKE[c] '%@')", cellTown.stringValue];
    }
    
    if([[cellPostalCode stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(postalCode LIKE[c] '%@')", cellPostalCode.stringValue];
    }
    
    if([[cellCountry stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(country LIKE[c] '%@')", cellCountry.stringValue];
    }
    
    if([predicateFormat length] > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
        [request setPredicate:predicate];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if (array == nil)
    {
        // TODO deal with error
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
    
    if(tableColumn == colFirstName){
        return value = [[NSString alloc] initWithString:patient.firstName];
    }
    else if(tableColumn == colLastName){
        return value = [[NSString alloc] initWithString:patient.lastName];
    }
    else if(tableColumn == colTel1){
        return value = [[NSString alloc] initWithString:patient.tel1];
    }
    else if(tableColumn == colTel2){
        return value = [[NSString alloc] initWithString:patient.tel2];
    }
    else if(tableColumn == colAddress){
        return value = [[NSString alloc] initWithString:patient.address];
    }
    else if(tableColumn == colTown){
        return value = [[NSString alloc] initWithString:patient.town];
    }
    else if(tableColumn == colPostalCode){
        return value = [[NSString alloc] initWithString:patient.postalCode];
    }
    else if(tableColumn == colCountry){
        return value = [[NSString alloc] initWithString:patient.country];
    }
    
    return value;
}

@end
