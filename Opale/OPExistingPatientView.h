//
//  OPExistingPatientView.h
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPPatient;

@interface OPExistingPatientView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    OPPatient* patient;
    NSArray* sortedConsultations;
    
    IBOutlet NSFormCell* cellFirstName;
    IBOutlet NSFormCell* cellLastName;
    IBOutlet NSFormCell* cellBirthday;
    IBOutlet NSFormCell* cellSex;
    IBOutlet NSFormCell* cellTel1;
    IBOutlet NSFormCell* cellTel2;
    IBOutlet NSFormCell* cellAddress;
    IBOutlet NSFormCell* cellTown;
    IBOutlet NSFormCell* cellPostalCode;
    IBOutlet NSFormCell* cellCountry;
    
    IBOutlet NSTableView* consultationHistoryTable;
    
    IBOutlet NSTableColumn* colDate;
    IBOutlet NSTableColumn* colMotives;
    
    IBOutlet NSTableView* documentsTable;
    IBOutlet NSTableColumn* colDocumentTitle;
    IBOutlet NSTableColumn* colDocumentFilePath;
    
    IBOutlet NSTableView* mailsTable;
    IBOutlet NSTableColumn* colMailName;
    IBOutlet NSTableColumn* colMailFilePath;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) NSArray* sortedConsultations;

@property (nonatomic, retain) IBOutlet NSFormCell*  cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellBirthday;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellSex;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel1;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel2;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTown;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellPostalCode;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellCountry;

@property (nonatomic, retain) IBOutlet NSTableView* consultationHistoryTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDate;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMotives;

@property (nonatomic, retain) IBOutlet NSTableView* documentsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDocumentTitle;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDocumentFilePath;

@property (nonatomic, retain) IBOutlet NSTableView* mailsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMailName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMailFilePath;


-(void)loadPatient:(OPPatient*)patientToLoad;
-(IBAction)savePatient:(id)sender;
-(IBAction)scanDocument:(id)sender;
-(IBAction)openDocument:(id)sender;
-(void)sortConsultations;
-(IBAction)newConsultation:(id)sender;
-(IBAction)showConsultation:(id)sender;
-(IBAction)createNewMail:(id)sender;
-(IBAction)openMail:(id)sender;

@end
