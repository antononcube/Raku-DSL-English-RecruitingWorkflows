use lib './lib';
use lib '.';
use DSL::English::RecruitingWorkflows;

my $pCOMMAND = DSL::English::RecruitingWorkflows::Grammar;

#use Grammar::Tracer;

say "=" x 60;

my $tstart = now;
say $pCOMMAND.parse('i want talent with software architect, net framework, c, java', rule => 'recommend-for-job-command');
say "-" x 60;
say "Parsing time: {now - $tstart}";

say "\n" x 3;
say "=" x 60;

$tstart = now;
say $pCOMMAND.parse('i want talent with .net framework, c++, java, and software architect', rule => 'recommend-for-job-command');
say "-" x 60;
say "Parsing time: {now - $tstart}";