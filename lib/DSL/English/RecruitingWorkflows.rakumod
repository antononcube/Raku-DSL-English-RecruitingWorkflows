
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
use DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem;

use DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

use DSL::Entity::Geographics;
use DSL::Entity::Jobs;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem,
    "WL"               => DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem,
    "WL-System"        => DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem,
    "WL-Ecosystem"     => DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem,
    "Bulgarian"        => DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

my %targetToAction2{Str} = %targetToAction.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToAction = |%targetToAction , |%targetToAction2;

my %targetToSeparator{Str} =
    "Bulgarian"        => "\n",
    "Mathematica"      => ";\n",
    "Python"           => "\n",
    "Python-Ecosystem" => "\n",
    "R"                => " ;\n",
    "R-Ecosystem"      => " ;\n",
    "Raku"             => " ;\n",
    "Raku-Ecosystem"   => " ;\n",
    "WL"               => ";\n",
    "WL-Ecosystem"     => ";\n",
    "WL-System"        => ";\n";

my Str %targetToSeparator2{Str} = %targetToSeparator.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToSeparator = |%targetToSeparator , |%targetToSeparator2;


#-----------------------------------------------------------
my DSL::Entity::Geographics::Actions::WL::System $geoActions  .= new( resources => DSL::Entity::Geographics::resource-access-object()  );
my DSL::Entity::Jobs::Actions::WL::System        $jobsActions .= new( resources => DSL::Entity::Jobs::resource-access-object() );


#-----------------------------------------------------------
proto ToRecruitingWorkflowCode(Str $command, Str $target = 'WL-System', |) is export {*}

multi ToRecruitingWorkflowCode (Str $command, Str $target = 'WL-System', *%args ) {

    my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;
    $pCOMMAND.set-geographics-resources(DSL::Entity::Geographics::resource-access-object());
    $pCOMMAND.set-jobs-resources(DSL::Entity::Jobs::resource-access-object());

    my $ACTOBJ = %targetToAction{$target}.new(:$geoActions, :$jobsActions);

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode($command,
                                                              grammar => $pCOMMAND,
                                                              targetToAction => %($target => $ACTOBJ),
                                                              :%targetToSeparator,
                                                              :$target,
                                                              |%args )
}