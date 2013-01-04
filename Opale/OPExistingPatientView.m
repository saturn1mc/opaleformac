//
//  OPExistingPatientView.m
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPExistingPatientView.h"
#import "OPMainWindow.h"
#import "OPScanningView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPDocument.h"
#import "OPMail.h"

@implementation OPExistingPatientView

@synthesize patient, sortedConsultations, cellFirstName, cellLastName, cellBirthday, cellSex, cellTel1, cellTel2, cellAddress, cellTown, cellPostalCode, cellCountry, consultationHistoryTable, colDate, colMotives, documentsTable, colDocumentTitle, colDocumentFilePath, mailsTable, colMailName, colMailFilePath;

- (void)awakeFromNib{
    
    [consultationHistoryTable setDoubleAction:@selector(showConsultation:)];
    sortedConsultations = [[NSMutableArray alloc] init];
    [colDate setIdentifier:@"date"];
    [colMotives setIdentifier:@"motives"];
    
    [documentsTable setDoubleAction:@selector(openDocument:)];
    [colDocumentTitle setIdentifier:@"title"];
    [colDocumentFilePath setIdentifier:@"docPath"];
    
    [mailsTable setDoubleAction:@selector(openLetter:)];
    [colMailName setIdentifier:@"name"];
    [colMailFilePath setIdentifier:@"path"];
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
    [cellTown setStringValue:[[NSString alloc] initWithString:patient.town]];
    [cellPostalCode setStringValue:[[NSString alloc] initWithString:patient.postalCode]];
    [cellCountry setStringValue:[[NSString alloc] initWithString:patient.country]];
    
    [self sortConsultations];
}

#pragma mark - Actions

-(IBAction)savePatient:(id)sender{
    //TODO save modifications
    [self saveAction];
}

-(IBAction)scanDocument:(id)sender{
    [[parent scanningView] setPatient:patient];
    [parent showScanningView:self];
}

-(IBAction)openDocument:(id)sender{
    OPDocument* document = [[patient.documents allObjects] objectAtIndex:documentsTable.clickedRow];
    [parent openDocument:document];
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

#pragma mark - Mails

-(IBAction)createNewMail:(id)sender{
    NSSavePanel* savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Enregistrer la lettre sous"];
    
    NSArray* allowedFileTypes = [[NSArray alloc] initWithObjects:@"docx", nil];
    [savePanel setAllowedFileTypes:allowedFileTypes];
    [savePanel setDirectoryURL:[parent mailDirectoryFor:patient]];
    
    switch ([savePanel runModal]) {
        case NSFileHandlingPanelOKButton:
        {
            NSString* targetPath = [[savePanel URL] path];
            NSString* templatePath = [[NSBundle mainBundle] pathForResource:@"Mail_Template" ofType:@"docx"];
            [[NSFileManager defaultManager] copyItemAtPath:templatePath toPath:targetPath error:nil];
            
            OPMail* nMail = [NSEntityDescription insertNewObjectForEntityForName:@"Mail" inManagedObjectContext:[self managedObjectContext]];
            nMail.patient = patient;
            nMail.filePath = [[NSString alloc] initWithString:targetPath];
            
            [self saveAction];
            
            [mailsTable reloadData];
            [parent openMail:nMail];
            
            break;
        }
            
        default:
            break;
    }
}

-(IBAction)openMail:(id)sender{
    OPMail* mail = [[patient.mails allObjects] objectAtIndex:mailsTable.clickedRow];
    [parent openMail:mail];
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
        count = [[patient.documents allObjects] count];
    }
    else if(tableView == mailsTable){
        count = [patient.mails count];
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString* value = [[NSString alloc] init];
    
    if(tableView == consultationHistoryTable){
        
        OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:row];
        
        if([[tableColumn identifier] isEqualToString:colDate.identifier]){
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            value = [dateFormatter stringFromDate:consultation.date];
        }
        else if([[tableColumn identifier] isEqualToString:colMotives.identifier]){
            value = [[NSString alloc] initWithString:consultation.motives];
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
    else if(tableView == mailsTable){
        OPMail* mail = (OPMail*)[[patient.mails allObjects]objectAtIndex:row];
        NSURL* mailURL = [NSURL fileURLWithPath:mail.filePath];
        
        NSString* value = nil;
        
        if([tableColumn.identifier isEqualToString:colMailName.identifier]){
            value = [[mailURL lastPathComponent] stringByDeletingPathExtension];
        }
        else if([tableColumn.identifier isEqualToString:colMailFilePath.identifier]){
            value = [mailURL path];
        }
    }
    
    return value;
}

@end
