defmodule ApolloIoTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  describe "endpoints" do
    test "organization enrich" do
      ApolloIo.OrganizationEnrichmentMock
      |> expect(:post_request, fn _domain -> organization() end)

      assert ApolloIo.organization_enrich("patagonia.com") ==
               organization()
    end

    test "people enrich" do
      ApolloIo.PeopleEnrichmentMock
      |> expect(:post_request, fn _map -> people() end)

      assert ApolloIo.people_enrich(%{first_name: "James", last_name: "Cameroon"}) ==
               people()
    end

    test "search" do
      ApolloIo.SearchMock
      |> expect(:post_request, fn _map -> search() end)

      assert ApolloIo.search(%{
               person_titles: ["sales director", "engineer manager"],
               q_organization_domains: "google.com\nfacebook.com",
               page: 1
             }) ==
               search()
    end
  end

  def organization do
    {:ok,
     %{
       "organization" => %{
         "latest_funding_stage" => nil,
         "alexa_ranking" => 4596,
         "id" => "54a1273b69702dab37f05700",
         "annual_revenue_printed" => "1000.0M",
         "languages" => ["English"],
         "seo_description" =>
           "Patagonia is a designer of outdoor clothing and gear for the silent sports: climbing, surfing, skiing and snowboarding, fly fishing, and trail running",
         "suborganizations" => [],
         "street_address" => "259 West Santa Clara Street",
         "publicly_traded_symbol" => nil,
         "current_technologies" => [
           %{
             "category" => "Content Delivery Networks",
             "name" => "Akamai",
             "uid" => "akamai"
           },
           %{
             "category" => "Web Performance Monitoring",
             "name" => "Akamai RUM",
             "uid" => "akamai_rum"
           },
           %{
             "category" => "Email Delivery",
             "name" => "Amazon SES",
             "uid" => "amazon_ses"
           },
           %{"category" => "Payments", "name" => "Apple Pay", "uid" => "apple_pay"},
           %{
             "category" => "CMS",
             "name" => "Atlassian Cloud",
             "uid" => "atlassian_cloud"
           },
           %{
             "category" => "CSS and JavaScript Libraries",
             "name" => "Bootstrap Framework",
             "uid" => "bootstrap_framework"
           },
           %{
             "category" => "Cloud Services",
             "name" => "Cloudinary",
             "uid" => "cloudinary"
           },
           %{
             "category" => "E-commerce Platforms",
             "name" => "Demandware",
             "uid" => "demandware"
           },
           %{
             "category" => "Analytics and Tracking",
             "name" => "Demandware Analytics",
             "uid" => "demandware_analytics"
           },
           %{"category" => "Comments", "name" => "Disqus", "uid" => "disqus"},
           %{
             "category" => "Marketing Automation",
             "name" => "Drip",
             "uid" => "drip"
           },
           %{
             "category" => "Email Marketing",
             "name" => "ExactTarget",
             "uid" => "exacttarget"
           },
           %{
             "category" => "Retargeting",
             "name" => "Facebook Custom Audiences",
             "uid" => "facebook_web_custom_audiences"
           },
           %{
             "category" => "Social Login",
             "name" => "Facebook Login (Connect)",
             "uid" => "facebook_login"
           },
           %{
             "category" => "Widgets",
             "name" => "Facebook Widget",
             "uid" => "facebook_widget"
           },
           %{
             "category" => "Analytics and Tracking",
             "name" => "Google Analytics",
             "uid" => "google_analytics"
           },
           %{
             "category" => "Fonts",
             "name" => "Google Font API",
             "uid" => "google_font_api"
           },
           %{"category" => "Other", "name" => "Google Maps", "uid" => "google_maps"},
           %{
             "category" => "Other",
             "name" => "Google Places",
             "uid" => "google_places"
           },
           %{
             "category" => "Tag Management",
             "name" => "Google Tag Manager",
             "uid" => "google_tag_manager"
           },
           %{
             "category" => "Analytics and Tracking",
             "name" => "HeapAnalytics",
             "uid" => "heapanalytics"
           },
           %{
             "category" => "Analytics and Tracking",
             "name" => "Hotjar",
             "uid" => "hotjar"
           },
           %{
             "category" => "CSS and JavaScript Libraries",
             "name" => "JQuery 2.1.1",
             "uid" => "jquery_2_1_1"
           },
           %{
             "category" => "Hosting",
             "name" => "Microsoft Azure Hosting",
             "uid" => "microsoft"
           },
           %{
             "category" => "Other",
             "name" => "Microsoft Office 365",
             "uid" => "office_365"
           },
           %{
             "category" => "Other",
             "name" => "Mobile Friendly",
             "uid" => "mobile_friendly"
           },
           %{
             "category" => "Online Testing Platforms",
             "name" => "Monetate",
             "uid" => "monetate"
           },
           %{
             "category" => "Web Performance Monitoring",
             "name" => "New Relic",
             "uid" => "new_relic"
           },
           %{"category" => "Load Balancers", "name" => "Nginx", "uid" => "nginx"},
           %{"category" => "Widgets", "name" => "OneTrust", "uid" => "onetrust"},
           %{
             "category" => "Email Providers",
             "name" => "Outlook",
             "uid" => "outlook"
           },
           %{"category" => "CMS", "name" => "Pantheon", "uid" => "pantheon"},
           %{
             "category" => "CSS and JavaScript Libraries",
             "name" => "React Redux",
             "uid" => "react_redux"
           },
           %{
             "category" => "Customer Relationship Management",
             "name" => "Salesforce",
             "uid" => "salesforce"
           },
           %{
             "category" => "E-commerce Platforms",
             "name" => "Salesforce Commerce Cloud"
           },
           %{"category" => "Chats"}
         ],
         "publicly_traded_exchange" => nil,
         "logo_url" =>
           "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/63937b46b26cd9000120cce2/picture",
         "linkedin_url" => "http://www.linkedin.com/company/patagonia_2",
         "primary_phone" => %{"number" => "+1-805-643-8616", "source" => "Owler"},
         "num_suborganizations" => 0,
         "founded_year" => 1973,
         "city" => "Ventura",
         "sanitized_phone" => "+18056438616",
         "industry_tag_id" => "5567ced173696450cb580000",
         "twitter_url" => "https://twitter.com/patagonia",
         "raw_address" => "259 W. Santa Clara Street, Ventura, California 93001, US",
         "postal_code" => "93001",
         "linkedin_uid" => "665858",
         "crunchbase_url" => nil,
         "phone" => "+1-805-643-8616",
         "facebook_url" => "https://facebook.com/PATAGONIA",
         "total_funding_printed" => nil,
         "angellist_url" => nil,
         "technology_names" => [
           "Akamai",
           "Akamai RUM",
           "Amazon SES",
           "Apple Pay",
           "Atlassian Cloud",
           "Bootstrap Framework",
           "Cloudinary",
           "Demandware",
           "Demandware Analytics",
           "Disqus",
           "Drip",
           "ExactTarget",
           "Facebook Custom Audiences",
           "Facebook Login (Connect)",
           "Facebook Widget",
           "Google Analytics",
           "Google Font API",
           "Google Maps"
         ],
         "annual_revenue" => 9.99999e8,
         "retail_location_count" => 33,
         "blog_url" => nil,
         "persona_counts" => %{},
         "industry" => "retail",
         "country" => "United States",
         "keywords" => ["outdoor gear", "shopping", "sporting goods", "sports wear"],
         "funding_events" => [],
         "departmental_head_count" => %{
           "accounting" => 28,
           "administrative" => 0,
           "arts_and_design" => 42,
           "business_development" => 35,
           "consulting" => 13,
           "data_science" => 10,
           "education" => 21,
           "engineering" => 74,
           "entrepreneurship" => 4
         },
         "latest_funding_round_date" => nil,
         "short_description" =>
           "Patagonia operates as a clothing and apparel firm that offers yoga, hiking, skiing, snowboarding, surfing and trail running clothes.",
         "owned_by_organization_id" => nil,
         "total_funding" => nil,
         "name" => "Patagonia",
         "snippets_loaded" => true,
         "primary_domain" => "patagonia.com",
         "state" => "California",
         "estimated_num_employees" => 2900
       }
     }}
  end

  defp people do
    {:ok,
     %{
       "person" => %{
         "email" => nil,
         "email_status" => nil,
         "employment_history" => [],
         "extrapolated_email_confidence" => 0.0,
         "facebook_url" => nil,
         "first_name" => "James",
         "github_url" => nil,
         "headline" => nil,
         "id" => "639b62a01a1ef000a3902c0c",
         "intent_strength" => nil,
         "last_name" => "Cameroon",
         "linkedin_url" => nil,
         "name" => "James Cameroon",
         "organization_id" => nil,
         "photo_url" => nil,
         "revealed_for_current_team" => true,
         "show_intent" => false,
         "title" => nil,
         "twitter_url" => nil
       }
     }}
  end

  defp search do
    {:ok,
     %{
       "breadcrumbs" => [
         %{
           "display_name" => "sales director",
           "label" => "Titles",
           "signal_field_name" => "person_titles",
           "value" => "sales director"
         },
         %{
           "display_name" => "engineer manager",
           "label" => "Titles",
           "signal_field_name" => "person_titles",
           "value" => "engineer manager"
         },
         %{
           "display_name" => "google.com, facebook.com",
           "label" => "Company Domains",
           "signal_field_name" => "q_organization_domains",
           "value" => ["google.com", "facebook.com"]
         }
       ],
       "contacts" => [],
       "disable_eu_prospecting" => false,
       "model_ids" => [
         "54a43dfd7468693b8c1e9a37",
         "60648101ae838a0001180bc5",
         "603f419e9877940001263fa2",
         "5e7edc6615cdce00019817ad",
         "54a63b707468693442bfd9cc",
         "5f0fcb40871e100001177e5f",
         "54a276397468693fda9ae824",
         "57df55a3a6da980b53df8552",
         "5b3f3761a6da98f1ca086a21",
         "5dd6fe148b4d4c000101f6be"
       ],
       "num_fetch_result" => nil,
       "pagination" => %{
         "page" => 1,
         "per_page" => 10,
         "total_entries" => 799,
         "total_pages" => 80
       },
       "partial_results_limit" => 10000,
       "partial_results_only" => false,
       "people" => [
         %{
           "city" => nil,
           "country" => "Taiwan",
           "email" => "dennis.hsieh@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "63925d4297316f00cb745056",
               "created_at" => "2022-12-08T21:55:14.039Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "63925d4297316f00cb745056",
               "key" => "63925d4297316f00cb745056",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => nil,
               "title" => "Sales Director",
               "updated_at" => "2022-12-08T21:55:14.039Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Dennis",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "54a43dfd7468693b8c1e9a37",
           "intent_strength" => nil,
           "last_name" => "Hsieh",
           "linkedin_url" => "http://www.linkedin.com/in/dennis-hsieh-b0329549",
           "name" => "Dennis Hsieh",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com",
             "primary_phone" => %{
               "number" => "+1 650-253-0000",
               "source" => "Account"
             },
             "publicly_traded_exchange" => "nasdaq",
             "publicly_traded_symbol" => "GOOG",
             "sanitized_phone" => "+16502530000",
             "twitter_url" => "http://twitter.com/Cat5BoatShoes.com",
             "website_url" => "http://www.google.com"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" => "https://static-exp1.licdn.com/sc/h/djzv59yelk5urv2ujlazfyvrk",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => nil,
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => "Salt Lake City",
           "country" => "United States",
           "email" => "dbaer@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "635baded93b41900a39d0549",
               "created_at" => "2022-10-28T10:24:45.010Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "635baded93b41900a39d0549",
               "key" => "635baded93b41900a39d0549",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2021-03-01",
               "title" => "Director, Sales",
               "updated_at" => "2022-11-01T14:08:17.038Z"
             },
             %{
               "_id" => "63889b9c1bd5d00001f9780c",
               "created_at" => "2022-12-01T12:18:36.954Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2021-03-01",
               "grade_level" => nil,
               "id" => "63889b9c1bd5d00001f9780c",
               "key" => "63889b9c1bd5d00001f9780c",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2016-04-01",
               "title" => "National Head of Sales",
               "updated_at" => "2022-12-01T12:18:36.954Z"
             },
             %{
               "_id" => "63889b9c1bd5d00001f9780d",
               "created_at" => "2022-12-01T12:18:36.954Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2016-04-01",
               "grade_level" => nil,
               "id" => "63889b9c1bd5d00001f9780d",
               "key" => "63889b9c1bd5d00001f9780d",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2013-06-01",
               "title" => "Head of Business Operations, Google Fiber- Utah",
               "updated_at" => "2022-12-01T12:18:36.954Z"
             },
             %{
               "_id" => "63889b9c1bd5d00001f9780e",
               "created_at" => "2022-12-01T12:18:36.954Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2011-07-01",
               "grade_level" => nil,
               "id" => "63889b9c1bd5d00001f9780e",
               "key" => "63889b9c1bd5d00001f9780e",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "54a11ba769702da425e05000",
               "organization_name" => "OrangeSoda.com",
               "raw_address" => nil,
               "start_date" => "2011-01-01",
               "title" => "Director of Direct and Channel Sales",
               "updated_at" => "2022-12-01T12:18:36.954Z"
             },
             %{
               "_id" => "63889b9c1bd5d00001f9780f",
               "created_at" => "2022-12-01T12:18:36.954Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2011-01-01",
               "grade_level" => nil,
               "id" => "63889b9c1bd5d00001f9780f",
               "key" => "63889b9c1bd5d00001f9780f",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "54a11ba769702da425e05000",
               "organization_name" => "OrangeSoda.com",
               "raw_address" => nil,
               "start_date" => "2008-07-01",
               "title" => "Sales Manager",
               "updated_at" => "2022-12-01T12:18:36.954Z"
             },
             %{
               "_id" => "63889b9c1bd5d00001f97810",
               "created_at" => "2022-12-01T12:18:36.954Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2008-07-01",
               "grade_level" => nil,
               "id" => "63889b9c1bd5d00001f97810",
               "key" => "63889b9c1bd5d00001f97810",
               "kind" => nil,
               "major" => nil,
               "organization_id" => nil,
               "organization_name" => "Briton Security",
               "raw_address" => nil,
               "start_date" => "2006-09-01",
               "title" => "Co Founder",
               "updated_at" => "2022-12-01T12:18:36.954Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Devin",
           "github_url" => nil,
           "headline" => "Director, Sales at Google",
           "id" => "54a63b707468693442bfd9cc",
           "intent_strength" => nil,
           "last_name" => "Baer",
           "linkedin_url" => "http://www.linkedin.com/in/devin-baer-12a60314",
           "name" => "Devin Baer",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com",
             "primary_phone" => %{
               "number" => "+1 650-253-0000",
               "source" => "Account"
             },
             "publicly_traded_exchange" => "nasdaq",
             "publicly_traded_symbol" => "GOOG",
             "sanitized_phone" => "+16502530000",
             "twitter_url" => "http://twitter.com/Cat5BoatShoes.com"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" =>
             "https://media-exp1.licdn.com/dms/image/C5603AQHtsD8cRLLKVg/profile-displayphoto-shrink_400_400/0/1581931262724?e=1672272000&v=beta&t=1Q5fR4V0Sk4zXOSFPR8OHLohHWTYsmExeBzx70sMXSs",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "Utah",
           "title" => "Director, Sales",
           "twitter_url" => "https://twitter.com/devinbaer"
         },
         %{
           "city" => "Madrid",
           "country" => "Spain",
           "email" => "saez@fb.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "6399707e03e63300a3d44eff",
               "created_at" => "2022-12-14T06:43:10.219Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "6399707e03e63300a3d44eff",
               "key" => "6399707e03e63300a3d44eff",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "559226da736964191e149b00",
               "organization_name" => "Meta",
               "raw_address" => nil,
               "start_date" => "2021-09-01",
               "title" => "Sales Director",
               "updated_at" => "2022-12-14T06:43:10.219Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a3",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2021-09-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a3",
               "key" => "6399707ecb79270001f953a3",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "559226da736964191e149b00",
               "organization_name" => "Meta",
               "raw_address" => nil,
               "start_date" => "2019-10-01",
               "title" => "Sales Director",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a4",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2019-10-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a4",
               "key" => "6399707ecb79270001f953a4",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "559226da736964191e149b00",
               "organization_name" => "Meta",
               "raw_address" => nil,
               "start_date" => "2017-10-01",
               "title" => "Head of  Sales,  CPG, Automotive and Travel Industries",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a5",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2016-10-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a5",
               "key" => "6399707ecb79270001f953a5",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2015-01-01",
               "title" => "Global Client Lead - Global Accounts - CPG",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a6",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2015-04-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a6",
               "key" => "6399707ecb79270001f953a6",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2013-04-01",
               "title" => "Industry Leader - Automotive, CPG & Business Industrials",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a7",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2013-07-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a7",
               "key" => "6399707ecb79270001f953a7",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2010-08-01",
               "title" => "Industry Head - Finance",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a8",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2010-08-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a8",
               "key" => "6399707ecb79270001f953a8",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "54a121d569702d8ed41ae402",
               "organization_name" => "Telefonica de España",
               "raw_address" => nil,
               "start_date" => "2006-07-01",
               "title" => "Head of Business Development & Marketing Telefonica / Terra.es",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953a9",
               "created_at" => "2022-12-14T06:43:10.799Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2006-07-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953a9",
               "key" => "6399707ecb79270001f953a9",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "54a11c1069702d9a8b978100",
               "organization_name" => "Correos y Telegrafos",
               "raw_address" => nil,
               "start_date" => "2003-07-01",
               "title" => "e-Business Director",
               "updated_at" => "2022-12-14T06:43:10.799Z"
             },
             %{
               "_id" => "6399707ecb79270001f953aa",
               "created_at" => "2022-12-14T06:43:10.800Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2003-07-01",
               "grade_level" => nil,
               "id" => "6399707ecb79270001f953aa",
               "key" => "6399707ecb79270001f953aa",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "559209bb736964186a883100",
               "organization_name" => "Banco Santander",
               "raw_address" => nil,
               "start_date" => "2000-10-01",
               "title" => "e-Business -  Team Lead",
               "updated_at" => "2022-12-14T06:43:10.800Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "David",
           "github_url" => nil,
           "headline" => "Sales Director at Meta (Facebook)",
           "id" => "603f419e9877940001263fa2",
           "intent_strength" => nil,
           "last_name" => "Saez",
           "linkedin_url" => "http://www.linkedin.com/in/davidsaezgomezdelatorre",
           "name" => "David Saez",
           "organization" => %{
             "alexa_ranking" => 4,
             "angellist_url" => "http://angel.co/facebook",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "http://www.facebook.com/facebookcareers",
             "founded_year" => 2004,
             "id" => "559226da736964191e149b00",
             "languages" => [],
             "linkedin_uid" => "10667",
             "linkedin_url" => "http://www.linkedin.com/company/meta",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/639b29971a52280001a7d155/picture",
             "market_cap" => "434.2B",
             "name" => "Meta",
             "persona_counts" => %{},
             "phone" => "+1 650-543-4800",
             "primary_domain" => "facebook.com",
             "primary_phone" => %{
               "number" => "+1 650-543-4800",
               "source" => "Account"
             },
             "publicly_traded_exchange" => "nyse",
             "publicly_traded_symbol" => "FB",
             "sanitized_phone" => "+16505434800"
           },
           "organization_id" => "559226da736964191e149b00",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-543-4800",
               "sanitized_number" => "+16505434800",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" =>
             "https://media.licdn.com/dms/image/C4E03AQHS5TnecNJwIg/profile-displayphoto-shrink_200_200/0/1516215596072?e=1676505600&v=beta&t=pvn5RlVELRJ8doDMSAfJY6D5LN1gTvY0DXKeZ5hFt5k",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "Community of Madrid",
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => nil,
           "country" => "United States",
           "email" => "rgoyal@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "63455c02faafb300012d5deb",
               "created_at" => "2022-10-11T12:05:22.662Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "63455c02faafb300012d5deb",
               "key" => "63455c02faafb300012d5deb",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2014-07-01",
               "title" => "Sales Director",
               "updated_at" => "2022-12-05T15:40:23.935Z"
             },
             %{
               "_id" => "638e10e7bf4e72000104d323",
               "created_at" => "2022-12-05T15:40:23.908Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2014-07-01",
               "grade_level" => nil,
               "id" => "638e10e7bf4e72000104d323",
               "key" => "638e10e7bf4e72000104d323",
               "kind" => nil,
               "major" => nil,
               "organization_id" => nil,
               "organization_name" => "Jonovo",
               "raw_address" => nil,
               "start_date" => "2012-09-01",
               "title" => "VP of Sales",
               "updated_at" => "2022-12-05T15:40:23.908Z"
             },
             %{
               "_id" => "638e10e7bf4e72000104d324",
               "created_at" => "2022-12-05T15:40:23.908Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2012-10-01",
               "grade_level" => nil,
               "id" => "638e10e7bf4e72000104d324",
               "key" => "638e10e7bf4e72000104d324",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f68b9291f1604008c1291c8",
               "organization_name" => "Yahoo",
               "raw_address" => nil,
               "start_date" => "2008-03-01",
               "title" => "Sales Manager",
               "updated_at" => "2022-12-05T15:40:23.908Z"
             },
             %{
               "_id" => "638e10e7bf4e72000104d325",
               "created_at" => "2022-12-05T15:40:23.908Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2008-03-01",
               "grade_level" => nil,
               "id" => "638e10e7bf4e72000104d325",
               "key" => "638e10e7bf4e72000104d325",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f40a4fece6f950001f3be64",
               "organization_name" => "Nabisco",
               "raw_address" => nil,
               "start_date" => "2006-08-01",
               "title" => "Sales Associate",
               "updated_at" => "2022-12-05T15:40:23.908Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Rajiv",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "5b3f3761a6da98f1ca086a21",
           "intent_strength" => nil,
           "last_name" => "Goyal",
           "linkedin_url" => "http://www.linkedin.com/in/rajiv-goyal-09b910a8",
           "name" => "Rajiv Goyal",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com",
             "primary_phone" => %{
               "number" => "+1 650-253-0000",
               "source" => "Account"
             },
             "publicly_traded_exchange" => "nasdaq",
             "publicly_traded_symbol" => "GOOG"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" =>
             "https://media-exp1.licdn.com/dms/image/C4E03AQGoYTpMagfl3w/profile-displayphoto-shrink_200_200/0/1517513217932?e=2147483647&v=beta&t=tmW_xckDqqSB2IBplRwo7A6pkeTe7X5DeI8zXOraPH4",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => nil,
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => nil,
           "country" => "China",
           "email" => "kentwang@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "63850bfc5d9cea00a3f77b6c",
               "created_at" => "2022-11-28T19:29:00.032Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "63850bfc5d9cea00a3f77b6c",
               "key" => "63850bfc5d9cea00a3f77b6c",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2009-06-01",
               "title" => "Sales Director",
               "updated_at" => "2022-11-28T19:29:00.032Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Kent",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "57df55a3a6da980b53df8552",
           "intent_strength" => nil,
           "last_name" => "Wang",
           "linkedin_url" => "http://www.linkedin.com/in/kent-wang-70b46135",
           "name" => "Kent Wang",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com",
             "primary_phone" => %{"number" => "+1 650-253-0000"},
             "publicly_traded_exchange" => "nasdaq"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" =>
             "https://media-exp1.licdn.com/dms/image/C5603AQF3NU5UUV_wdA/profile-displayphoto-shrink_200_200/0/1516586402143?e=1675296000&v=beta&t=x88NkKV3vpChw_mfU-1-9kUebgyQDlg7BvriXXRJWiw",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => nil,
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => "San Francisco",
           "country" => "United States",
           "email" => "mskilton@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "639975bf57783300a3260c83",
               "created_at" => "2022-12-14T07:05:35.726Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "639975bf57783300a3260c83",
               "key" => "639975bf57783300a3260c83",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2019-12-01",
               "title" => "Sales Director",
               "updated_at" => "2022-12-14T07:05:35.726Z"
             },
             %{
               "_id" => "639975c0d4ff3e00018d0fa3",
               "created_at" => "2022-12-14T07:05:36.031Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2019-12-01",
               "grade_level" => nil,
               "id" => "639975c0d4ff3e00018d0fa3",
               "key" => "639975c0d4ff3e00018d0fa3",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5569502d73696425e2230200",
               "organization_name" => "Adobe",
               "raw_address" => nil,
               "start_date" => "2019-04-01",
               "title" => "Sr. Account Executive - Adobe Experience Cloud",
               "updated_at" => "2022-12-14T07:05:36.031Z"
             },
             %{
               "_id" => "639975c0d4ff3e00018d0fa4",
               "created_at" => "2022-12-14T07:05:36.031Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2019-03-01",
               "grade_level" => nil,
               "id" => "639975c0d4ff3e00018d0fa4",
               "key" => "639975c0d4ff3e00018d0fa4",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f4b59afe97c20000169a595",
               "organization_name" => "SAP",
               "raw_address" => nil,
               "start_date" => "2003-11-01",
               "title" => "Vice President, SAP",
               "updated_at" => "2022-12-14T07:05:36.031Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Matthew",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "54a276397468693fda9ae824",
           "intent_strength" => nil,
           "last_name" => "Skilton",
           "linkedin_url" => "http://www.linkedin.com/in/matthewskilton",
           "name" => "Matthew Skilton",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" =>
             "https://media.licdn.com/dms/image/C4E03AQH5S9bBAVI5Lg/profile-displayphoto-shrink_200_200/0/1516301379277?e=1676505600&v=beta&t=5AlQptjFCQsu-7VISPxNmwPkLpKD_fTQfkIu0XOGIJo",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "California",
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => nil,
           "country" => "Republic of the Union of Myanmar",
           "email" => "km@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "6128ebd13e2f3e00a40a4f53",
               "created_at" => "2021-08-27T13:42:41.507Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "6128ebd13e2f3e00a40a4f53",
               "key" => "6128ebd13e2f3e00a40a4f53",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => nil,
               "title" => "Sales Director",
               "updated_at" => "2021-08-27T13:42:41.507Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Km",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "5dd6fe148b4d4c000101f6be",
           "intent_strength" => nil,
           "last_name" => nil,
           "linkedin_url" => "http://www.linkedin.com/in/km-ms-a32202146",
           "name" => "Km",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000",
             "primary_domain" => "google.com"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" => "https://static-exp1.licdn.com/sc/h/244xhbkr7g40x6bsu4gi6q4ry",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => nil,
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => "Shanghai",
           "country" => "China",
           "email" => "samong@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "6384fd9b77fe7a008bf73420",
               "created_at" => "2022-11-28T18:27:39.583Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "6384fd9b77fe7a008bf73420",
               "key" => "6384fd9b77fe7a008bf73420",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "谷歌",
               "raw_address" => nil,
               "start_date" => "2012-06-01",
               "title" => "Director of Sales",
               "updated_at" => "2022-11-28T18:27:39.583Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Sam",
           "github_url" => nil,
           "headline" => "Sales.Market",
           "id" => "5e7edc6615cdce00019817ad",
           "intent_strength" => nil,
           "last_name" => "Ong",
           "linkedin_url" => "http://www.linkedin.com/in/sam-ong-50a29029",
           "name" => "Sam Ong",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{},
             "phone" => "+1 650-253-0000"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" => "https://static-exp1.licdn.com/sc/h/244xhbkr7g40x6bsu4gi6q4ry",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "Shanghai",
           "title" => "Director of Sales",
           "twitter_url" => nil
         },
         %{
           "city" => "Denver",
           "country" => "United States",
           "email" => "smithdave@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "63624d2551a21a00a382a013",
               "created_at" => "2022-11-02T10:57:41.658Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "63624d2551a21a00a382a013",
               "key" => "63624d2551a21a00a382a013",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => nil,
               "title" => "Sales Director",
               "updated_at" => "2022-11-02T10:57:41.658Z"
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Dave",
           "github_url" => nil,
           "headline" => "Sales Director at Google",
           "id" => "5f0fcb40871e100001177e5f",
           "intent_strength" => nil,
           "last_name" => "Smith",
           "linkedin_url" => "http://www.linkedin.com/in/dave-smith-135b4318",
           "name" => "Dave Smith",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google",
             "persona_counts" => %{}
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" => "https://static-exp1.licdn.com/sc/h/244xhbkr7g40x6bsu4gi6q4ry",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "Colorado",
           "title" => "Sales Director",
           "twitter_url" => nil
         },
         %{
           "city" => "Mexico City",
           "country" => "Mexico",
           "email" => "frl@google.com",
           "email_status" => "verified",
           "employment_history" => [
             %{
               "_id" => "6378aa4cde8d3a00017ee110",
               "created_at" => "2022-11-19T10:05:00.898Z",
               "current" => true,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => nil,
               "grade_level" => nil,
               "id" => "6378aa4cde8d3a00017ee110",
               "key" => "6378aa4cde8d3a00017ee110",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5fc93db64c38d300d6aa24e6",
               "organization_name" => "Google",
               "raw_address" => nil,
               "start_date" => "2021-05-01",
               "title" => "Sales Director",
               "updated_at" => "2022-11-19T10:05:02.148Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee133",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2021-04-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee133",
               "key" => "6378aa4dde8d3a00017ee133",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5a9f506ea6da98d99781eff8",
               "organization_name" => "Salesforce",
               "raw_address" => nil,
               "start_date" => "2017-01-01",
               "title" => "Regional Vice President, Enterprise Sales",
               "updated_at" => "2022-11-19T10:05:01.788Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee134",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2017-01-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee134",
               "key" => "6378aa4dde8d3a00017ee134",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "56dd0d18f3e5bb1ac9000fea",
               "organization_name" => "Hewlett Packard Enterprise",
               "raw_address" => nil,
               "start_date" => "2015-06-01",
               "title" => "Mexico Sales Manager, Enterprise Services",
               "updated_at" => "2022-11-19T10:05:01.788Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee135",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2015-06-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee135",
               "key" => "6378aa4dde8d3a00017ee135",
               "kind" => nil,
               "major" => nil,
               "organization_id" => nil,
               "organization_name" => "Grupo ASSA",
               "raw_address" => nil,
               "start_date" => "2012-11-01",
               "title" => "Country Manager",
               "updated_at" => "2022-11-19T10:05:01.788Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee136",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2012-11-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee136",
               "key" => "6378aa4dde8d3a00017ee136",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "54a1215b69702d84c503b802",
               "organization_name" => "Lenovo",
               "raw_address" => nil,
               "start_date" => "2012-01-01",
               "title" => "Global Accounts Director LAS (Latin America Spanish)",
               "updated_at" => "2022-11-19T10:05:01.788Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee137",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2012-01-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee137",
               "key" => "6378aa4dde8d3a00017ee137",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f4b59afe97c20000169a595",
               "organization_name" => "SAP",
               "raw_address" => nil,
               "start_date" => "2007-04-01",
               "title" => "Sales Director",
               "updated_at" => "2022-11-19T10:05:01.788Z"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee138",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2007-03-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee138",
               "key" => "6378aa4dde8d3a00017ee138",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f4b59afe97c20000169a595",
               "organization_name" => "SAP",
               "raw_address" => nil,
               "start_date" => "2004-01-01",
               "title" => "Director, SAP Education"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee139",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "2003-12-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee139",
               "key" => "6378aa4dde8d3a00017ee139",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5f4b59afe97c20000169a595",
               "organization_name" => "SAP",
               "raw_address" => nil,
               "start_date" => "1998-09-01"
             },
             %{
               "_id" => "6378aa4dde8d3a00017ee13a",
               "created_at" => "2022-11-19T10:05:01.788Z",
               "current" => false,
               "degree" => nil,
               "description" => nil,
               "emails" => nil,
               "end_date" => "1998-08-01",
               "grade_level" => nil,
               "id" => "6378aa4dde8d3a00017ee13a",
               "key" => "6378aa4dde8d3a00017ee13a",
               "kind" => nil,
               "major" => nil,
               "organization_id" => "5d33d0d1a3ae6113e19b1674",
               "organization_name" => "IBM",
               "raw_address" => nil
             }
           ],
           "extrapolated_email_confidence" => nil,
           "facebook_url" => nil,
           "first_name" => "Fernando",
           "github_url" => nil,
           "headline" => "Sales Director",
           "id" => "60648101ae838a0001180bc5",
           "intent_strength" => nil,
           "last_name" => "Rodriguez",
           "linkedin_url" => "http://www.linkedin.com/in/rodriguezlopezfernando",
           "name" => "Fernando Rodriguez",
           "organization" => %{
             "alexa_ranking" => 1,
             "angellist_url" => "http://angel.co/category-five",
             "blog_url" => nil,
             "crunchbase_url" => nil,
             "facebook_url" => "https://facebook.com/Google",
             "founded_year" => 1998,
             "id" => "5fc93db64c38d300d6aa24e6",
             "languages" => [],
             "linkedin_uid" => "1441",
             "linkedin_url" => "http://www.linkedin.com/company/google",
             "logo_url" =>
               "https://zenprospect-production.s3.amazonaws.com/uploads/pictures/6392a8088602540001a26695/picture",
             "market_cap" => "652.3B",
             "name" => "Google"
           },
           "organization_id" => "5fc93db64c38d300d6aa24e6",
           "phone_numbers" => [
             %{
               "position" => 0,
               "raw_number" => "+1 650-253-0000",
               "sanitized_number" => "+16502530000",
               "status" => "no_status",
               "type" => "work_hq"
             }
           ],
           "photo_url" => "https://static-exp1.licdn.com/sc/h/244xhbkr7g40x6bsu4gi6q4ry",
           "revealed_for_current_team" => true,
           "show_intent" => true,
           "state" => "Mexico City",
           "title" => "Sales Director",
           "twitter_url" => nil
         }
       ]
     }}
  end
end
