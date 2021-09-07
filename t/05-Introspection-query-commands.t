use lib './lib';
use lib '.';
use DSL::English::DataAcquisitionWorkflows;
use Test;

##===========================================================
## Introspection commands
##===========================================================

my $pCOMMAND = DSL::English::DataAcquisitionWorkflows::Grammar;

plan 10;

## 1
ok $pCOMMAND.parse('how many times I acquired java talent in the last three months'.lc),
        'how many times I acquired java talent in the last three months';

## 2
ok $pCOMMAND.parse('How many times I procured software architects data last year'.lc),
        'How many times I procured software architects data last year';

## 3
ok $pCOMMAND.parse('how many times I acquired IT resumes last year'.lc),
        'how many times I acquired IT resumes last year';

## 4
ok $pCOMMAND.parse('How many times I analyzed hiring data last year'.lc),
        'How many times I analyzed hiring data last year';

## 5
ok $pCOMMAND.parse('how many times I analyzed star schema datasets last year'.lc),
        'how many times I analyzed star schema datasets last year';

## 6
ok $pCOMMAND.parse('how many times I processed time series last year'.lc),
        'how many times I processed time series last year';

## 7
ok $pCOMMAND.parse('plot the timeline of my talent data acquisition'.lc),
        'plot the timeline of my talent data acquisition';

## 8
ok $pCOMMAND.parse('plot the timeline of my jobs data acquisition'.lc),
        'plot the timeline of my jobs data acquisition';

## 9
ok $pCOMMAND.parse('show the timeline of my talent phone calls'.lc),
        'show the timeline of my talent phone calls';

## 10
ok $pCOMMAND.parse('show the timeline of when I acquired software developer talent'.lc),
        'show the timeline of when I acquired software developer talent';

done-testing;
