//
//  OPProfessionalSearchView.m
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPProfessionalSearchView.h"

@implementation OPProfessionalSearchView

static NSString* groupName = @"Professionnels de santé";

@synthesize pickerView;

-(void)awakeFromNib{
    
    //Get professional group
    ABAddressBook* addresses = [ABAddressBook sharedAddressBook];
    ABSearchElement *proGroupSearchElement =[ABGroup searchElementForProperty:kABGroupNameProperty label:nil key:nil value:groupName comparison:kABEqualCaseInsensitive];
    NSArray *groupsFound = [addresses recordsMatchingSearchElement:proGroupSearchElement];
    
    ABGroup* proGroup = 0;
    
    if([groupsFound count]){
        proGroup = [groupsFound objectAtIndex:0];
    }
    else{
        proGroup = [[ABGroup alloc] initWithAddressBook:addresses];
        [proGroup setValue:groupName forProperty:kABGroupNameProperty];
        [addresses save];
    }
    
    //Initialize picker view
    [pickerView selectGroup:proGroup byExtendingSelection:NO];
}

@end
