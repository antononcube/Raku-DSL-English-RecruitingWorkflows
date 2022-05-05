=begin comment
#==============================================================================
#
#   Recruiting Workflows Bulgarian DSL actions in Raku (Perl 6)
#   Copyright (C) 2021  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ posteo . net,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku (Perl6) see https://raku.org/ .
#
#==============================================================================
=end comment

use v6;
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
