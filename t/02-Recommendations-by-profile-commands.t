use lib './lib';
use lib '.';
use DSL::English::RecruitingWorkflows;
use Test;

##===========================================================
## Recommendations commands
##===========================================================

my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;

plan 6;

## 1
ok $pCOMMAND.parse('can hhg recommend talent that has the skills java, spring, and agile'.lc),
        'can hhg recommend talent that has the skills java, spring, and agile';

## 2
ok $pCOMMAND.parse('recommend talent that has the skills java, spring, and agile'.lc),
        'recommend talent that has the skills java, spring, and agile';

## 3
ok $pCOMMAND.parse('recommend talent that has the job titles java developer, software architect, and agile coach'.lc),
        'recommend talent that has the job titles java developer, software architect, and agile coach';

## 4
ok $pCOMMAND.parse('recommend talent that has java development, software architect, agile, and agile coach'.lc),
        'recommend talent that has java development, software architect, agile, and agile coach';

## 5
ok $pCOMMAND.parse('recommend jobs that have java development, software architect, agile, and agile coach'.lc),
        'recommend jobs that have java development, software architect, agile, and agile coach';

## 6
ok $pCOMMAND.parse('recommend job descriptions with java development, software architect, agile, and agile coach'.lc),
        'recommend job descriptions with java development, software architect, agile, and agile coach';


done-testing;