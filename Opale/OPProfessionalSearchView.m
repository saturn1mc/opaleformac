//
//  OPProfessionalSearchView.m
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPProfessionalSearchView.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPProfessional.h"

@implementation OPProfessionalSearchView

@synthesize searchResults, cellFirstName, cellLastName, cellSpeciality, cellTel, cellAddress, cellTown, cellPostalCode, cellCountry, colFirstName, colLastName, colSpeciality, colTel,  colAddress, colTown, colPostalCode, colCountry, resultsTable;

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [resultsTable setDoubleAction:@selector(selectPatient:)];
    searchResults = [[NSMutableArray alloc] init];
}

-(IBAction)searchProfessional:(id)sender{
    [searchResults removeAllObjects];
    
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Professional" inManagedObjectContext:moc];
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
    
    if([[cellSpeciality stringValue] length] > 0){
        
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(speciality LIKE[c] '%@')", cellSpeciality.stringValue];
    }
    
    if([[cellTel stringValue] length] > 0){
        if([predicateFormat length] > 0){
            predicateFormat = [predicateFormat stringByAppendingString:@" AND "];
        }
        
        predicateFormat = [predicateFormat stringByAppendingFormat:@"(tel LIKE[c] '%@')", cellTel.stringValue];
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

-(IBAction)selectProfessional:(id)sender{
    OPProfessional* professional = [searchResults objectAtIndex:resultsTable.clickedRow];
    [parent showProfessionalViewFor:professional];
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
    
    OPProfessional* professional = [searchResults objectAtIndex:row];
    
    NSString* value = nil;
    
    if(tableColumn == colFirstName){
        return value = [[NSString alloc] initWithString:professional.firstName];
    }
    else if(tableColumn == colLastName){
        return value = [[NSString alloc] initWithString:professional.lastName];
    }
    else if(tableColumn == colSpeciality){
        return value = [[NSString alloc] initWithString:professional.speciality];
    }
    else if(tableColumn == colTel){
        return value = [[NSString alloc] initWithString:professional.tel];
    }
    else if(tableColumn == colAddress){
        return value = [[NSString alloc] initWithString:professional.address];
    }
    else if(tableColumn == colTown){
        return value = [[NSString alloc] initWithString:professional.town];
    }
    else if(tableColumn == colPostalCode){
        return value = [[NSString alloc] initWithString:professional.postalCode];
    }
    else if(tableColumn == colCountry){
        return value = [[NSString alloc] initWithString:professional.country];
    }
    
    return value;
}

@end
