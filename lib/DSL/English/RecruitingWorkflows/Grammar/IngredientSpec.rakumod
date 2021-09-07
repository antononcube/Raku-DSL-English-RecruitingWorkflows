use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Entity::Jobs::Grammar::EntityNames;
use DSL::Entity::Geographics::Grammar::EntityNames;

role DSL::English::RecruitingWorkflows::Grammar::IngredientSpec
        does DSL::Entity::Jobs::Grammar::EntityNames
        does DSL::Entity::Geographics::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    rule enhanced-data-with-quality-spec-list { <skill-spec-list> || <job-title-spec-list> || <data-with-quality-spec-list> }

    rule data-with-quality-spec-list { <.both-determiner>? <data-with-quality-spec>+ % <.list-separator> }

    rule data-with-quality-spec { <data-quality-spec-list> <.recruiting-item-phrase>? }

    rule data-quality-spec-list { <.both-determiner>? <data-quality-spec>+ % <.list-separator> }

    rule data-quality-spec { <data-non-property-spec> || <data-property-spec> || <ingredient-spec> }

    rule enhanced-ingredient-spec-list { <skill-spec-list> || <job-title-spec-list> || <ingredient-spec-list> }

    rule ingredient-spec-list { <ingredient-spec>+ % <.list-separator> }

    rule skill-spec-list { <.skills-recruiting-word> <entity-job-skill>+ % <.list-separator> }
    rule job-title-spec-list { [ <.job-title-phrase> || <.jobs-recruiting-word> ] <entity-job-title>+ % <.list-separator> }

    rule ingredient-spec { <job-entity-spec> }
    rule job-entity-spec { <entity-job-title> | <entity-job-skill> }

    rule data-non-property-spec {
        <non-prefix> <data-property-spec>
    }

    rule data-property-spec {
        <entity-job-title> |
        <entity-job-skill> |
        <entity-country-name> |
        <entity-region-name> }
}