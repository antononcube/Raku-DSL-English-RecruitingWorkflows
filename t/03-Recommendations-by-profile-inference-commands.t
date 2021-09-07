use lib './lib';
use lib '.';
use DSL::English::RecruitingWorkflows;
use Test;

##===========================================================
## Recommendations commands
##===========================================================

my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;

plan 10;

## 1
ok $pCOMMAND.parse('can you suggest a local talent'.lc),
        'can you suggest a local talent';

## 2
ok $pCOMMAND.parse('i want to work it in healthcare jobs'.lc),
        'i want to work it in healthcare jobs';

## 3
ok $pCOMMAND.parse('i am free what do i prepare'.lc),
        'i am free what do i prepare';

## 4
ok $pCOMMAND.parse('im available suggest me a resume'.lc),
        'im available suggest me a resume';

## 5
ok $pCOMMAND.parse('i want to procure a java talent'.lc),
        'i want to procure a java talent';

## 6
ok $pCOMMAND.parse('i want to work on a software architecture job'.lc),
        'i want to work on a software architecture job';

## 7
ok $pCOMMAND.parse('i want to procure someone from Idaho'.lc),
        'i want to procure someone from Idaho';

## 8
ok $pCOMMAND.parse('show me some java delopers from MidWest resumes'.lc),
        'show me some java delopers from MidWest resumes';

## 9
ok $pCOMMAND.parse('show me some data scientist resumes'.lc),
        'show me some data scientist resumes';

## 10
ok $pCOMMAND.parse('suggest a resume from California with semi conductors experience'.lc),
        'suggest a resume from California with semi conductors experience';


done-testing;