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
    //Additional spheres
    IBOutlet NSTextView* pregnancyAndBirthSphere;
    IBOutlet NSTextView* feedingAndStoolSphere;
    IBOutlet NSTextView* sleepSphere;
    IBOutlet NSTextView* otherSphere;
    
    //Graphs
    IBOutlet OPHeightGraphView* heightGraphView;
    IBOutlet OPWeightGraphView* weightGraphView;
    IBOutlet OPHCGraphView* hcGraphView;
}

@property (nonatomic, retain) IBOutlet NSTextView* pregnancyAndBirthSphere;
@property (nonatomic, retain) IBOutlet NSTextView* feedingAndStoolSphere;
@property (nonatomic, retain) IBOutlet NSTextView* sleepSphere;
@property (nonatomic, retain) IBOutlet NSTextView* otherSphere;

@property (nonatomic, retain) IBOutlet OPHeightGraphView* heightGraphView;
@property (nonatomic, retain) IBOutlet OPWeightGraphView* weightGraphView;
@property (nonatomic, retain) IBOutlet OPHCGraphView* hcGraphView;

@end
