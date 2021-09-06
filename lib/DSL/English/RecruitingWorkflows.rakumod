
=begin pod

=head1 DSL::English::RecruitingWorkflows

C<DSL::English::RecruitingWorkflows> package has grammar and action classes for the parsing and
interpretation of natural language commands that specify recruiting (of talent for jobs) workflows.

=head1 Synopsis

    use DSL::English::RecruitingWorkflows;
    my $rcode = ToRecruitingWorkflowCode('give top five recommendations with java and software architecture skills');

=end pod

unit module DSL::English::RecruitingWorkflows;

use DSL::Shared::Utilities::MetaSpecsProcessing;

use DSL::English::RecruitingWorkflows::Grammar;
use DSL::English::RecruitingWorkflows::Actions::WL::System;

use DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "WL"               => DSL::English::RecruitingWorkflows::Actions::WL::System,
    "WL-System"        => DSL::English::RecruitingWorkflows::Actions::WL::System,
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
sub has-semicolon (Str $word) {
    return defined index $word, ';';
}

#-----------------------------------------------------------
proto ToRecruitingWorkflowCode(Str $command, Str $target = 'WL-System' ) is export {*}

multi ToRecruitingWorkflowCode ( Str $command where not has-semicolon($command), Str $target = 'WL-System' ) {

    die 'Unknown target.' unless %targetToAction{$target}:exists;

    my $match = DSL::English::RecruitingWorkflows::Grammar.parse($command.trim, actions => %targetToAction{$target} );
    die 'Cannot parse the given command.' unless $match;
    return $match.made;
}

multi ToRecruitingWorkflowCode ( Str $command where has-semicolon($command), Str $target = 'WL-System' ) {

    my $specTarget = get-dsl-spec( $command, 'target');

    $specTarget = $specTarget ?? $specTarget<DSLTARGET> !! $target;

    die 'Unknown target.' unless %targetToAction{$specTarget}:exists;

    my @commandLines = $command.trim.split(/ ';' \s* /);

    @commandLines = grep { $_.Str.chars > 0 }, @commandLines;

    my @cmdLines = map { ToRecruitingWorkflowCode($_, $specTarget) }, @commandLines;

    @cmdLines = grep { $_.^name eq 'Str' }, @cmdLines;

    return @cmdLines.join( %targetToSeparator{$specTarget} ).trim;
}
