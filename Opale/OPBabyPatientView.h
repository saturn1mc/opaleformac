//
//  OPBabyPatientView.h
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPView.h"
#import "OPExistingPatientView.h"

@class OPHeightGraphView, OPWeightGraphView, OPHCGraphView;

@interface OPBabyPatientView : OPExistingPatientView{
    NSArray* sortedMeasures;
    
    //General tab : Additionals
    IBOutlet NSFormCell*  cellCorrectedAge;
    IBOutlet NSTextField* termWeeks;
    IBOutlet NSTextField* termDays;
    IBOutlet NSFormCell*  cellBirthPlace;
    IBOutlet NSFormCell*  cellBirthWeight;
    IBOutlet NSFormCell*  cellBirtHeight;
    IBOutlet NSFormCell*  cellBirtHeadCircumference;
    IBOutlet NSFormCell*  cellParity;
    IBOutlet NSFormCell*  cellFatherJob;
    IBOutlet NSFormCell*  cellMotherJob;
    IBOutlet NSFormCell*  cellCareMode;
    IBOutlet NSFormCell*  cellAfterCare;
    
    //Spheres tab : Additionals
    IBOutlet NSTextView*  pregnancyAndBirthSphere;
    IBOutlet NSTextView*  feedingAndStoolSphere;
    IBOutlet NSTextView*  sleepSphere;
    IBOutlet NSTextView*  otherSphere;
    
    //Graphs tab
    IBOutlet NSTableView* measuresTable;
    IBOutlet NSTableColumn* colMeasureDate;
    IBOutlet NSTableColumn* colHeight;
    IBOutlet NSTableColumn* colWeight;
    IBOutlet NSTableColumn* colCP;
    IBOutlet OPHeightGraphView* heightGraphView;
    IBOutlet OPWeightGraphView* weightGraphView;
    IBOutlet OPHCGraphView* hcGraphView;
}

@property (nonatomic, retain) IBOutlet NSFormCell* cellCorrectedAge;
@property (nonatomic, retain) IBOutlet NSTextField* termWeeks;
@property (nonatomic, retain) IBOutlet NSTextField* termDays;
@property (nonatomic, retain) IBOutlet NSFormCell* cellBirthPlace;
@property (nonatomic, retain) IBOutlet NSFormCell* cellBirthWeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellBirtHeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellBirtHeadCircumference;
@property (nonatomic, retain) IBOutlet NSFormCell* cellParity;
@property (nonatomic, retain) IBOutlet NSFormCell* cellFatherJob;
@property (nonatomic, retain) IBOutlet NSFormCell* cellMotherJob;
@property (nonatomic, retain) IBOutlet NSFormCell* cellCareMode;
@property (nonatomic, retain) IBOutlet NSFormCell* cellAfterCare;

@property (nonatomic, retain) IBOutlet NSTextView* pregnancyAndBirthSphere;
@property (nonatomic, retain) IBOutlet NSTextView* feedingAndStoolSphere;
@property (nonatomic, retain) IBOutlet NSTextView* sleepSphere;
@property (nonatomic, retain) IBOutlet NSTextView* otherSphere;

@property (nonatomic, retain) IBOutlet NSTableView* measuresTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMeasureDate;
@property (nonatomic, retain) IBOutlet NSTableColumn* colHeight;
@property (nonatomic, retain) IBOutlet NSTableColumn* colWeight;
@property (nonatomic, retain) IBOutlet NSTableColumn* colCP;
@property (nonatomic, retain) IBOutlet OPHeightGraphView* heightGraphView;
@property (nonatomic, retain) IBOutlet OPWeightGraphView* weightGraphView;
@property (nonatomic, retain) IBOutlet OPHCGraphView* hcGraphView;

-(IBAction)updateCorrectedAge:(id)sender;
-(IBAction)updateGraphs:(id)sender;
-(IBAction)addRow:(id)sender;
-(IBAction)removeRow:(id)sender;

-(void)sortMeasures;

@end
