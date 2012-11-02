//
//  OPExistingPatientView.m
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPExistingPatientView.h"
#import "OPMainWindow.h"
#import "OPPatient.h"
#import "OPConsultation.h"

@implementation OPExistingPatientView

@synthesize patient, sortedConsultations, cellFirstName, cellLastName, cellBirthday, cellSex, cellTel1, cellTel2, cellAddress, consultationHistoryTable, colDate, colMotives;

- (void)awakeFromNib{
    
    [consultationHistoryTable setDoubleAction:@selector(showConsultation:)];
    
    sortedConsultations = [[NSMutableArray alloc] init];
    [colDate setIdentifier:@"date"];
    [colMotives setIdentifier:@"motives"];
}

-(void)loadPatient:(OPPatient*)patientToLoad{
    
    patient = patientToLoad;
    
    [cellFirstName setStringValue:[[NSString alloc] initWithString:patient.firstName]];
    [cellLastName setStringValue:[[NSString alloc] initWithString:patient.lastName]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setLocale:frLocale];
    
    [cellBirthday setStringValue: [dateFormatter stringFromDate:patient.birthday]];
    
    [cellSex setStringValue:[[NSString alloc] initWithString:patient.sex]];
    [cellTel1 setStringValue:[[NSString alloc] initWithString:patient.tel1]];
    [cellTel2 setStringValue:[[NSString alloc] initWithString:patient.tel2]];
    [cellAddress setStringValue:[[NSString alloc] initWithString:patient.address]];
    
    [self sortConsultations];
}

#pragma mark - Actions

-(IBAction)savePatient:(id)sender{
    
    //TODO save modifications
    
    [self saveAction];
}

#pragma mark - Consultations management

-(void)sortConsultations{
    [sortedConsultations removeAllObjects];
    [sortedConsultations addObjectsFromArray:[patient.consultations allObjects]];
    
    //TODO SORT
    
    [consultationHistoryTable reloadData];
}

-(IBAction)newConsultation:(id)sender{
    OPConsultation* nConsultation = [NSEntityDescription insertNewObjectForEntityForName:@"Consultation" inManagedObjectContext:[self managedObjectContext]];
    
    nConsultation.patient = patient;
    nConsultation.date = [NSDate date];
    
    [self saveAction];
    
    [parent showConsultationViewFor:nConsultation];
    [sortedConsultations addObject:nConsultation];
    
    [consultationHistoryTable reloadData];
}

-(IBAction)showConsultation:(id)sender{
    
    OPConsultation* consultation = (OPConsultation*)[[patient.consultations allObjects] objectAtIndex:consultationHistoryTable.selectedRow];
    
    [parent showConsultationViewFor:consultation];
}

#pragma mark - Result table content management

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    
    if (sortedConsultations){
        count = [sortedConsultations count];
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:row];
    
    NSString* value = [[NSString alloc] init];
    
    //TODO load motives summary
    
    if([[tableColumn identifier] isEqualToString:colDate.identifier]){
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        value = [dateFormatter stringFromDate:[consultation valueForKey:tableColumn.identifier]];
    }else if([[tableColumn identifier] isEqualToString:colMotives.identifier]){
        NSString* testValue = [consultation valueForKey:@"tests"];
        
        if(testValue){
            value = [consultation valueForKey:@"tests"];
        }
        else{
            value = @"TODO";
        }
    }
    
    return value;
}

@end
