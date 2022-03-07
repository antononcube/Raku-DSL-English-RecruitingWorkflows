
use lib './lib';
use lib '.';

use DSL::English::RecruitingWorkflows;

use DSL::English::RecruitingWorkflows::Actions::WL::System;
use DSL::English::RecruitingWorkflows::Actions::R::base;

use DSL::Entity::Geographics;
use DSL::Entity::Jobs;

#-----------------------------------------------------------
my DSL::Entity::Geographics::Actions::WL::System $geoActions  .= new( resources => DSL::Entity::Geographics::resource-access-object()  );
my DSL::Entity::Jobs::Actions::WL::System        $jobsActions .= new( resources => DSL::Entity::Jobs::resource-access-object() );

#-----------------------------------------------------------
my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;

$pCOMMAND.set-jobs-resources(DSL::Entity::Jobs::resource-access-object());

sub daw-parse( Str:D $command, Str:D :$rule = 'TOP' ) {
    $pCOMMAND.parse($command, :$rule);
}

sub daw-subparse( Str:D $command, Str:D :$rule = 'TOP' ) {
        $pCOMMAND.subparse($command, :$rule);
}

sub daw-interpret( Str:D $command,
                   Str:D:$rule = 'TOP',
                   :$actions = DSL::English::RecruitingWorkflows::Actions::WL::System.new(:$geoActions, :$jobsActions )) {
    $pCOMMAND.parse( $command, :$rule, :$actions ).made;
}

#----------------------------------------------------------

say "=" x 60;
#my $cmd = "can hhg recommend talent that has the skills java, spring, and agile";
#my $cmd = "recommend talent that has the skills java, spring, and agile";
#my $cmd = "recommend talent that has the job titles java developer, software architect, and agile coach";
#my $cmd = "recommend jobs that have java development, software architect, agile, and agile coach";
my $cmd = "recommend top 20 job descriptions for java develpment, softwre architect, agile, and agile coach";
#my $cmd = "recommend job descriptions for java";

say daw-subparse( $cmd, rule => 'TOP' );

say '=' x 60;
say 'daw-interpret';
say '-' x 60;

say daw-interpret(
        $cmd,
        rule => 'TOP',
        actions => DSL::English::RecruitingWorkflows::Actions::WL::System.new(:$geoActions, :$jobsActions));

say "=" x 60;
say " ToRecruitingWorkflowCode ";
say "-" x 60;
say ToRecruitingWorkflowCode($cmd, 'WL-System', format => 'hash');

say "=" x 60;

#============================================================
# Recommendations by profile
#============================================================

my @testCommands = (
'can you suggest a local jobs to investigate',
'suggest something with fine quality assurance and software testing',
'recommend talent to acquire',
'recommend resumes to investigate',
'recommend talent that has the skills java, spring, and agile',
'recommend resumes with software architect, java, and data science'
);

my @targets = <WL-System>;

#for @testCommands -> $c {
#    say "=" x 60;
#    say $c;
#    for @targets -> $t {
#        say '-' x 30;
#        say $t;
#        say '-' x 30;
#        my $start = now;
#        my $res = daw-interpret($c, actions => DSL::English::RecruitingWorkflows::Actions::WL::System.new);
#        #my $res = daw-parse($c);
#        say "time:", now - $start;
#        say $res;
#    }
#}

#============================================================
# Direct call
#============================================================
#say "=" x 60;
#
#my $tstart = now;
#say $pCOMMAND.parse('i want talent with software architect, net framework, c, java', rule => 'recommend-for-job-command');
#say "-" x 60;
#say "Parsing time: {now - $tstart}";
#
#say "\n" x 3;
#say "=" x 60;
#
#$tstart = now;
#say $pCOMMAND.parse('i want talent with .net framework, c++, java, and software architect', rule => 'recommend-for-job-command');
#say "-" x 60;
#say "Parsing time: {now - $tstart}";