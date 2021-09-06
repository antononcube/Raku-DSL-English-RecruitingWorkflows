#!/usr/bin/env perl6
use DSL::English::RecruitingWorkflows;

sub MAIN(Str $commands, Str $target = 'WL-System' ) {
    put ToRecruitingWorkflowCode($commands, $target);
}