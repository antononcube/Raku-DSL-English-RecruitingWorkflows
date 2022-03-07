use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Entity::Grammar::EntityNames;

role DSL::English::RecruitingWorkflows::Grammar::IngredientSpec
        does DSL::Shared::Entity::Grammar::EntityNames
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

    regex entity-country-adjective {
        ( [ <.wbpl> <entity-name-part> <.wbpr> ]+ % \h+ ) <?{ self.get-geographics-resources().known-name('Country-Adjective', $0.Str.lc) }>
    }

    regex entity-country-name {
        ( [ <.wbpl> <entity-name-part> <.wbpr> ]+ % \h+ ) <?{ self.get-geographics-resources().known-name('Country', $0.Str.lc) }>
    }

    regex entity-region-adjective {
        (<word-value>+ % \h+ ) <?{ self.get-geographics-resources().known-name( 'Region-Adjective', $0.Str.lc) }>
    }

    regex entity-region-name {
        ( <word-value>+ % \h+ ) <?{ self.get-geographics-resources().known-name('Region', $0.Str.lc) }>
    }

    regex entity-job-title {
        ( [ <.wbpl> <entity-name-part> <.wbpr> ]+ % \h+ ) <?{ self.get-jobs-resources().known-name('Title', $0.Str.lc) }>
    }

    regex entity-job-skill {
        ( [ <.wbpl> <entity-name-part> <.wbpr> ]+ % \h+ ) <?{ self.get-jobs-resources().known-name('Skill', $0.Str.lc) }>
    }
}