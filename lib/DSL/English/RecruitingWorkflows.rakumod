
=begin pod

=head1 DSL::English::RecruitingWorkflows

C<DSL::English::RecruitingWorkflows> package has grammar and action classes for the parsing and
interpretation of natural language commands that specify recruiting (of talent for jobs) workflows.

=head1 Synopsis

    use DSL::English::RecruitingWorkflows;
    my $rcode = ToRecruitingWorkflowCode('give top five recommendations with java and software architecture skills');

=end pod

unit module DSL::English::RecruitingWorkflows;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::English::RecruitingWorkflows::Grammar;
use DSL::English::RecruitingWorkflows::Actions::WL::System;

use DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "WL"               => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "WL-System"        => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "WL::System"       => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "Bulgarian"        => DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

my %targetToSeparator{Str} =
    "Julia"            => "\n",
    "Julia-DataFrames" => "\n",
    "R"                => " ;\n",
    "Mathematica"      => "\n",
    "WL"               => ";\n",
    "WL-System"        => ";\n",
    "Bulgarian"        => "\n";


#-----------------------------------------------------------
proto ToRecruitingWorkflowCode(Str $command, Str $target = 'WL-System', |) is export {*}

multi ToRecruitingWorkflowCode (Str $command, Str $target = 'WL-System', *%args ) {

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               grammar => DSL::English::RecruitingWorkflows::Grammar,
                                                               :%targetToAction,
                                                               :%targetToSeparator,
                                                               :$target,
                                                               |%args)
}