use v6.d;
use DSL::English::RecruitingWorkflows::Grammar;

use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Shared::Actions::CommonStructures;

use DSL::Entity::Geographics::Actions::WL::System;
use DSL::Entity::Jobs::Actions::WL::System;

unit module DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard;

class DSL::English::RecruitingWorkflows::Actions::Bulgarian::Standard
        is DSL::Shared::Actions::CommonStructures {

    ##=====================================================
    ## General
    ##=====================================================
    has Str $.userID is rw;

    has DSL::Entity::Geographics::Actions::WL::System $.geoActions;
    has DSL::Entity::Jobs::Actions::WL::System $.jobsActions;

    # method TOP($/) { make $/.values[0].made; }

    method TOP($/) {
        make 'Not implemented.';
    }

}
