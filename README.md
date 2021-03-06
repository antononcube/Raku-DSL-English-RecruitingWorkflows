# Raku DSL English Recruiting Workflows

## In brief

This Raku Perl 6 package has grammar classes and action classes for the parsing and
interpretation of spoken commands that specify Job Recruiting (JR) workflows.

It is envisioned that the interpreters (actions) are going to target different
programming languages: Python, Raku, R, WL, etc.

This project is closely related to the project
[Head Huntress Gemma](https://github.com/antononcube/ConversationalAgents/tree/master/Projects/HeadHuntressGemma).
  
This diagram shows the conversational agent components this grammar addresses:

![HHGDesign](https://github.com/antononcube/ConversationalAgents/raw/master/Projects/HeadHuntressGemma/Diagrams/Head-Huntress-Gemma-design-small.jpg)

## Installation

**1.** Install Raku (Perl 6) : https://raku.org/downloads . 

**2.** Make sure you have Zef Module Installer. 
 
   - Type in `zef --version` in the command line.
   - Zef Module Installer can be installed from : https://github.com/ugexe/zef .

**3.** Open a command line program. (E.g. Terminal on Mac OS X.)

**4.** Run the commands:

```shell
zef install https://github.com/antononcube/Raku-DSL-Shared.git
zef install https://github.com/antononcube/Raku-DSL-Entity-English-Jobs.git
zef install https://github.com/antononcube/Raku-DSL-Entity-English-Geographics.git
zef install https://github.com/antononcube/Raku-DSL-English-RecruitingWorkflows.git
```


## Examples

Open a Raku IDE or type `raku` in the command line program. Try this Raku code:

```raku
use DSL::English::RecruitingWorkflows;

say ToRecruitingWorkflowCode(
    "what talent can i propose to whom in the next two hours?
     why did you recommend that?",
    "WL-HRMon");
``` 
    
Here is a more complicated, statistics pipeline specification:

```raku
say ToRecruitingWorkflowCode(
    "how many people got hired with java and .net skills last month;
     what is the breakdown of skills over geo locations;
     where software developers are hired the most;
     plot the results;", 
     "WL-HRMon")
```

Here is a recommendations specification (by collaborative filtering):

```raku
say ToRecruitingWorkflowCode(
    "what people like me proposed to clients last week;
     which talent similar to those i can submit today;
     show me the job titles and skills;", 
     "WL-HRMon")
```

The command above should print out WL code for the WL package `...`, \[AA1\]:

    TBD...

## Similarities

The grammars in this project are closely related to the food preparation grammars 
in the Raku package
[DSL::English::FoodPreparationWorkflows](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows),
[AAr4].
(The initial grammar versions were *derived* from [AAr4].)

The design and structure of data acquisition workflows package (grammars)
[DSL::English::DataAcquisitionWorkflows](https://github.com/antononcube/Raku-DSL-English-DataAcquisitionWorkflows),
[AAr5], 
are also very similar to both [AAr4] and this one (DSL::English::RecruitingWorkflows).

## References

[AAr1] Anton Antonov,
[DSL::Shared Raku package](https://github.com/antononcube/Raku-DSL-Shared),
(2020),
[GitHub/antononcube](https://github.com/antononcube).

[AAr2] Anton Antonov,
[DSL::Entity::English::Jobs Raku package](https://github.com/antononcube/Raku-DSL-Entity-English-Jobs),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAr3] Anton Antonov,
[DSL::Entity::English::Geographics Raku package](https://github.com/antononcube/Raku-DSL-Entity-English-Geographics),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAr4] Anton Antonov,
[DSL::English::FoodPreparationWorkflows Raku package](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAr5] Anton Antonov,
[DSL::English::DataAcquisitionWorkflows Raku package](https://github.com/antononcube/Raku-DSL-English-DataAcquisitionWorkflows),
(2021),
[GitHub/antononcube](https://github.com/antononcube).
