//
//  OPPatientSearchView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"

@interface OPPatientSearchView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    NSMutableArray* searchResults;
    
    IBOutlet NSFormCell* cellFirstName;
    IBOutlet NSFormCell* cellLastName;
    IBOutlet NSFormCell* cellTel;
    IBOutlet NSFormCell* cellAddress;
    
    IBOutlet NSTableColumn* colFirstName;
    IBOutlet NSTableColumn* colLastName;
    IBOutlet NSTableColumn* colTel1;
    IBOutlet NSTableColumn* colTel2;
    IBOutlet NSTableColumn* colLastVisit;
    
    IBOutlet NSTableView* resultsTable;
}

@property (nonatomic, retain) NSMutableArray* searchResults;

@property (nonatomic, retain) IBOutlet NSFormCell* cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell* cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell* cellTel;
@property (nonatomic, retain) IBOutlet NSFormCell* cellAddress;

@property (nonatomic, retain) IBOutlet NSTableColumn* colFirstName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colLastName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colTel1;
@property (nonatomic, retain) IBOutlet NSTableColumn* colTel2;
@property (nonatomic, retain) IBOutlet NSTableColumn* colLastVisit;

@property (nonatomic, retain) IBOutlet NSTableView* resultsTable;

-(IBAction)searchPatients:(id)sender;
-(IBAction)selectPatient:(id)sender;

@end
