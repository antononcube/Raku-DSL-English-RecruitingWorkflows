use v6.d;

use DSL::Shared::Roles::English::CommonParts;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Roles::PredicateSpecification;
use DSL::Shared::Roles::ErrorHandling;

use DSL::English::RecruitingWorkflows::Grammar::IngredientQuery;
use DSL::English::RecruitingWorkflows::Grammar::IntrospectionQuery;
use DSL::English::RecruitingWorkflows::Grammar::RecommendationsCommand;
use DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases;

use DSL::Entity::Geographics::ResourceAccess;
use DSL::Entity::Jobs::ResourceAccess;

grammar DSL::English::RecruitingWorkflows::Grammar
        does DSL::Shared::Roles::English::PipelineCommand
        does DSL::Shared::Roles::ErrorHandling
        does DSL::English::RecruitingWorkflows::Grammar::IntrospectionQuery
        does DSL::English::RecruitingWorkflows::Grammar::IngredientQuery
        does DSL::English::RecruitingWorkflows::Grammar::RecommendationsCommand
        does DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases {

    my DSL::Entity::Geographics::ResourceAccess $geographicsResources;
    my DSL::Entity::Jobs::ResourceAccess $jobsResources;

    method get-geographics-resources(--> DSL::Entity::Geographics::ResourceAccess) { return $geographicsResources; }
    method set-geographics-resources(DSL::Entity::Geographics::ResourceAccess $obj) { $geographicsResources = $obj; }

    method get-jobs-resources(--> DSL::Entity::Jobs::ResourceAccess) { return $jobsResources; }
    method set-jobs-resources(DSL::Entity::Jobs::ResourceAccess $obj) { $jobsResources = $obj; }

    # TOP
    rule TOP {
        || <pipeline-command>
        || <introspection-query-command>
        || <ingredient-query-command>
        || <recommendations-by-profile-command>
        || <recommendations-command>
        || <recommend-for-job-command>
    }

    rule job-entity-spec { <entity-job-title> | <entity-job-skill> }

    rule job-entity-spec-list { <job-entity-spec>+ % <.list-separator> }

    rule recommend-for-job-command { 'i' [ 'want' | 'am' 'interested' 'in']  [ 'talent' | 'recruits' | 'people'] [ <for-preposition> | <with-preposition> | 'that' 'fit'] <job-entity-spec-list> }

    rule data-query-command { [ 'how' 'many' | 'what' 'count' ] .'of' <job-entity-command> 'is' 'in' 'my' [ 'database' | 'catalog' ] }

}

