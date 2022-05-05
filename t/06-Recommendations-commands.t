use lib './lib';
use lib '.';
use DSL::English::RecruitingWorkflows;

use DSL::Entity::Geographics;
use DSL::Entity::Jobs;

use Test;

my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;
$pCOMMAND.set-jobs-resources(DSL::Entity::Jobs::resource-access-object());
$pCOMMAND.set-geographics-resources(DSL::Entity::Geographics::resource-access-object());

##===========================================================
## Recommendations commands
##===========================================================

plan 17;

## 1
ok $pCOMMAND.parse('can you suggest resumes with fats'.lc),
        'can you suggest resumes with fats';

## 2
ok $pCOMMAND.parse('can you suggest resumes with low carbs'.lc),
        'can you suggest resumes with low carbs';

## 3
ok $pCOMMAND.parse('can you suggest resumes with protein'.lc),
        'can you suggest resumes with protein';

## 4
ok $pCOMMAND.parse('can you suggest resumes with sugars'.lc),
        'can you suggest resumes with sugars';

## 5
ok $pCOMMAND.parse('recommend a course'.lc),
        'recommend a course';

## 6
ok $pCOMMAND.parse('recommend a resume'.lc),
        'recommend a resume';

## 7
ok $pCOMMAND.parse('recommend a resume to prepare'.lc),
        'recommend a resume to prepare';

## 8
ok $pCOMMAND.parse('recommend a few resumes'.lc),
        'recommend a few resumes';

## 9
ok $pCOMMAND.parse('recommend talent for easter'.lc),
        'recommend talent for easter';

## 10
ok $pCOMMAND.parse('recommend talent for lunch'.lc),
        'recommend talent for lunch';

## 11
ok $pCOMMAND.parse('recommend resumes'.lc),
        'recommend resumes';

## 12
ok $pCOMMAND.parse('recommend resumes for 1st quarter'.lc),
        'recommend resumes for 1st quarter';

## 13
ok $pCOMMAND.parse('recommend resumes for easter'.lc),
        'recommend resumes for easter';

## 14
ok $pCOMMAND.parse('suggest a resume to prepare'.lc),
        'suggest a resume to prepare';

## 15
ok $pCOMMAND.parse('suggest me talent'.lc),
        'suggest me talent';

## 16
ok $pCOMMAND.parse('tell me a few talent'.lc),
        'tell me a few talent';

## 17
ok $pCOMMAND.parse('what to prepare'.lc),
        'what to prepare';

done-testing;
