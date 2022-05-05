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
## User ID specs handling
##===========================================================

plan 13;

unlike ToRecruitingWorkflowCode('recommend resumes to prepare'), / .* 'UserID' .* /;

like ToRecruitingWorkflowCode('recommend resumes to prepare', userID => '787-89-jjd'), / .* 'UserID:787-89-jjd' .* /;

like ToRecruitingWorkflowCode('recommend resumes to prepare', userID => '787_89.jjd-88'), / .* 'UserID:787_89.jjd-88' .* /;

ok ToRecruitingWorkflowCode('USER ID 949-444-323; I want to eat protein and fat lunch'),
        'USER ID 949-444-323; I want to eat protein and fat lunch';

ok ToRecruitingWorkflowCode('USER ID 787_89.jjd-88; I want to eat Greek protein and fat lunch'),
        'USER ID 787_89.jjd-88; I want to eat Greek protein and fat lunch';

ok ToRecruitingWorkflowCode('USER ID mamaJioe94; recommend resumes to prepare'),
        'USER ID mamaJioe94; recommend resumes to prepare';

like ToRecruitingWorkflowCode('USER ID mamaJioe94; recommend resumes to prepare'), / .* 'UserID:mamaJioe94' .* /;

unlike ToRecruitingWorkflowCode('USER ID NONE; recommend resumes to prepare'), / .* 'UserID' .* /;

unlike ToRecruitingWorkflowCode('USER ID NULL; recommend resumes to prepare'), / .* 'UserID' .* /;

like ToRecruitingWorkflowCode('USER ID marekGram88; recommend resumes to prepare', userID => 'harzaGa22' ), / .* 'UserID:marekGram88' .* /;

unlike ToRecruitingWorkflowCode('USER ID marekGram88; recommend resumes to prepare', userID => 'harzaGa22' ), / .* 'UserID:harzaGa22' .* /;

like ToRecruitingWorkflowCode('USER ID NONE; recommend resumes to prepare', userID => 'harzaGa22' ), / .* 'UserID:harzaGa22' .* /;

like ToRecruitingWorkflowCode('USER ID NULL; recommend resumes to prepare', userID => 'harzaGa22' ), / .* 'UserID:harzaGa22' .* /;

done-testing;
