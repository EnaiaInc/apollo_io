defmodule ApolloIoTest do
  use ExUnit.Case
  alias ApolloIo.{Organization, Person, RateLimit}
  alias ApolloIo.Person.BulkPeopleEnrichmentResult
  alias ApolloIo.Search.SearchResult
  import ExUnit.CaptureLog
  require Logger

  defmodule ApolloIoTest.Mock do
    def retry_func(_response_or_exception) do
      Logger.info("retry_func")
      true
    end
  end

  setup do
    bypass = Bypass.open(port: 12_345)
    {:ok, bypass: bypass}
  end

  describe "endpoints" do
    test "organization enrich", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, organization_response())
      end)

      assert {:ok, %Organization{}, %RateLimit{minute: %{}, hourly: %{}, daily: %{}}} =
               ApolloIo.organization_enrich(domain: "patagonia.com")

      assert {:ok, %Organization{}, %RateLimit{minute: %{}, hourly: %{}, daily: %{}}} =
               ApolloIo.organization_enrich("patagonia.com")
    end

    test "people enrich", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, people_response())
      end)

      assert {:ok, %Person{}, %RateLimit{minute: %{}, hourly: %{}, daily: %{}}} =
               ApolloIo.people_enrich(first_name: "James", last_name: "Cameroon")
    end

    test "bulk people enrich", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, bulk_people_response())
      end)

      assert {:ok, %BulkPeopleEnrichmentResult{matches: [%Person{}]},
              %RateLimit{minute: %{}, hourly: %{}, daily: %{}}} =
               ApolloIo.bulk_people_enrich([%{email: "tim@apollo.io"}])
    end

    test "search", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, search_response())
      end)

      assert {:ok, %SearchResult{}, %RateLimit{minute: %{}, hourly: %{}, daily: %{}}} =
               ApolloIo.search(
                 person_titles: ["sales director", "engineer manager"],
                 q_organization_domains: "google.com\nfacebook.com",
                 page: 1
               )
    end

    test "retry config works", %{bypass: bypass} do
      Application.put_env(:apollo_io, :retry_function, &ApolloIoTest.Mock.retry_func/1)

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(
          429,
          "The maximum number of api calls allowed for api/v1/organizations/enrich is 100 times per hour. Please upgrade your plan from https://app.apollo.io/#/settings/plans/upgrade"
        )
      end)

      {return_value, log} =
        with_log(fn -> ApolloIo.organization_enrich(domain: "patagonia.com") end)

      assert {:error,
              %ApolloIo.Error{
                message:
                  "The maximum number of api calls allowed for api/v1/organizations/enrich is 100 times per hour. Please upgrade your plan from https://app.apollo.io/#/settings/plans/upgrade"
              }} = return_value

      assert log =~ "retry_func"
    end

    test "if error response does not raise exceptions", %{bypass: bypass} do
      Application.put_env(:apollo_io, :retry_function, &ApolloIoTest.Mock.retry_func/1)

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(
          429,
          "The maximum number of api calls allowed for api/v1/organizations/enrich is 100 times per hour. Please upgrade your plan from https://app.apollo.io/#/settings/plans/upgrade"
        )
      end)

      return_value = ApolloIo.search(q_person_name: "Foo")

      assert {:error,
              %ApolloIo.Error{
                message:
                  "The maximum number of api calls allowed for api/v1/organizations/enrich is 100 times per hour. Please upgrade your plan from https://app.apollo.io/#/settings/plans/upgrade"
              }} = return_value
    end
  end

  def organization_response do
    ~s<
    {
      "organization": {
          "id": "5e66b6XXXXXXXXXXXXXXXXXX",
          "name": "Apollo.io",
          "website_url": "http://www.apollo.io",
          "blog_url": null,
          "angellist_url": null,
          "linkedin_url": "http://www.linkedin.com/company/apolloio",
          "twitter_url": "https://twitter.com/MeetApollo/",
          "facebook_url": "https://www.facebook.com/MeetApollo/",
          "primary_phone": {
              "number": "202374XXXX",
              "source": "Account"
          },
          "languages": [],
          "alexa_ranking": 522,
          "phone": "202374XXXX",
          "linkedin_uid": "185115XX",
          "founded_year": 2015,
          "publicly_traded_symbol": null,
          "publicly_traded_exchange": null,
          "logo_url": "https://apollo-server.com/uploads/pictures/61824XXXXXXXXXXXXXXXXXXX/picture",
          "crunchbase_url": null,
          "primary_domain": "apollo.io",
          "persona_counts": {},
          "industry": "computer software",
          "keywords": [
              "sales engagement",
              "lead generation",
              "predictive analytics",
              "lead scoring",
              "sales strategy",
              "conversation intelligence",
              "sales enablement",
              "lead routing",
              "sales development",
              "email engagement",
              "revenue intelligence",
              "sales operations",
              "demand generation"
          ],
          "estimated_num_employees": 170,
          "snippets_loaded": true,
          "industry_tag_id": "5567cdXXXXXXXXXXXXXXXXXX",
          "retail_location_count": 0,
          "raw_address": "535 Mission St, Suite 1100, San Francisco, California 94105, US",
          "street_address": "535 Mission St",
          "city": "San Francisco",
          "state": "California",
          "postal_code": "94105",
          "country": "United States",
          "owned_by_organization_id": null,
          "suborganizations": [],
          "num_suborganizations": 0,
          "seo_description": "Apollo is a data-first engagement platform that embeds intelligence within your workflows to help you execute, analyze, and improve on your growth strategy.",
          "short_description": "Apollo is the unified engagement acceleration platform that gives reps the ability to dramatically increase their number of quality conversations and opportunities. Reps are empowered do more than just conduct outreach, they learn who to target, how to reach out, and what to say at speed and scale. We help drive growth and success by providing the means for teams to discover and utilize their organization’s unique best practices. \\n\\nBy working in a unified platform, reps and managers alike save hours of time each day, strategy changes are instantly scaled across the whole team, and managers can finally dig into data at each step of their pipeline to continually find new ways to improve. \\n\\nTeams get access to our database of 200+ million contacts with a built-in fully customizable Scoring Engine, full sales engagement stack, our native Account Playbook builder, and the industry’s only custom deep analytics suite. Managers create and enforce order and process with the industry’s most advanced Rules Engine.\\n\\nApollo is the foundation for your entire end-to-end sales strategy.\\n\\nJoin teams like Autodesk, Copper (ProsperWorks), and Snowflake to experience the future of sales today. Ready to join our crew? Email sales@apollo.io. ",
          "annual_revenue_printed": "10M",
          "annual_revenue": 10000000,
          "total_funding": 9200000,
          "total_funding_printed": "9.2M",
          "latest_funding_round_date": "2018-06-26T00:00:00.000+00:00",
          "latest_funding_stage": "Series A",
          "funding_events": [
              {
                  "id": "5ffe93XXXXXXXXXXXXXXXXXX",
                  "date": "2018-06-26T00:00:00.000+00:00",
                  "news_url": "https://techcrunch.com/2018/06/26/yc-grad-zenprospect-rebrands-as-apollo-lands-7-m-series-a/",
                  "type": "Series A",
                  "investors": "Nexus Venture Partners",
                  "amount": "7M",
                  "currency": "$"
              },
              {
                  "id": "5ffe93XXXXXXXXXXXXXXXXXX",
                  "date": "2016-10-01T00:00:00.000+00:00",
                  "news_url": null,
                  "type": "Other",
                  "investors": "Y Combinator, SV Angel, Social Capital, Nexus Venture Partners",
                  "amount": "2.2M",
                  "currency": "$"
              }
          ],
          "technology_names": [
              "Cloudflare DNS",
              "Mailchimp Mandrill",
              "Gmail",
              "Marketo",
              "Google Apps",
              "Microsoft Office 365",
              "CloudFlare Hosting",
              "Route 53",
              "Zendesk",
              "Google Cloud Hosting",
              "Stripe",
              "Lever",
              "Segment.io",
              "Amplitude",
              "Hubspot",
              "Nginx",
              "CrazyEgg",
              "Squarespace ECommerce",
              "Linkedin Marketing Solutions",
              "Yandex Metrica",
              "Mobile Friendly",
              "Typekit",
              "Google Tag Manager"
          ],
          "current_technologies": [
              {
                  "uid": "cloudflare_dns",
                  "name": "Cloudflare DNS",
                  "category": "Domain Name Services"
              },
              {
                  "uid": "mailchimp_mandrill",
                  "name": "Mailchimp Mandrill",
                  "category": "Email Delivery"
              },
              {
                  "uid": "gmail",
                  "name": "Gmail",
                  "category": "Email Providers"
              },
              {
                  "uid": "marketo",
                  "name": "Marketo",
                  "category": "Marketing Automation"
              }
          ],
          "account_id": "614264XXXXXXXXXXXXXXXXXX",
          "account": {
              "id": "614264XXXXXXXXXXXXXXXXXX",
              "domain": "apollo.io",
              "name": "Apollo",
              "team_id": "5c1004XXXXXXXXXXXXXXXXXX",
              "organization_id": "5e66b6XXXXXXXXXXXXXXXXXX",
              "account_stage_id": "5c1004XXXXXXXXXXXXXXXXXX",
              "source": "salesforce",
              "original_source": "salesforce",
              "owner_id": "5c1004XXXXXXXXXXXXXXXXXX",
              "created_at": "2021-09-15T21:24:18.374Z",
              "phone": "(123) 456-XXXX",
              "phone_status": "no_status",
              "test_predictive_score": null,
              "hubspot_id": null,
              "salesforce_id": "0015g0XXXXXXXXXXXX",
              "crm_owner_id": "0055g0XXXXXXXXXXXX",
              "parent_account_id": null,
              "sanitized_phone": "+112345XXXXX",
              "account_playbook_statuses": [],
              "existence_level": "full",
              "label_ids": [],
              "typed_custom_fields": {},
              "modality": "account",
              "persona_counts": {}
          },
          "departmental_head_count": {
              "engineering": 45,
              "accounting": 4,
              "product_management": 5,
              "support": 31,
              "arts_and_design": 10,
              "sales": 37,
              "education": 6,
              "consulting": 10,
              "human_resources": 10,
              "business_development": 22,
              "operations": 10,
              "finance": 8,
              "entrepreneurship": 4,
              "marketing": 7,
              "information_technology": 5,
              "administrative": 3,
              "legal": 0,
              "media_and_commmunication": 0,
              "data_science": 0
          }
        }
    }
    >
  end

  defp people_response do
    ~s(
        {
          "person": {
              "id": "583f2f7ed9ced98ab5bfXXXX",
              "first_name": "Tim",
              "last_name": "Zheng",
              "name": "Tim Zheng",
              "linkedin_url": "http://www.linkedin.com/in/tim-zheng-677ba010",
              "title": "Founder & CEO",
              "city": "San Francisco",
              "email_status": null,
              "photo_url": "https://media-server.url",
              "twitter_url": null,
              "github_url": null,
              "facebook_url": null,
              "extrapolated_email_confidence": null,
              "headline": "Founder & CEO at Apollo",
              "country": "United States",
              "email": "name@domain.io",
              "state": "CA",
              "excluded_for_leadgen": false,
              "contact_id": "5da8ceXXXXXXXXXXXXXXXX",
              "contact": {
                  "id": "5da8ceXXXXXXXXXXXXXXXX",
                  "first_name": "Tim",
                  "last_name": "Zheng",
                  "name": "Tim Zheng",
                  "linkedin_url": "http://www.linkedin.com/in/tim-zheng-677ba010",
                  "title": "Founder & CEO",
                  "contact_stage_id": "5c48fb36ae29ba0f376d11ab",
                  "owner_id": "5c1004XXXXXXXXXXXXXXXXXX",
                  "person_id": "5eb53cXXXXXXXXXXXXXXXX",
                  "email_needs_tickling": false,
                  "organization_name": "Apollo",
                  "source": "search",
                  "original_source": "email_import",
                  "organization_id": "5e66b6XXXXXXXXXXXXXXXX",
                  "headline": "Founder & CEO at Apollo",
                  "photo_url": "https://static-exp2.licdn.com/sc/h/djzv59yelk5urv2ujlazfyvrk",
                  "present_raw_address": "San Francisco, California, United States",
                  "linkedin_uid": "38777275",
                  "extrapolated_email_confidence": 0,
                  "salesforce_id": "0031UXXXXXXXXXXXX",
                  "salesforce_lead_id": null,
                  "salesforce_contact_id": "0031UXXXXXXXXXXXX",
                  "salesforce_account_id": "0011UXXXXXXXXXXXX",
                  "salesforce_owner_id": "0051UXXXXXXXXXXXX",
                  "created_at": "2019-10-17T20:25:07.594Z",
                  "lead_request_id": null,
                  "test_predictive_score": null,
                  "emailer_campaign_ids": [],
                  "email_manually_changed": false,
                  "direct_dial_status": null,
                  "direct_dial_enrichment_failed_at": null,
                  "email_status": "verified",
                  "account_id": "5f1faXXXXXXXXXXXXXXXX",
                  "last_activity_date": "2018-06-26T16:30:35.000+00:00",
                  "hubspot_vid": null,
                  "hubspot_company_id": null,
                  "sanitized_phone": null,
                  "merged_crm_ids": [],
                  "typed_custom_fields": {
                      "5d856e9c6899d00098XXXXXX": "Tim Zheng"
                  },
                  "updated_at": "2020-07-28T04:44:51.448Z",
                  "queued_for_crm_push": false,
                  "starred_by_user_ids": [],
                  "suggested_from_rule_engine_config_id": null,
                  "label_ids": [],
                  "has_pending_email_arcgate_request": false,
                  "has_email_arcgate_request": false,
                  "existence_level": "full",
                  "email": "example@domain.com",
                  "salesforce_record_url": "https://na85.salesforce.com/0031UXXXXXXXXXXXX",
                  "phone_numbers": [],
                  "account_phone_note": null
              },
              "revealed_for_current_team": true,
              "organization_id": "5e66b6XXXXXXXXXXXXXXXX",
              "organization": {
                  "id": "5e66b6XXXXXXXXXXXXXXXX",
                  "name": "Apollo",
                  "website_url": "http://www.apollo.io",
                  "blog_url": null,
                  "angellist_url": null,
                  "linkedin_url": "http://www.linkedin.com/company/apolloio",
                  "twitter_url": "https://twitter.com/MeetApollo/",
                  "facebook_url": "https://www.facebook.com/MeetApollo/",
                  "languages": [],
                  "alexa_ranking": 1955,
                  "phone": null,
                  "linkedin_uid": "18511550",
                  "publicly_traded_symbol": null,
                  "publicly_traded_exchange": null,
                  "logo_url": "https://apollo-server.com/uploads/pictures/5f026XXXXXXXXXXXXXXXX/picture",
                  "crunchbase_url": null,
                  "primary_domain": "apollo.io",
                  "persona_counts": {},
                  "industry": "computer software",
                  "keywords": [
                      "sales engagement",
                      "lead generation",
                      "predictive analytics",
                      "lead scoring",
                      "sales strategy",
                      "conversation intelligence",
                      "sales enablement",
                      "lead routing",
                      "sales development",
                      "and email engagement"
                  ],
                  "estimated_num_employees": 38,
                  "snippets_loaded": true,
                  "industry_tag_id": "5567cdXXXXXXXXXXXXXXXX",
                  "retail_location_count": 0,
                  "raw_address": "535 Mission St, Suite 1100, San Francisco, California 94105, US",
                  "street_address": "535 Mission St",
                  "city": "San Francisco",
                  "state": "California",
                  "postal_code": "94105",
                  "country": "United States",
                  "owned_by_organization_id": null,
                  "suborganizations": [],
                  "num_suborganizations": 0,
                  "seo_description": "Apollo is an intelligent, data-first engagement platform that puts structured data at the core of your workflows to help you execute, analyze, and improve on your growth strategy.",
                  "short_description": "Apollo is the unified engagement acceleration platform that gives reps the ability to dramatically increase their number of quality conversations and opportunities. Reps are ...",
                  "total_funding": null,
                  "total_funding_printed": null,
                  "latest_funding_round_date": null,
                  "latest_funding_stage": null,
                  "funding_events": [],
                  "technology_names": [
                      "Cloudflare DNS",
                      "Rackspace MailGun",
                      "Gmail",
                      "Marketo",
                      "Google Apps",
                      "Microsoft Office 365",
                      "CloudFlare Hosting"
                  ],
                  "current_technologies": [
                      {
                          "uid": "cloudflare_dns",
                          "name": "Cloudflare DNS",
                          "category": "Domain Name Services"
                      },
                      {
                          "uid": "rackspace_mailgun",
                          "name": "Rackspace MailGun",
                          "category": "Email Delivery"
                      },
                      {
                          "uid": "gmail",
                          "name": "Gmail",
                          "category": "Email Providers"
                      },
                      {
                          "uid": "marketo",
                          "name": "Marketo",
                          "category": "Marketing Automation"
                      },
                      {
                          "uid": "google_apps",
                          "name": "Google Apps",
                          "category": "Other"
                      },
                      {
                          "uid": "office_365",
                          "name": "Microsoft Office 365",
                          "category": "Other"
                      },
                      {
                          "uid": "cloudflare_hosting",
                          "name": "CloudFlare Hosting",
                          "category": "Hosting"
                      }
                  ]
              }
          }
      }
  )
  end

  defp bulk_people_response do
    ~s<
      {
        "credits_consumed": 0.01,
        "error_code": null,
        "error_message": null,
        "matches": [
          {
            "city": "San Francisco",
            "country": "United States",
            "email": "tim@apollo.io",
            "email_status": null,
            "employment_history": [
              {
                "_id": "63e3a596873eac00011e110b",
                "created_at": "2023-02-08T13:37:26.544Z",
                "current": true,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": null,
                "grade_level": null,
                "id": "63e3a596873eac00011e110b",
                "key": "63e3a596873eac00011e110b",
                "kind": null,
                "major": null,
                "organization_id": "5e66b6381e05b4008c8331b8",
                "organization_name": "Apollo",
                "raw_address": null,
                "start_date": "2016-01-01",
                "title": "Founder & CEO",
                "updated_at": "2023-02-08T13:37:26.544Z"
              },
              {
                "_id": "63e3a5d4873eac00011e13a5",
                "created_at": "2023-02-08T13:38:28.745Z",
                "current": false,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": "2015-01-01",
                "grade_level": null,
                "id": "63e3a5d4873eac00011e13a5",
                "key": "63e3a5d4873eac00011e13a5",
                "kind": null,
                "major": null,
                "organization_id": null,
                "organization_name": "Braingenie",
                "raw_address": null,
                "start_date": "2011-01-01",
                "title": "Founder & CEO",
                "updated_at": "2023-02-08T13:38:28.745Z"
              },
              {
                "_id": "63e3a5d4873eac00011e13a6",
                "created_at": "2023-02-08T13:38:28.745Z",
                "current": false,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": "2011-01-01",
                "grade_level": null,
                "id": "63e3a5d4873eac00011e13a6",
                "key": "63e3a5d4873eac00011e13a6",
                "kind": null,
                "major": null,
                "organization_id": "54a22f23746869331840e813",
                "organization_name": "Citadel Investment Group",
                "raw_address": null,
                "start_date": "2011-01-01",
                "title": "Investment & Trading Associate",
                "updated_at": "2023-02-08T13:38:28.745Z"
              },
              {
                "_id": "63e3a5d4873eac00011e13a7",
                "created_at": "2023-02-08T13:38:28.745Z",
                "current": false,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": "2010-09-01",
                "grade_level": null,
                "id": "63e3a5d4873eac00011e13a7",
                "key": "63e3a5d4873eac00011e13a7",
                "kind": null,
                "major": null,
                "organization_id": "54a1216169702d7fe6dfca02",
                "organization_name": "The Boston Consulting Group",
                "raw_address": null,
                "start_date": "2010-08-01",
                "title": "Summer Associate",
                "updated_at": "2023-02-08T13:38:28.745Z"
              },
              {
                "_id": "63e3a5d4873eac00011e13a8",
                "created_at": "2023-02-08T13:38:28.745Z",
                "current": false,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": "2010-08-01",
                "grade_level": null,
                "id": "63e3a5d4873eac00011e13a8",
                "key": "63e3a5d4873eac00011e13a8",
                "kind": null,
                "major": null,
                "organization_id": "5da2e6a3f978a8000177e831",
                "organization_name": "Goldman Sachs",
                "raw_address": null,
                "start_date": "2010-06-01",
                "title": "Summer Analyst",
                "updated_at": "2023-02-08T13:38:28.745Z"
              },
              {
                "_id": "63e3a5d4873eac00011e13a9",
                "created_at": "2023-02-08T13:38:28.745Z",
                "current": false,
                "degree": null,
                "description": null,
                "emails": null,
                "end_date": "2010-02-01",
                "grade_level": null,
                "id": "63e3a5d4873eac00011e13a9",
                "key": "63e3a5d4873eac00011e13a9",
                "kind": null,
                "major": null,
                "organization_id": "54a1a06274686945fa1ffc02",
                "organization_name": "Jane Street",
                "raw_address": null,
                "start_date": "2009-12-01",
                "title": "Trading Intern",
                "updated_at": "2023-02-08T13:38:28.745Z"
              }
            ],
            "extrapolated_email_confidence": null,
            "facebook_url": null,
            "first_name": "Tim",
            "github_url": null,
            "headline": "Founder & CEO at Apollo",
            "id": "63cd663d8cde7800015d3520",
            "intent_strength": null,
            "last_name": "Zheng",
            "linkedin_url": "http://www.linkedin.com/in/tim-zheng-677ba010",
            "name": "Tim Zheng",
            "organization": {
              "alexa_ranking": 3506,
              "id": "5e66b6381e05b4008c8331b8",
              "languages": [],
              "street_address": "301 Howard St",
              "publicly_traded_symbol": null,
              "publicly_traded_exchange": null,
              "logo_url": "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/63dce1c2d502ab0001d29a46/picture",
              "linkedin_url": "http://www.linkedin.com/company/apolloio",
              "primary_phone": {
                "number": "+1(202) 374-1312",
                "source": "Account"
              },
              "founded_year": 2015,
              "city": "San Francisco",
              "sanitized_phone": "+12023741312",
              "industry_tag_id": "5567cd4773696439b10b0000",
              "twitter_url": "https://twitter.com/meetapollo/",
              "raw_address": "301 Howard St Ste 830, Suite 830, San Francisco, California, USA, 94105",
              "postal_code": "94105-2241",
              "linkedin_uid": "18511550",
              "crunchbase_url": null,
              "phone": "+1(202) 374-1312",
              "facebook_url": "https://www.facebook.com/MeetApollo",
              "angellist_url": null,
              "retail_location_count": 0,
              "blog_url": null,
              "persona_counts": {},
              "industry": "information technology & services",
              "country": "United States",
              "keywords": [
                "sales engagement",
                "lead generation",
                "predictive analytics",
                "lead scoring",
                "sales strategy",
                "conversation intelligence",
                "sales enablement",
                "lead routing",
                "sales development",
                "email engagement",
                "revenue intelligence",
                "sales operations",
                "demand generation"
              ],
              "name": "Apollo.io",
              "snippets_loaded": true,
              "primary_domain": "apollo.io",
              "state": "California",
              "estimated_num_employees": 400,
              "website_url": "http://www.apollo.io"
            },
            "organization_id": "5e66b6381e05b4008c8331b8",
            "phone_numbers": [
              {
                "dnc_status": null,
                "position": 0,
                "raw_number": "+1(202) 374-1312",
                "sanitized_number": "+12023741312",
                "status": "no_status",
                "type": "work_hq"
              }
            ],
            "photo_url": "https://media.licdn.com/dms/image/C5603AQGiphGg4YXw4Q/profile-displayphoto-shrink_200_200/0/1527618224366?e=1681344000&v=beta&t=sJWO_glEAQGRMEVcKPamz4EDT88FN6dOBPYpARgLaHM",
            "revealed_for_current_team": true,
            "show_intent": false,
            "state": "California",
            "title": "Founder & CEO",
            "twitter_url": null
          }
        ],
        "missing_records": 0,
        "status": "success",
        "total_requested_enrichments": 1,
        "unique_enriched_records": 1
      }
    >
  end

  defp search_response do
    ~s<
      {
      "breadcrumbs": [
          {
              "label": "Titles",
              "signal_field_name": "person_titles",
              "value": "sales manager",
              "display_name": "sales manager"
          },
          {
              "label": "Titles",
              "signal_field_name": "person_titles",
              "value": "engineer manager",
              "display_name": "engineer manager"
          },
          {
              "label": "Company Domains",
              "signal_field_name": "q_organization_domains",
              "value": [
                  "apollo.io",
                  "google.com"
              ],
              "display_name": "apollo.io, google.com"
          }
      ],
      "partial_results_only": false,
      "partial_results_limit": 10000,
      "pagination": {
          "page": 1,
          "per_page": 10,
          "total_entries": 1339,
          "total_pages": 134
      },
      "contacts": [],
      "people": [
          {
              "id": "618a24XXXXXXXXXXXXXXXXXX",
              "first_name": "Tim",
              "last_name": "Zheng",
              "name": "Tim Zheng",
              "linkedin_url": "http://www.linkedin.com/in/tim-zheng-677ba010",
              "title": "Founder & CEO",
              "email_status": "verified",
              "photo_url": "https://static-exp1.licdn.com/sc/h/244xhbkr7g40x6bsu4gi6q4ry",
              "twitter_url": null,
              "github_url": null,
              "facebook_url": null,
              "extrapolated_email_confidence": null,
              "headline": "Founder & CEO at Apollo",
              "email": "email_not_unlocked@domain.com",
              "employment_history": [
                  {
                      "_id": "618afbXXXXXXXXXXXXXXXXXX",
                      "created_at": "2021-11-09T22:51:18.531Z",
                      "current": true,
                      "degree": null,
                      "description": null,
                      "emails": null,
                      "end_date": null,
                      "grade_level": null,
                      "kind": null,
                      "major": null,
                      "organization_id": "5e66b6XXXXXXXXXXXXXXXXXX",
                      "organization_name": "Apollo",
                      "raw_address": null,
                      "start_date": "2015-01-01",
                      "title": "Founder & CEO",
                      "updated_at": "2021-11-09T22:51:18.531Z",
                      "id": "618afbXXXXXXXXXXXXXXXXXX",
                      "key": "618afbXXXXXXXXXXXXXXXXXX"
                  },
                  {
                      "_id": "618afbXXXXXXXXXXXXXXXXXX",
                      "created_at": "2021-11-09T22:51:18.536Z",
                      "current": false,
                      "degree": null,
                      "description": null,
                      "emails": null,
                      "end_date": "2014-01-01",
                      "grade_level": null,
                      "kind": null,
                      "major": null,
                      "organization_id": null,
                      "organization_name": "Braingenie",
                      "raw_address": null,
                      "start_date": "2011-01-01",
                      "title": "Founder & CEO",
                      "updated_at": "2021-11-09T22:51:18.536Z",
                      "id": "618afbXXXXXXXXXXXXXXXXXX",
                      "key": "618afbXXXXXXXXXXXXXXXXXX"
                  },
                  {
                      "_id": "618afbXXXXXXXXXXXXXXXXXX",
                      "created_at": "2021-11-09T22:51:18.536Z",
                      "current": false,
                      "degree": null,
                      "description": null,
                      "emails": null,
                      "end_date": "2011-01-01",
                      "grade_level": null,
                      "kind": null,
                      "major": null,
                      "organization_id": "54a22fXXXXXXXXXXXXXXXXXX",
                      "organization_name": "Citadel Investment Group",
                      "raw_address": null,
                      "start_date": "2011-01-01",
                      "title": "Investment & Trading Associate",
                      "updated_at": "2021-11-09T22:51:18.536Z",
                      "id": "618afbXXXXXXXXXXXXXXXXXX",
                      "key": "618afbXXXXXXXXXXXXXXXXXX"
                  }
              ],
              "state": "Texas",
              "city": "Austin",
              "country": "United States",
              "organization_id": "5e66b6XXXXXXXXXXXXXXXXXX",
              "organization": {
                  "id": "5e66b6XXXXXXXXXXXXXXXXXX",
                  "name": "Apollo.io",
                  "website_url": "http://www.apollo.io",
                  "blog_url": null,
                  "angellist_url": null,
                  "linkedin_url": "http://www.linkedin.com/company/apolloio",
                  "twitter_url": "https://twitter.com/MeetApollo/",
                  "facebook_url": "https://www.facebook.com/MeetApollo/",
                  "primary_phone": {
                      "number": "(202) 374-XXXX",
                      "source": "Account"
                  },
                  "languages": [],
                  "alexa_ranking": 685,
                  "phone": "(202) 374-XXXX",
                  "linkedin_uid": "185115XX",
                  "founded_year": 2015,
                  "publicly_traded_symbol": null,
                  "publicly_traded_exchange": null,
                  "logo_url": "https://apollo-server.com/uploads/pictures/6188cXXXXXXXXXXXXXXXXXXX/picture",
                  "crunchbase_url": null,
                  "primary_domain": "apollo.io",
                  "persona_counts": {}
              },
              "account_id": "616d0eXXXXXXXXXXXXXXXXXX",
              "account": {
                  "id": "616d0eXXXXXXXXXXXXXXXXXX",
                  "name": "Apollo",
                  "website_url": "http://www.apollo.io",
                  "blog_url": null,
                  "angellist_url": null,
                  "linkedin_url": "http://www.linkedin.com/company/apolloio",
                  "twitter_url": "https://twitter.com/MeetApollo/",
                  "facebook_url": "https://www.facebook.com/MeetApollo/",
                  "primary_phone": {
                      "number": "(202) 374-XXXX",
                      "source": "Account"
                  },
                  "languages": [],
                  "alexa_ranking": 685,
                  "phone": "(123) 456-XXXX",
                  "linkedin_uid": "185115XX",
                  "founded_year": 2015,
                  "publicly_traded_symbol": null,
                  "publicly_traded_exchange": null,
                  "logo_url": "https://apollo-server.com/uploads/pictures/6188cXXXXXXXXXXXXXXXXXXX/picture",
                  "crunchbase_url": null,
                  "primary_domain": "apollo.io",
                  "persona_counts": {},
                  "domain": "apollo.io",
                  "team_id": "5c1004a041f5ac0995d5f5e8",
                  "organization_id": "5e66b6XXXXXXXXXXXXXXXXXX",
                  "account_stage_id": "5c1004XXXXXXXXXXXXXXXXXX",
                  "source": "crm",
                  "original_source": "crm",
                  "owner_id": null,
                  "created_at": "2021-10-18T06:03:45.774Z",
                  "phone_status": "no_status",
                  "test_predictive_score": null,
                  "hubspot_id": "699261XXXX",
                  "salesforce_id": null,
                  "crm_owner_id": "511281XX",
                  "parent_account_id": null,
                  "sanitized_phone": "+112345XXXXX",
                  "account_playbook_statuses": [],
                  "existence_level": "full",
                  "label_ids": [],
                  "typed_custom_fields": {},
                  "modality": "account",
                  "hubspot_record_url": "https://app.hubspot.com/sales/25200013/company/699261XXXX",
                  "salesloft_id": "233684XX",
                  "salesloft_url": "https://app.salesloft.com/app/company/233684XX"
              }
          }
      ]
    }
    >
  end
end
