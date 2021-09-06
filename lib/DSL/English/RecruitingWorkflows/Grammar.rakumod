=begin comment
#==============================================================================
#
#   Recruiting workflows grammar in Raku
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
#   For more details about Raku see https://raku.org/ .
#
#==============================================================================
=end comment

use v6;


use DSL::Shared::Roles::English::CommonParts;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Roles::PredicateSpecification;
use DSL::Shared::Roles::ErrorHandling;

use DSL::English::RecruitingWorkflows::Grammar::TalentQuery;
use DSL::English::RecruitingWorkflows::Grammar::IntrospectionQuery;
use DSL::English::RecruitingWorkflows::Grammar::RecommendationsCommand;
use DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases;

grammar DSL::English::RecruitingWorkflows::Grammar
        does DSL::Shared::Roles::English::PipelineCommand
        does DSL::Shared::Roles::ErrorHandling
        does DSL::English::RecruitingWorkflows::Grammar::IntrospectionQuery
        does DSL::English::RecruitingWorkflows::Grammar::TalentQuery
        does DSL::English::RecruitingWorkflows::Grammar::RecommendationsCommand
        does DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases {

    # TOPa
    rule TOP {
        <pipeline-command> ||
        <ingredient-query-command> ||
        <introspection-query-command> ||
        <recommendations-by-profile-command> ||
        <recommendations-command> ||
        <recommend-for-job-command> }

    rule job-entity-spec { <entity-job-title> | <entity-job-skill> }

    rule job-entity-spec-list { <job-entity-spec>+ % <.list-separator> }

    rule recommend-for-job-command { 'i' [ 'want' | 'am' 'interested' 'in']  [ 'talent' | 'recruitas' | 'people'] [ <for-preposition> | <with-preposition> | 'that' 'fit'] <job-entity-spec-list> }

    rule data-query-command { [ 'how' 'many' | 'what' 'count' ] .'of' <job-entity-command> 'is' 'in' 'my' [ 'database' | 'catalog' ] }

}

