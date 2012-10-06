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
    NSMutableArray* sortedConsultations;
    
    IBOutlet NSFormCell* cellFirstName;
    IBOutlet NSFormCell* cellLastName;
    IBOutlet NSFormCell* cellBirthday;
    IBOutlet NSFormCell* cellSex;
    IBOutlet NSFormCell* cellTel1;
    IBOutlet NSFormCell* cellTel2;
    IBOutlet NSFormCell* cellAddress;
    
    IBOutlet NSTableView* consultationHistoryTable;
    
    IBOutlet NSTableColumn* colDate;
    IBOutlet NSTableColumn* colMotives;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) NSMutableArray* sortedConsultations;

@property (nonatomic, retain) IBOutlet NSFormCell*  cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellBirthday;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellSex;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel1;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel2;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellAddress;

@property (nonatomic, retain) IBOutlet NSTableView* consultationHistoryTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDate;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMotives;


-(void)loadPatient:(OPPatient*)patientToLoad;
-(IBAction)savePatient:(id)sender;
-(void)sortConsultations;
-(IBAction)newConsultation:(id)sender;
-(IBAction)showConsultation:(id)sender;

@end
