defmodule Fixtures do
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
end
