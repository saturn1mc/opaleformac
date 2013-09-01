//
//  OPProfessionalSearchView.h
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPView.h"

@interface OPProfessionalSearchView: OPView <NSTableViewDelegate, NSTableViewDataSource>{
    NSMutableArray* searchResults;
    
    IBOutlet NSFormCell* cellFirstName;
    IBOutlet NSFormCell* cellLastName;
    IBOutlet NSFormCell* cellSpeciality;
    IBOutlet NSFormCell* cellTel;
    IBOutlet NSFormCell* cellAddress;
    
    IBOutlet NSTableColumn* colFirstName;
    IBOutlet NSTableColumn* colLastName;
    IBOutlet NSTableColumn* colSpeciality;
    IBOutlet NSTableColumn* colTel;
    IBOutlet NSTableColumn* colAddress;
    IBOutlet NSTableColumn* colTown;
    IBOutlet NSTableColumn* colPostalCode;
    IBOutlet NSTableColumn* colCountry;
    
    IBOutlet NSTableView* resultsTable;
}

@property (nonatomic, retain) NSMutableArray* searchResults;

@property (nonatomic, retain) IBOutlet NSFormCell* cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell* cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell* cellSpeciality;
@property (nonatomic, retain) IBOutlet NSFormCell* cellTel;
@property (nonatomic, retain) IBOutlet NSFormCell* cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell* cellTown;
@property (nonatomic, retain) IBOutlet NSFormCell* cellPostalCode;
@property (nonatomic, retain) IBOutlet NSFormCell* cellCountry;

@property (nonatomic, retain) IBOutlet NSTableColumn* colFirstName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colLastName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colSpeciality;
@property (nonatomic, retain) IBOutlet NSTableColumn* colTel;
@property (nonatomic, retain) IBOutlet NSTableColumn* colAddress;
@property (nonatomic, retain) IBOutlet NSTableColumn* colTown;
@property (nonatomic, retain) IBOutlet NSTableColumn* colPostalCode;
@property (nonatomic, retain) IBOutlet NSTableColumn* colCountry;

@property (nonatomic, retain) IBOutlet NSTableView* resultsTable;

-(IBAction)searchProfessional:(id)sender;
-(IBAction)selectProfessional:(id)sender;

@end
