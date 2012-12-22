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
#import "OPDocument.h"

@implementation OPExistingPatientView

@synthesize patient, sortedConsultations, cellFirstName, cellLastName, cellBirthday, cellSex, cellTel1, cellTel2, cellAddress, consultationHistoryTable, colDate, colMotives, documentsTable, colDocumentTitle, colDocumentFilePath;

- (void)awakeFromNib{
    
    [consultationHistoryTable setDoubleAction:@selector(showConsultation:)];
    sortedConsultations = [[NSMutableArray alloc] init];
    [colDate setIdentifier:@"date"];
    [colMotives setIdentifier:@"motives"];
    
    //[documentsTable setDoubleAction:@selector(openDocument:)];
    [colDocumentTitle setIdentifier:@"title"];
    [colDocumentFilePath setIdentifier:@"docPath"];
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

-(IBAction)scanDocument:(id)sender{
    [parent showScanningView:self];
}

#pragma mark - Consultations management

-(void)sortConsultations{
    //[sortedConsultations addObjectsFromArray:[patient.consultations allObjects]];
    NSArray* consultations = [patient.consultations allObjects];
    
    sortedConsultations = [consultations sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OPConsultation* consultation1 = (OPConsultation*) obj1;
        OPConsultation* consultation2 = (OPConsultation*) obj2;
        
        return [consultation1.date compare:consultation2.date];
    }];
    
    [consultationHistoryTable reloadData];
}


-(IBAction)newConsultation:(id)sender{
    OPConsultation* nConsultation = [NSEntityDescription insertNewObjectForEntityForName:@"Consultation" inManagedObjectContext:[self managedObjectContext]];
    
    nConsultation.patient = patient;
    nConsultation.date = [NSDate date];
    
    [self saveAction];
    
    [parent showConsultationViewFor:nConsultation];
    
    [self sortConsultations];
    
    [consultationHistoryTable reloadData];
}

-(IBAction)showConsultation:(id)sender{
    OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:consultationHistoryTable.selectedRow];
    [parent showConsultationViewFor:consultation];
}

#pragma mark - Result table content management

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    
    if(tableView == consultationHistoryTable){
        if (sortedConsultations){
            count = [sortedConsultations count];
        }
    }
    else if(tableView == documentsTable){
        if(documentsTable){
            count = [[patient.documents allObjects] count];
        }
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString* value = [[NSString alloc] init];
    
    //TODO load motives summary
    
    if(tableView == consultationHistoryTable){
        
        OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:row];
        
        if([[tableColumn identifier] isEqualToString:colDate.identifier]){
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            value = [dateFormatter stringFromDate:consultation.date];
        }
        else if([[tableColumn identifier] isEqualToString:colMotives.identifier]){
            NSString* testValue = consultation.tests;
            
            if(testValue){
                value = consultation.tests;
            }
            else{
                value = @"TODO";
            }
        }
    }
    else if(tableView == documentsTable){
        
        OPDocument* document = (OPDocument*)[[patient.documents allObjects] objectAtIndex:row];
        
        if([[tableColumn identifier] isEqualToString:colDocumentTitle.identifier]){
            NSURL* documentURL = [NSURL fileURLWithPath:document.filePath];
            value = [[documentURL lastPathComponent] stringByDeletingPathExtension];
        }
        else if ([[tableColumn identifier] isEqualToString:colDocumentFilePath.identifier]){
            value = document.filePath;
        }
    }
    
    return value;
}

@end
