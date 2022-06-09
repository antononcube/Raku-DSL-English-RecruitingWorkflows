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
## Ingredient queries
##===========================================================

plan 13;

ok $pCOMMAND.parse('what number of resumes have forklift driver'),
        'what number of resumes have forklift driver';

ok $pCOMMAND.parse('how many resumes have software architect'),
        'how many resumes have software architect';

ok $pCOMMAND.parse('how many resumes have software architect'),
        'how many resumes have software architect';

ok $pCOMMAND.parse('how many resumes contain statistical analysis'),
        'how many resumes contain statistical analysis';

ok $pCOMMAND.parse('how many resumes contain software architect'),
        'how many resumes contain software architect';

ok $pCOMMAND.parse('how many recipes do you know with sqlite'),
        'how many recipes do you know with sqlite';

ok $pCOMMAND.parse('what number of resumes are with sqlite'),
        'what number of resumes have sqlite';

ok $pCOMMAND.parse('what number of resumes do you know to have software testing'),
        'what number of resumes do you know to have software testing';

ok $pCOMMAND.parse('what number of resumes have painter'),
        'what number of resumes have painter';

ok $pCOMMAND.parse('which resumes have the ingredient sqlite'),
        'which resumes have the ingredient sqlite';

ok $pCOMMAND.parse('which resumes have the ingredients forklift driver'),
        'which resumes have the ingredients forklift driver';

ok $pCOMMAND.parse('which resumes have the ingredients statistical analysis'),
        'which resumes have the ingredients statistical analysis';

ok $pCOMMAND.parse('which resumes have the ingredients painter'),
        'which resumes have the ingredients painter';

done-testing;
