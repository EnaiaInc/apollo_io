defmodule ApolloIo.Account do
  @type t :: %__MODULE__{
          id: String.t(),
          domain: String.t(),
          name: String.t(),
          team_id: String.t(),
          organization_id: String.t(),
          account_stage_id: String.t(),
          source: String.t(),
          original_source: String.t(),
          owner_id: String.t(),
          created_at: DateTime.t(),
          phone: String.t(),
          phone_status: String.t(),
          test_predictive_score: number | nil,
          hubspot_id: String.t() | nil,
          salesforce_id: String.t(),
          crm_owner_id: String.t(),
          parent_account_id: String.t() | nil,
          sanitized_phone: String.t(),
          account_playbook_statuses: list,
          existence_level: String.t(),
          label_ids: list,
          typed_custom_fields: map,
          modality: String.t(),
          persona_counts: map
        }

  @derive Jason.Encoder
  @derive JSON.Encoder
  use ApolloIo.Accessible

  defstruct [
    :id,
    :domain,
    :name,
    :team_id,
    :organization_id,
    :account_stage_id,
    :source,
    :original_source,
    :owner_id,
    :created_at,
    :phone,
    :phone_status,
    :test_predictive_score,
    :hubspot_id,
    :salesforce_id,
    :crm_owner_id,
    :parent_account_id,
    :sanitized_phone,
    :account_playbook_statuses,
    :existence_level,
    :label_ids,
    :typed_custom_fields,
    :modality,
    :persona_counts
  ]
end
