//
//  OPAdultChildConsultationView.m
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPMainWindow.h"
#import "OPAdultChildConsultationView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPLetter.h"

@implementation OPAdultChildConsultationView

@synthesize consultation, consultationDate, textTests, textTreatments, textAdvises, lettersTable, colLetterName, colLetterFilePath;

- (void)awakeFromNib{
    [colLetterName setIdentifier:@"name"];
    [colLetterFilePath setIdentifier:@"path"];
}

-(void)loadConsultation:(OPConsultation *)nConsultation{
    
    consultation = nConsultation;
    
    [consultationDate setDateValue:consultation.date];
    
    if(consultation.tests){
        [textTests setString:[[NSString alloc] initWithString:consultation.tests]];
    }
    else{
        [textTests setString:@""];
    }
    
    if(consultation.treatments){
        [textTreatments setString:[[NSString alloc] initWithString:consultation.treatments]];
    }
    else{
        [textTreatments setString:@""];
    }
    
    if(consultation.advises){
        [textAdvises setString:[[NSString alloc] initWithString:consultation.advises]];
    }
    else{
        [textAdvises setString:@""];
    }
}

-(IBAction)saveConsultation:(id)sender{
    
    consultation.date = [consultationDate dateValue];
    consultation.tests = [[NSString alloc] initWithString:[textTests string]];
    consultation.treatments = [[NSString alloc] initWithString:[textTreatments string]];
    consultation.advises = [[NSString alloc] initWithString:[textAdvises string]];
    
    [self saveAction];
}

-(IBAction)createNewLetter:(id)sender{
    NSSavePanel* savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Enregistrer la lettre sous"];
    
    NSArray* allowedFileTypes = [[NSArray alloc] initWithObjects:@"docx", nil];
    [savePanel setAllowedFileTypes:allowedFileTypes];
    [savePanel setDirectoryURL:[parent directoryFor:[consultation patient]]];
    
    switch ([savePanel runModal]) {
        case NSFileHandlingPanelOKButton:
        {
            NSString* targetPath = [[savePanel URL] path];
            NSString* templatePath = [[NSBundle mainBundle] pathForResource:@"Letter_Template" ofType:@"docx"];
            [[NSFileManager defaultManager] copyItemAtPath:templatePath toPath:targetPath error:nil];
            
            OPLetter* nLetter = [NSEntityDescription insertNewObjectForEntityForName:@"Letter" inManagedObjectContext:[self managedObjectContext]];
            nLetter.consultation = consultation;
            nLetter.filePath = [[NSString alloc] initWithString:targetPath];
            
            [self saveAction];
            
            [lettersTable reloadData];
            [parent openLetter:nLetter];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Result table content management

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    
    if (consultation.letters){
        count = [consultation.letters count];
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    OPLetter* letter = (OPLetter*)[[consultation.letters allObjects]objectAtIndex:row];
    NSString* value = nil;
    
    if([tableColumn.identifier isEqualToString:colLetterName.identifier]){
        value = [[[letter objectID] URIRepresentation] lastPathComponent];
    }
    else if([tableColumn.identifier isEqualToString:colLetterFilePath.identifier]){
        value = letter.filePath;
    }
    
    return value;
}

@end
