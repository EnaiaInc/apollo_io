defmodule ApolloIo.Contact do
  @type t :: %__MODULE__{
          id: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          name: String.t(),
          linkedin_url: String.t(),
          title: String.t(),
          contact_stage_id: String.t(),
          owner_id: String.t(),
          person_id: String.t(),
          email_needs_tickling: boolean,
          organization_name: String.t(),
          source: String.t(),
          original_source: String.t(),
          organization_id: String.t(),
          headline: String.t(),
          photo_url: String.t(),
          present_raw_address: String.t(),
          linkedin_uid: String.t(),
          extrapolated_email_confidence: number,
          salesforce_id: String.t(),
          salesforce_lead_id: String.t() | nil,
          salesforce_contact_id: String.t(),
          salesforce_account_id: String.t(),
          salesforce_owner_id: String.t(),
          created_at: String.t(),
          lead_request_id: String.t() | nil,
          test_predictive_score: number | nil,
          emailer_campaign_ids: list,
          email_manually_changed: boolean,
          direct_dial_status: String.t() | nil,
          direct_dial_enrichment_failed_at: String.t() | nil,
          email_status: String.t(),
          account_id: String.t(),
          last_activity_date: DateTime.t(),
          hubspot_vid: String.t() | nil,
          hubspot_company_id: String.t() | nil,
          sanitized_phone: String.t() | nil,
          merged_crm_ids: list,
          typed_custom_fields: map,
          updated_at: DateTime.t(),
          queued_for_crm_push: boolean,
          starred_by_user_ids: list,
          suggested_from_rule_engine_config_id: String.t() | nil,
          label_ids: list,
          has_pending_email_arcgate_request: boolean,
          has_email_arcgate_request: boolean,
          existence_level: String.t(),
          email: String.t(),
          salesforce_record_url: String.t(),
          phone_numbers: list,
          account_phone_note: String.t() | nil
        }

  @derive Jason.Encoder
  use ApolloIo.Accessible

  defstruct [
    :id,
    :first_name,
    :last_name,
    :name,
    :linkedin_url,
    :title,
    :contact_stage_id,
    :owner_id,
    :person_id,
    :email_needs_tickling,
    :organization_name,
    :source,
    :original_source,
    :organization_id,
    :headline,
    :photo_url,
    :present_raw_address,
    :linkedin_uid,
    :extrapolated_email_confidence,
    :salesforce_id,
    :salesforce_lead_id,
    :salesforce_contact_id,
    :salesforce_account_id,
    :salesforce_owner_id,
    :created_at,
    :lead_request_id,
    :test_predictive_score,
    :emailer_campaign_ids,
    :email_manually_changed,
    :direct_dial_status,
    :direct_dial_enrichment_failed_at,
    :email_status,
    :account_id,
    :last_activity_date,
    :hubspot_vid,
    :hubspot_company_id,
    :sanitized_phone,
    :merged_crm_ids,
    :typed_custom_fields,
    :updated_at,
    :queued_for_crm_push,
    :starred_by_user_ids,
    :suggested_from_rule_engine_config_id,
    :label_ids,
    :has_pending_email_arcgate_request,
    :has_email_arcgate_request,
    :existence_level,
    :email,
    :salesforce_record_url,
    :phone_numbers,
    :account_phone_note
  ]
end
