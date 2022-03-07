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
## Sanity check commands
##===========================================================
## The list of tests here is for illustration purposes.
## The list is made of small samples of more dedicated tests.

plan 9;

ok $pCOMMAND.parse('what number of jobs have java'),
        'what number of jobs have java';

ok $pCOMMAND.parse('how many jobs have software architect'),
        'how many jobs have software architect';

ok $pCOMMAND.parse('what do i recruit after lunch'),
        'what do i recruit after lunch';

ok $pCOMMAND.parse('who do i recruit during easter'),
        'who do i recruit during easter';

ok $pCOMMAND.parse('recommend jobs to recruit'),
        'recommend jobs to recruit';

ok $pCOMMAND.parse('recommend a few resumes'),
        'recommend a few resumes';

ok $pCOMMAND.parse('recommend a few resumes to try to place'),
        'recommend a few resumes to try to place';

ok $pCOMMAND.parse('recommend a few workers from china'),
        'recommend a few workers from china';

ok $pCOMMAND.parse('suggest a workflow with java jobs'),
        'suggest a workflow with java jobs';

done-testing;
